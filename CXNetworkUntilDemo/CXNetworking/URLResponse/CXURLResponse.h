//
//  CXURLResponse.h
//  Crowd
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 CES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXNetworkingConfiguration.h"
@interface CXURLResponse : NSObject

@property (nonatomic, copy, readonly) id content;

@property (nonatomic, assign, readonly) CXURLResponseStatus status;
@property (nonatomic, copy,  readonly) NSString * contentString;
@property (nonatomic, copy, readonly) NSURLRequest * request;
@property (nonatomic, copy, readonly) NSData * responseData;
@property (nonatomic, copy) NSDictionary * requestParams;


- (instancetype)initWithResponseString:(NSString *)responseString  request:(NSURLRequest *)request responseData:(NSData *)responseData status:(CXURLResponseStatus)status;
- (instancetype)initWithResponseString:(NSString *)responseString  request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;

@end
