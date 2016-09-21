//
//  CXAppNetworkingStatus.m
//  CXNetworkUntilDemo
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "CXAppNetworkingStatus.h"
#import <AFNetworking/AFNetworking.h>
@implementation CXAppNetworkingStatus

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static CXAppNetworkingStatus *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CXAppNetworkingStatus alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedInstance;
}

#pragma mark - getter / setter
- (BOOL)isReachable {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}


@end
