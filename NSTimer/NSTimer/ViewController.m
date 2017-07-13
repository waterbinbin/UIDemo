//
//  ViewController.m
//  NSTimer
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

#import "NSTimer+KWS.h"

@interface ViewController ()

@property(nonatomic, strong) NSTimer *timerView;
@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, strong) UIButton *btn2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 根据类型来创建btn
    // 圆角类型btn：UIButtonTypeRoundedRect
    // 通过类方法来创建buttonWithType：类名+方法名
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    // 设置btn按钮位置
    _btn.frame = CGRectMake(100, 100, 100, 40);
    _btn2.frame = CGRectMake(100, 150, 100, 40);
    
    // 设置按钮的文字内容
    // @parameter
    // P1:字符串类型，显示到按钮上的文字
    // P2:设置文字显示的状态类型：UIControlStateNormal正常模式,UIControlStateHighlighted按下时的状态
    [_btn setTitle:@"start" forState:UIControlStateNormal];
    [_btn2 setTitle:@"stop" forState:UIControlStateNormal];
    
    // 添加事件响应
    [_btn addTarget:self action:@selector(pressStart) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(pressStop) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到视图显示
    [self.view addSubview:_btn];
    [self.view addSubview:_btn2];
}

// 点击start按钮
- (void)pressStart
{
    // NSTimer的类方法创建一个定时器并且启动这个定时器
    // P1:每个多长时间调用定时器函数，秒为单位
    // P2:表示实现定时器函数的对象（指针）
    // P3:定时器函数对象
    // P4:定时器函数中的一个参数，无参可以传nil
    // P5:定时器是否重复操作，YES为重复，NO只完成一次调用
    // 返回值为一个新建好的定时器对象
    // 方法1，原生
//    _timerView = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer:) userInfo:_timerView repeats:NO];
    // 方法2
    [self startAnimationTimer];
}

// 定时器函数，可以将定时器本身作为参数传入
- (void)updateTimer:(NSTimer *)timer
{
    NSLog(@"test:name = %@", timer.userInfo);
    
    // 最好tag从100开始
    UIView* view = [self.view viewWithTag:101];
    
    view.frame = CGRectMake(view.frame.origin.x + 1, view.frame.origin.y + 1, 80, 80);
}

// 点击stop按钮
- (void)pressStop
{
    // 方法1，原生
//    if(_timerView != nil)
//    {
//        // 停止定时器
//        [_timerView invalidate];
//    }
    // 方法2
    [self stopAnimationTimer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startAnimationTimer
{
    _timerView = [NSTimer startWithTimeInterval:1 repeats:NO timeout:^{
        // 最好tag从100开始
        UIView* view = [self.view viewWithTag:101];
        
        view.frame = CGRectMake(view.frame.origin.x + 1, view.frame.origin.y + 1, 80, 80);
        NSLog(@"start");
    }];
    [_timerView fire];
}

- (void)stopAnimationTimer {
    if (_timerView) {
        NSLog(@"stop");
        [_timerView invalidate];
        _timerView = nil;
    }
}


@end
