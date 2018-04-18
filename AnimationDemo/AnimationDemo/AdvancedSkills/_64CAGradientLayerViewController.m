//
//  _64CAGradientLayerViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/8.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "_64CAGradientLayerViewController.h"

@interface _64CAGradientLayerViewController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation _64CAGradientLayerViewController

#pragma mark -- Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupNavigationController];
    [self p_setupUI];
    // method1
//    [self gradientMethod];
    // method2
    [self mutilGradientMethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private

- (void)p_setupNavigationController
{
    self.title = @"6.4 CAGradientLayer";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.containerView];
}

// 渐变
- (void)gradientMethod
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor];
    
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

// 多重渐变
- (void)mutilGradientMethod
{
    //create gradient layer and add it to our container view
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor];
    
    //set locations
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

#pragma mark -- LazyLoad

- (UIView *)containerView
{
    if(!_containerView)
    {
        _containerView = [[UIView alloc] initWithFrame:self.view.frame];
    }
    return _containerView;
}

@end
