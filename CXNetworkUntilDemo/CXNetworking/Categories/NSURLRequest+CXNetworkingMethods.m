//
//  NSURLRequest+CXNetworkingMethods.m
//  Crowd
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "NSURLRequest+CXNetworkingMethods.h"
#import <objc/runtime.h>

static void *CTNetworkingRequestParams;

@implementation NSURLRequest (CXNetworkingMethods)


- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &CTNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &CTNetworkingRequestParams);
}

@end
