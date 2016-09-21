//
//  ViewController.m
//  CXNetworkUntilDemo
//
//  Created by mac on 16/9/20.
//  Copyright © 2016年 CES. All rights reserved.
//

#import "ViewController.h"
#import "CXURLResponse.h"
#import "TestApiManager.h"
#import <AFNetworking/AFNetworking.h>



 // <CXAPIManagerParamasSource,CXAPIManagerCallBackDelegate>  是用来设置拼接的参数和服务器返回的信息
@interface ViewController ()<CXAPIManagerParamasSource,CXAPIManagerCallBackDelegate>
    // 建立请求列表的时候,每个请求都需要建立一个类,这样相互之间没有影响,处理方便
    @property (nonatomic,strong) TestApiManager * testApi1;
    // 这里需要建立一个不同的类,和TestApiManager 不同的类, 这里为了方便,我使用了相同的类
    @property (nonatomic,strong) TestApiManager * testApi2;
    
@end

@implementation ViewController
#pragma  mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 请求1加载数据,成功之后加载请求2的数据
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.testApi1 loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- CXAPIManagerParamasSource
- (NSDictionary *)paramsForApi:(CXAPIBaseManager *)manager {
    NSDictionary * params = @{};
    // 判断是哪一个请求,如果是第一个请求testApi1,给第一个请求设置参数
    if (manager == self.testApi1) {
        params = @{kHomeApiManagerParamsP_pageNumber:@(1),
                   kHomeApiManagerParamsP_pagesize:@20};
        
    }
    // 如果是第二个请求self.testApi2,给第二个请求设置参数
    if (manager == self.testApi2) {
        params = @{kHomeApiManagerParamsP_pageNumber:@(10),
                   kHomeApiManagerParamsP_pagesize:@20};

    }
    
    return params;
}
    
#pragma mark - CXAPIManagerCallBackDelegate
    // 服务器返回的数据正确,并且结果符合json标准
- (void)managerCallAPIDidSuccess:(CXAPIBaseManager *)manager {
    // 同理,这里同样判断
    if (manager == self.testApi1) {
        // 处理第一个请求时服务器放回的数据
        // 在这里加载请求2的数据
        NSLog(@"请求1数据为:%@",manager.response.content);
        [self.testApi2 loadData];
    }
    if (manager == self.testApi2) {
        // 处理第二个请求服务器返回的数据
        NSLog(@"请求2数据为:%@",manager.response.content);
    }
}
     // 服务器返回的数据错误,或者网络错误,统一管理,方便进行判断
- (void)managerCallAPIDidFail:(CXAPIBaseManager *)manager {
    // 同理,这里同样判断
    if (manager == self.testApi1) {
        // 处理第一个请求时服务器放回的数据
        NSLog(@"请求1错误信息%lu",(unsigned long)manager.errorType);
    }
    if (manager == self.testApi2) {
        // 处理第二个请求服务器返回的数据
        NSLog(@"请求2错误信息%lu",(unsigned long)manager.errorType);
    }
}
    
    
    
#pragma mark - setter/getter
- (TestApiManager *)testApi1 {
    if (!_testApi1) {
        self.testApi1 = [[TestApiManager alloc] init];
        _testApi1.delegate = self;
        _testApi1.paramSource = self;
    }
    return _testApi1;
}
- (TestApiManager *)testApi2 {
    if (!_testApi2) {
        self.testApi2 = [[TestApiManager alloc] init];
        _testApi2.delegate = self;
        _testApi2.paramSource = self;
    }
    return _testApi2;
}

@end
