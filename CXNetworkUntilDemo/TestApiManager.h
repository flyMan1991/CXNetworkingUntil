//
//  TestApiManager.h
//  CXNetworkUntilDemo
//
//  Created by mac on 16/9/20.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "CXAPIBaseManager.h"

// 给参数提前设置好字段
static NSString * const kHomeApiManagerParamsP_pageNumber = @"P_pageNumber";
static  NSString * const kHomeApiManagerParamsP_pagesize = @"P_pagesize";

// 所有的API相关的类都要继承自CXAPIBaseManager,并且接收CXAPIManager协议
@interface TestApiManager : CXAPIBaseManager<CXAPIManager>

@end
