//
//  NSString+URLString_Append.m
//  Crowd
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "NSString+URLString_Append.h"

@implementation NSString (URLString_Append)
+ (NSString *)urlStringAppendWithBaseUrl:(NSString *)baseUrl
                              methodName:(NSString *)methodName  {
    
   NSString *   urlString = [NSString stringWithFormat:@"%@%@", baseUrl, methodName];
    return urlString;
}
@end
