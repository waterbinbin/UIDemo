//
//  ViewController.m
//  UIVIewAnimation
//
//  Created by wangfubin on 2017/5/15.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImageView *_imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(100, 100, 80, 80);
    _imageView.image = [UIImage imageNamed:@"0.jpeg"];
    [self.view addSubview:_imageView];
    
    UIButton *btnMove = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnMove.frame = CGRectMake(120, 360, 80, 40);
    [btnMove setTitle:@"移动" forState:UIControlStateNormal];
    [btnMove addTarget:self action:@selector(pressMove) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMove];
    
    UIButton *btnScale = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnScale.frame = CGRectMake(120, 400, 80, 40);
    [btnScale setTitle:@"缩放" forState:UIControlStateNormal];
    [btnScale addTarget:self action:@selector(pressScale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnScale];
}

- (void)pressMove
{
    // 开始动画函数，准备动画的开始工作
    [UIView beginAnimations:nil context:nil];
    
    // 动画的实际的目标结果
    // 设置动画时间函数，参数时间长度，以秒为单位
    [UIView setAnimationDuration:2];
    // 设置动画开始的延时时间,进行延时动画的处理
    [UIView setAnimationCurve:0];
    // 设置动画的代理对象
    [UIView setAnimationDelegate:self];
    // 设置动画运轨迹的方式
    // UIViewAnimationCurveLinear匀速
    // EASEIN加速
    // EASEOUT减速
    // EASEINOUT开始加速后边减速
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // 设置动画结束调用的函数
    [UIView setAnimationDidStopSelector:@selector(stopAnim)];
    // 目标位置
    _imageView.frame = CGRectMake(220, 100, 80, 80);
    _imageView.alpha = 0.3;
    
    // 提交运动动画
    [UIView commitAnimations];
}

- (void)stopAnim
{
    NSLog(@"动画结束");
}

- (void)pressScale
{
    // 开始动画函数，准备动画的开始工作
    [UIView beginAnimations:nil context:nil];
    
    // 动画的实际的目标结果
    // 设置动画时间函数，参数时间长度，以秒为单位
    [UIView setAnimationDuration:2];
    // 设置动画开始的延时时间,进行延时动画的处理
    [UIView setAnimationCurve:0];
    // 设置动画的代理对象
    [UIView setAnimationDelegate:self];
    // 设置动画运轨迹的方式
    // UIViewAnimationCurveLinear匀速
    // EASEIN加速
    // EASEOUT减速
    // EASEINOUT开始加速后边减速
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // 设置动画结束调用的函数
    [UIView setAnimationDidStopSelector:@selector(stopAnim)];
    // 目标位置
    _imageView.frame = CGRectMake(100, 100, 160, 160);
    _imageView.alpha = 0.3;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
