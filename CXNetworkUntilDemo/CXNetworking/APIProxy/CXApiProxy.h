//
//  CXApiProxy.h
//  Crowd
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 CES. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXURLResponse;

typedef void(^AXCallback) (CXURLResponse * response);


@interface CXApiProxy : NSObject

+ (instancetype)sharedInstance;

- (void)callGETWithParams:(NSDictionary *)params  methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;
- (void)callPOSTWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;
- (void)callPUTWithParams:(NSDictionary *)params  methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;
- (void)callDELETEWithParams:(NSDictionary *)params  methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

@end
