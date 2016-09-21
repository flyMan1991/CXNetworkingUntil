//
//  CXApiProxy.m
//  Crowd
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "CXApiProxy.h"
#import "AFNetworking.h"
#import "CXRequestGenerator.h"
#import "CXURLResponse.h"


@interface CXApiProxy ()
@property (nonatomic, strong) AFHTTPSessionManager * sessionManager;
@end

@implementation CXApiProxy
#pragma mark - getters and setters
- (AFHTTPSessionManager *)sessionManager {
    if (!_sessionManager) {
        self.sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sessionManager.requestSerializer.timeoutInterval = 20.0;
    }
    return _sessionManager;
}
#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static CXApiProxy * apiProxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiProxy = [[CXApiProxy alloc] init];
    });
    return apiProxy;
}
#pragma mark - public  methods
- (void)callGETWithParams:(NSDictionary *)params  methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    NSURLRequest * request = [[CXRequestGenerator sharedInstance] generateGETRequestWithrequestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}
- (void)callPOSTWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    NSURLRequest * request = [[CXRequestGenerator sharedInstance] generatePOSTRequestWithrequestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}
- (void)callPUTWithParams:(NSDictionary *)params  methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    NSURLRequest * request = [[CXRequestGenerator sharedInstance] generatePutRequestWithrequestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}
- (void)callDELETEWithParams:(NSDictionary *)params  methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail {
    NSURLRequest * request = [[CXRequestGenerator sharedInstance] generateDeleteRequestWithrequestParams:params methodName:methodName];
    [self callApiWithRequest:request success:success fail:fail];
}
#pragma mark - public  methods 
- (void)callApiWithRequest:(NSURLRequest *)request success:(AXCallback)success fail:(AXCallback)fail {
       // 回到这里的block的时候,已经进入主线程
    __block NSURLSessionDataTask * dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
        NSData * responseData = responseObject;
        NSString * responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        if (error) {
            CXURLResponse * CXResponse = [[CXURLResponse alloc] initWithResponseString:responseString request:request responseData:responseData error:error];
            fail ? fail(CXResponse) : nil ;
        }  else {
            CXURLResponse * cxresponse = [[CXURLResponse alloc] initWithResponseString:responseString request:request responseData:responseData status:CXURLResponseStatusSuccess];
            success ? success(cxresponse) : nil ;
        }
    }];
    [dataTask resume];
}
@end
