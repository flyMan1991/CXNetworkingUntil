//
//  CXAPIBaseManager.m
//  Crowd
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "CXAPIBaseManager.h"
#import "CXURLResponse.h"
#import "AFNetworking.h"
#import "CXApiProxy.h"
#import "CXAppNetworkingStatus.h"

@interface CXAPIBaseManager ()
@property (nonatomic, strong, readwrite) id fetchedRawData;


@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) CXAPIManagerErrorType errorType;
@end


@implementation CXAPIBaseManager
#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = CXAPIManagerErrorTypeDefault;
        // 确定self是否实现了某个协议,如何实现了这个协议,那么本身就符合这个协议的对象
        if ([self conformsToProtocol:@protocol(CXAPIManager)]) {
            self.child = (id<CXAPIManager>)self;
        }else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
        
    }
    return self;
}

#pragma mark - public methods
- (id)fetchDataWithReformer:(id<CXAPIManagerDataReformer>)reformer {
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    }else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}
#pragma mark - calling api
- (void)loadData {
    // 先开启网络监测状态
      AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    NSDictionary * params = [self.paramSource paramsForApi:self];
    [self loadDataWithParams:params];
}
- (void)loadDataWithParams:(NSDictionary *)params {
    
    // 检查参数是否正确
    if ([self.validator manager:self isCorrectWithParamsData:params]) {
        // 检查网络是否正确
        if ([self isReachable]) {
            switch (self.child.requestType) {
                    // get请求
                case CXAPIManagerRequestTypeGET:
                    [self CX_GETRequestWithParams:params];
                    break;
                    // post请求
                case CXAPIManagerRequestTypePOST:
                    [self CX_POSTRequestWithParams:params];
                    break;
                default:
                    break;
            }
        } else {
            // 网络错误
            [self failedOnCallingAPI:nil withErrorType:CXAPIManagerErrorTypeNoNetwork];
        }
        
    }  else {
        // 参数错误
        [self failedOnCallingAPI:nil withErrorType:CXAPIManagerErrorTypeParamsError];
    }
}
#pragma mark - api callBacks
- (void)successedOnCallingAPI:(CXURLResponse *)response {
    self.response = response;
    if ([self.delegate respondsToSelector:@selector(managerCallAPIDidSuccess:)]) {
        [self.delegate managerCallAPIDidSuccess:self];
    }
}
- (void)failedOnCallingAPI:(CXURLResponse *)response  withErrorType:(CXAPIManagerErrorType )errorType {
    self.errorType = errorType;
    self.response = response;
    if ([self.delegate respondsToSelector:@selector(managerCallAPIDidFail:)]) {
        [self.delegate managerCallAPIDidFail:self];
    }
}
// 监测网络状态
- (BOOL)isReachable {
    // 网络连接状态
    BOOL isReachalility = [CXAppNetworkingStatus sharedInstance].isReachable;
    if (!isReachalility) {
        self.errorType = CXAPIManagerErrorTypeNoNetwork;
    }
    return isReachalility;
}
#pragma mark - private methods
- (void)CX_GETRequestWithParams:(NSDictionary *)params  {
    __weak typeof(self) weakSelf = self;
    [[CXApiProxy sharedInstance] callGETWithParams:params methodName:self.child.methodName success:^(CXURLResponse *response) {
         __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf successedOnCallingAPI:response];
    } fail:^(CXURLResponse *response) {
         __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf failedOnCallingAPI:response withErrorType:CXAPIManagerErrorTypeDefault];
    }];
}
- (void)CX_POSTRequestWithParams:(NSDictionary *)params {
    __weak typeof(self) weakSelf = self;
    [[CXApiProxy sharedInstance] callPOSTWithParams:params methodName:self.child.methodName success:^(CXURLResponse *response) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf successedOnCallingAPI:response];
    } fail:^(CXURLResponse *response) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf failedOnCallingAPI:response withErrorType:CXAPIManagerErrorTypeDefault];
    }];
}

@end
