//
//  CXURLResponse.m
//  Crowd
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "CXURLResponse.h"
#import "NSURLRequest+CXNetworkingMethods.h"
@interface CXURLResponse ()

@property (nonatomic, copy) id content;

@property (nonatomic, assign) CXURLResponseStatus status;
@property (nonatomic, copy) NSString * contentString;
@property (nonatomic, copy) NSURLRequest * request;
@property (nonatomic, copy) NSData * responseData;

@end


@implementation CXURLResponse

#pragma mark - life cycle
- (instancetype)initWithResponseString:(NSString *)responseString request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error {
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.status = [self responseStatusWithError:error];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            self.content = nil;
        }
    }
    return self;
}


- (instancetype)initWithResponseString:(NSString *)responseString request:(NSURLRequest *)request responseData:(NSData *)responseData status:(CXURLResponseStatus)status {
 
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
    }
    return self;
}



- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
    }
    return self;

}

#pragma mark - private methods 
- (CXURLResponseStatus)responseStatusWithError:(NSError *)error {
    // 错误不为空,解析有问题;如果为空,解析成功
    if (error) {
        CXURLResponseStatus result = CXURLResponseStatusErrorNoNetwork;
        // 处理超时以外, 所有错误都当成是无网络
        if (error.code == NSURLErrorTimedOut) {
            result = CXURLResponseStatusErrorNoNetwork;
        }
        return result;
    } else {
        return CXURLResponseStatusSuccess;
    }
}
@end
