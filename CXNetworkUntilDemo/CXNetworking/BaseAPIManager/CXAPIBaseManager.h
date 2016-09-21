//
//  CXAPIBaseManager.h
//  Crowd
//
//  Created by mac on 16/9/12.
//  Copyright © 2016年 CES. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CXAPIBaseManager;
@class  CXURLResponse;
// 数据相应之后的回调
@protocol CXAPIManagerCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(CXAPIBaseManager *)manager;
- (void)managerCallAPIDidFail:(CXAPIBaseManager *)manager;
@end

// 数据的重新组装
@protocol CXAPIManagerDataReformer <NSObject>

@required
- (id)manager:(CXAPIBaseManager *)manager reformData:(NSDictionary *)data;

@end


// 验证器,用于验证API的返回或者调用API的参数是否正确
@protocol CXAPIManagerValidator <NSObject>

@required
- (BOOL)manager:(CXAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
- (BOOL)manager:(CXAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;
@end

// 让Manager能够获取调用API所需的数据
@protocol CXAPIManagerParamasSource <NSObject>
@required
- (NSDictionary *)paramsForApi:(CXAPIBaseManager *)manager;
@end


// 使用下列枚举来决定使用哪种UI
typedef NS_ENUM(NSUInteger, CXAPIManagerErrorType) {
    CXAPIManagerErrorTypeDefault,
    CXAPIManagerErrorTypeSuccess,
    CXAPIManagerErrorTypeNoContent, // API请求成功,如果回调数据验证函数放回值为NO,MANAGER 的状态就会是这个
    CXAPIManagerErrorTypeParamsError, // 参数错误
    CXAPIManagerErrorTypeTimeOut,  // 请求超时
    CXAPIManagerErrorTypeNoNetwork  // 网络不通
};

// 请求方式
typedef NS_ENUM(NSUInteger, CXAPIManagerRequestType) {
    CXAPIManagerRequestTypeGET,
    CXAPIManagerRequestTypePOST,
    CXAPIManagerRequestTypePUT,
    CXAPIManagerRequestTypeDELETE
};

//CXAPIBaseManager 的子类必须符合这些protocal
@protocol CXAPIManager  <NSObject>

@required
- (NSString *)methodName;
- (CXAPIManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
@end

@interface CXAPIBaseManager : NSObject

@property (nonatomic,weak) id<CXAPIManagerCallBackDelegate> delegate;
@property (nonatomic,weak) id<CXAPIManagerParamasSource> paramSource;
@property (nonatomic,weak) id<CXAPIManagerValidator> validator;
@property (nonatomic,weak) NSObject<CXAPIManager> * child;

/*
 baseManager是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。所以为了统一外部调用的入口，设置了这个变量。
 派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限。
 */
@property (nonatomic, strong) CXURLResponse *response;


@property (nonatomic, copy , readonly) NSString * errorMessage;
@property (nonatomic, readonly) CXAPIManagerErrorType errorType;

@property (nonatomic,assign,readonly) BOOL isReachable;

- (id)fetchDataWithReformer:(id<CXAPIManagerDataReformer>)reformer;

- (void)loadData;

- (void)successedOnCallingAPI:(CXURLResponse *)response;
- (void)failedOnCallingAPI:(CXURLResponse *)response  withErrorType:(CXAPIManagerErrorType)errorType;

@end
