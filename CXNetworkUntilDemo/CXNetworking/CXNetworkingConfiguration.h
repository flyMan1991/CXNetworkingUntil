//
//  CXNetworkingConfigurationHeader.h
//  Crowd
//
//  Created by mac on 16/9/13.
//  Copyright © 2016年 CES. All rights reserved.
//

#ifndef CXNetworkingConfigurationHeader_h
#define CXNetworkingConfigurationHeader_h

typedef NS_ENUM(NSUInteger, CXURLResponseStatus) {
    CXURLResponseStatusSuccess,// 作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的CXAPIBaseManager来决定。
    CXURLResponseStatusErrorTimeout,
    CXURLResponseStatusErrorNoNetwork  // 默认除了超时以外的错误都是无网络链接
};

static NSTimeInterval kCXNetworkingTimeoutSeconds = 20.0f;

#endif /* CXNetworkingConfigurationHeader_h */
