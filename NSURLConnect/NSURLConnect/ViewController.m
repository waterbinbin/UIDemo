//
//  ViewController.m
//  NSURLConnect
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//


// 工程info.plist文件内添加字段:NSAppTransportSecurity, Dictionary类型的, 在此字段下添加NSAllowsArbitraryLoads , Boolean类型并且设置为YES
#import "ViewController.h"
// 连接服务器的普通代理协议，作为错误处理普通协议完成
// 连接服务器对象的数据代理协议，当回传数据时使用的协议
@interface ViewController () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
{
    // 定义一个URL连接对象，通过网络协议地址，可以进行连接工作
    // 按照Http协议进行传输
    NSURLConnection *_connect;
    // 创建一个可变二进制数据对象，接受服务器传回数据
    NSMutableData *_data;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 80, 40);
    [btn addTarget:self action:@selector(pressBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"连接数据" forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
}

- (void)pressBtn
{
    NSString *strURL = @"http://www.baidu.com";
    // 将字符串转换为一个地址链接对象
    NSURL *url = [NSURL URLWithString:strURL];
    // 定义一个连接请求对象
    // 在连接之前的信息的封装
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 创建一个网络连接对象
    // P1:连接请求的对象
    // P2:代理对象，用来实现回传数据的代理协议
    _connect = [NSURLConnection connectionWithRequest:request delegate:self];
    
    _data = [[NSMutableData alloc] init];
}

// 处理错误信息的代理对象
// 如果有任何连接错误，调用此协议，进行错误打印查看
// P1: 连接对象
// P2: 错误信息
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@", error);
}

// 处理服务器返回的响应码
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    if(res.statusCode == 200)
    {
        NSLog(@"连接成功！服务器正常！");
    }
    else if(res.statusCode == 404)
    {
        NSLog(@"服务器正常开启，没有找到连接地址页面或数据");
    }
    else if(res.statusCode == 500)
    {
        NSLog(@"服务器宕机或关机");
    }
}

// 接收服务器回传的数据时调用
- (void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)data
{
    // 将每次回传的数据连接起来
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 将二进制数据转化为字符串数据
    NSString *str = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    NSLog(@"baidu page = %@", str);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
