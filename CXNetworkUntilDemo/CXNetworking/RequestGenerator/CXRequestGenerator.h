//
//  CXRequestGenerator.h
//  Crowd
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 CES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateGETRequestWithrequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
- (NSURLRequest *)generatePOSTRequestWithrequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
- (NSURLRequest *)generatePutRequestWithrequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
- (NSURLRequest *)generateDeleteRequestWithrequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;


@end
