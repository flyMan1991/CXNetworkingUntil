//
//  CXAppNetworkingStatus.h
//  CXNetworkUntilDemo
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 CES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXAppNetworkingStatus : NSObject

// 网络是否连通
@property (nonatomic,  assign, readonly) BOOL isReachable;

@property (nonatomic, copy) NSString * ipAndHost;

+ (instancetype)sharedInstance;


@end
