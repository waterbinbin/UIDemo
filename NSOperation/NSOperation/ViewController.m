//
//  ViewController.m
//  NSOperation
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

// 任务队列

#import "ViewController.h"

@interface ViewController ()
{
    // 定义一个任务队列对象
    NSOperationQueue *_queue;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *arrTitle = [NSArray arrayWithObjects:@"添加新任务1到队列", @"添加新任务2到队列",nil];
    for(int i = 0; i < 2; ++i)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(100, 100 + 80 * i, 180, 40);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
    }
    
    _queue = [[NSOperationQueue alloc] init];
    // 设置最大并发任务的数量
    [_queue setMaxConcurrentOperationCount:5];
}

- (void)pressBtn:(UIButton *)btn
{
    if(btn.tag == 100)
    {
        // 方法1:
        // 创建一个执行任务
        // P1:任务函数拥有者
        // P2:任务函数执行体
        // P3:任意参数
        NSInvocationOperation *iop = [[NSInvocationOperation alloc] initWithTarget:self
                                                                          selector:@selector(opAct01:)
                                                                            object:@"OPT01"];
        [_queue addOperation:iop];
        
        // 方法2:
        NSInvocation *invo = [[NSInvocation alloc] init];
        invo.target = self;
        invo.selector = @selector(opAct01:);
        NSInvocationOperation *iop02 = [[NSInvocationOperation alloc] initWithInvocation:invo];
        [_queue addOperation:iop02];
    }
    else if(btn.tag == 101)
    {
        // 方法3:
        // 使用block语法块执行任务处理
        [_queue addOperationWithBlock:^{
            while (true)
            {
                NSLog(@"Block Opt!");
            }
        }];
    }

}

- (void)opAct01:(NSInvocationOperation *)opt
{
    while (true)
    {
        NSLog(@"ipt 01!");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
