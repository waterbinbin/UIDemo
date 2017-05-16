//
//  ViewController.m
//  NSThread
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSThread *_thread01;
    NSThread *_thread02;
    
    NSInteger _count;
    // 定义一个线程锁
    NSLock *_lock;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *arrTitle = [NSArray arrayWithObjects:@"启动线程", @"启动线程01", @"启动线程02",nil];
    for(int i = 0; i < 3; ++i)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(100, 100 + 80 * i, 100, 40);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
    }
    
    _lock = [[NSLock alloc] init];
}

- (void)pressBtn:(UIButton *)btn
{
    if(btn.tag == 100)
    {
        // 方法1:创建一个线程对象
        // P1:线程对象运行函数的拥有者
        // P2:线程处理函数
        // P3:线程参数
        NSThread *newT = [[NSThread alloc] initWithTarget:self selector:@selector(actNew:) object:nil];
        // 启动并运行线程
        [newT start];
    }
    else if(btn.tag == 101)
    {
        // 开线程方法2
        // 创建并启动线程
        [NSThread detachNewThreadSelector:@selector(actT1) toTarget:self withObject:nil];
    }
    else if(btn.tag == 102)
    {
        _thread02 = [[NSThread alloc] initWithTarget:self selector:@selector(actT2) object:nil];
        [_thread02 start];
    }
}

- (void)actNew:(NSThread *)thread
{
    int i = 0;
    while (true)
    {
        i++;
        //NSLog(@"i = %d", i);
    }
}

- (void)actT1
{
    int i = 0;
    while (true)
    {
        i++;
        //NSLog(@"Act1 = %d", i);
        if(i >= 10001)
        {
            break;
        }
        [_lock lock];
        _count++;
        [_lock unlock];
        NSLog(@"c1 = %ld", _count);
    }
    NSLog(@"c1 final = %ld", _count);
}

- (void)actT2
{
    int i = 0;
    while (true)
    {
        i++;
        //NSLog(@"Act2 = %d", i);
        if(i >= 10001)
        {
            break;
        }
        [_lock lock];
        _count++;
        [_lock unlock];
        NSLog(@"c2 = %ld", _count);
    }
    NSLog(@"c2 final = %ld", _count);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
