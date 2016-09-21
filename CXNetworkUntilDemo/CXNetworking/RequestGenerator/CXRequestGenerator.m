//
//  CXRequestGenerator.m
//  Crowd
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "CXRequestGenerator.h"
#import "AFNetworking.h"
#import "CXNetworkingConfiguration.h"
#import "NSString+URLString_Append.h"
#import "NSURLRequest+CXNetworkingMethods.h"
#import "CXAppNetworkingStatus.h"


@interface CXRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer * httpRequestSerializer;

@end

@implementation CXRequestGenerator
#pragma mark - life cycle
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CXRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[CXRequestGenerator alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public   methods
    // IP是其中的IP地址
- (NSURLRequest *)generateGETRequestWithrequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    NSString * urlstring = [NSString urlStringAppendWithBaseUrl:[CXAppNetworkingStatus sharedInstance].ipAndHost   methodName:methodName];
    NSMutableURLRequest * request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlstring parameters:requestParams error:nil];
    request.requestParams = requestParams;
    return request;
    
}
- (NSURLRequest *)generatePOSTRequestWithrequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    NSString * urlstring = [NSString urlStringAppendWithBaseUrl:[CXAppNetworkingStatus sharedInstance].ipAndHost   methodName:methodName];
    NSMutableURLRequest * request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlstring parameters:requestParams error:nil];
    request.requestParams = requestParams;
    return request;
}
- (NSURLRequest *)generatePutRequestWithrequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    NSString * urlstring = [NSString urlStringAppendWithBaseUrl:[CXAppNetworkingStatus sharedInstance].ipAndHost   methodName:methodName];
    NSMutableURLRequest * request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlstring parameters:requestParams error:nil];
    request.requestParams = requestParams;
    return request;
}
- (NSURLRequest *)generateDeleteRequestWithrequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    NSString * urlstring = [NSString urlStringAppendWithBaseUrl:[CXAppNetworkingStatus sharedInstance].ipAndHost   methodName:methodName];
    NSMutableURLRequest * request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlstring parameters:requestParams error:nil];
    request.requestParams = requestParams;
    return request;
}
#pragma mark - getters and setters 
- (AFHTTPRequestSerializer *)httpRequestSerializer {
    if (!_httpRequestSerializer) {
        self.httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kCXNetworkingTimeoutSeconds;
    }
    return _httpRequestSerializer;
}

@end
