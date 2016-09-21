//
//  TestApiManager.m
//  CXNetworkUntilDemo
//
//  Created by mac on 16/9/20.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "TestApiManager.h"
#import "RequestHeader.h"
@interface TestApiManager ()<CXAPIManagerValidator>
    
@end


@implementation TestApiManager
#pragma mark - life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.validator = self;
    }
    return self;
}
    
    
#pragma mark - CXAPIManager
- (NSString *)methodName {
    return ProjectListSearch;
}
- (CXAPIManagerRequestType)requestType {
    return CXAPIManagerRequestTypePOST;
}
#pragma mark - CXAPIManagerValidator
- (BOOL)manager:(CXAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
    {
        return YES;
    }
    
- (BOOL)manager:(CXAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
    {
//        if ([data[@"status"] isEqualToString:@"0"]) {
//            return NO;
//        }
        
        return YES;
    }

@end
