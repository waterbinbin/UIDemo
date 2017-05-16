//
//  ViewController.m
//  AFNetWork
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

// 下载：git@github.com:AFNetworking/AFNetworking.git
// 工程info.plist文件内添加字段:NSAppTransportSecurity, Dictionary类型的, 在此字段下添加NSAllowsArbitraryLoads , Boolean类型并且设置为YES

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)AFNetMonitor
{
    // 检查网络连接的状态
    // AFNetworkReachabilityManager 网络连接检测管理类
    
    // 开启网络状态监控器
    // sharedManager获得唯一的单例对象
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 获取网络连接的结果
    [[AFNetworkReachabilityManager sharedManager]
     setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
         switch (status) {
             case AFNetworkReachabilityStatusNotReachable:
             {
                 NSLog(@"无网络连接");
                 break;
             }
             case AFNetworkReachabilityStatusReachableViaWiFi:
             {
                 NSLog(@"通过wifi连接网络");
                 break;
             }
             case AFNetworkReachabilityStatusReachableViaWWAN:
             {
                 NSLog(@"通过移动网络4G");
                 break;
             }
             case AFNetworkReachabilityStatusUnknown:
             {
                 NSLog(@"未知网络");
                 break;
             }
             default:
                 break;
         }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [ self AFNetMonitor];
    [self AFGetData];
}

- (void)AFGetData
{
    // 创建HTTP连接管理对象
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    // GET方法获取服务器数据
    // GET:通过GET方法
    // P1:参数传入一个URL对象
    // P2:通过指定的结构传入参数
    // P3:指定下载的进度条UI
    // P4:下载数据成功后调用block,pp1：下载的任务线程 pp2:返回的数据内容
    // P5:下载数据失败后调用block，pp1：下载的任务线程 pp2:返回的错误数据内容
    [session GET:@"http://api.douban.com/book/subjects?q=ios&alt=json&apikey=01987f93c544bbfb04c97ebb4fce33f1"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"下载成功");
             if([responseObject isKindOfClass:[NSDictionary class]])
             {
                 NSLog(@"res = %@", responseObject);
             }
        }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"下载失败");
         }];
}
@end
