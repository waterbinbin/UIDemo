//
//  _61CAShaperLayerViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/8.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "_61CAShaperLayerViewController.h"

@interface _61CAShaperLayerViewController ()

@end

@implementation _61CAShaperLayerViewController

#pragma mark -- Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupNavigationController];
    [self p_setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private

- (void)p_setupNavigationController
{
    self.title = @"6.1 CAShaperLayer";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor grayColor];
}

// 火柴人
- (void)p_drawMatchStickMan
{
    //create path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5; // 线宽
    shapeLayer.lineJoin = kCALineJoinRound; // 线条之间的结合点的样子
    shapeLayer.lineCap = kCALineCapRound; // 线条结尾的样子
    shapeLayer.path = path.CGPath;
    
    [self.view.layer addSublayer:shapeLayer];
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Method1
    [self p_drawMatchStickMan];
}

@end
