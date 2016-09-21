//
//  NSString+URLString_Append.h
//  Crowd
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 CES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLString_Append)

+ (NSString *)urlStringAppendWithBaseUrl:(NSString *)baseUrl
                                        methodName:(NSString *)methodName;

@end
