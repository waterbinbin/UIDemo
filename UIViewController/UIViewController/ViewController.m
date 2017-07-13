//
//  ViewController.m
//  UIViewController
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

#import "ViewController2.h"

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

// 当视图控制器的视图即将显示时，调用
// 视图分为：1:显示前（没显示） 2:正在处于显示状态 3:已经隐藏
// 参数：表示是否用动画切换后显示
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear,视图即将显示");
}

// 视图即将消失时，调用
// 参数：表示是否调用动画切换后消失
// 当前状态：视图还是显示在屏幕上
- (void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear,视图即将消失");
}

// 视图出现
- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear,视图出现");
}

// 当屏幕被点击时调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 创建一个视图控制器2
    ViewController2* vc = [[ViewController2 alloc] init];
    
    // 显示一个新的视图控制器到屏幕
    // P1:新的视图控制器
    // P2:使用动画切换效果
    // P3:切换后功能调用，不需要传nil即可
    // 方法一：模态
    [self presentViewController:vc animated:YES completion:nil];
}


@end
