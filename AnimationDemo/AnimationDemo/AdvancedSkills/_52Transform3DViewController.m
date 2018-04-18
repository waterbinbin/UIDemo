//
//  _52Transform3DViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/6.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "_52Transform3DViewController.h"

@interface _52Transform3DViewController ()

@property(nonatomic, strong) UIView *layerView;
@property(nonatomic, strong) UIView *layerView1;

@property(nonatomic, strong) UIView *outerView;
@property(nonatomic, strong) UIView *innerView;

@end

@implementation _52Transform3DViewController

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
    self.title = @"5.2 3D变换";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor grayColor];
    
    // Method1-3使用
//    [self.view addSubview:self.layerView];
//    self.layerView.backgroundColor = [UIColor whiteColor];
//    UIImage *image = [UIImage imageNamed:@"Snowman@2x.png"];
//    self.layerView.layer.contents = (__bridge id)image.CGImage;
//    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
//    self.layerView.layer.contentsScale = image.scale;
//
//    [self.view addSubview:self.layerView1];
//    self.layerView1.backgroundColor = [UIColor whiteColor];
//    UIImage *image1 = [UIImage imageNamed:@"Snowman@2x.png"];
//    self.layerView1.layer.contents = (__bridge id)image1.CGImage;
//    self.layerView1.layer.contentsGravity = kCAGravityResizeAspect;
//    self.layerView1.layer.contentsScale = image1.scale;
    
    // Method4使用
    [self.view addSubview:self.outerView];
    [self.outerView addSubview:self.innerView];
}

// Y方法转45度
- (void)p_3DTransform
{
    // 等于在一个斜向的角度观看所以觉得缩小
    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView.layer.transform = transform;
}

// 透视投影
- (void)p_perspective3DTransform
{
    //create a new transform
    CATransform3D transform = CATransform3DIdentity;
    
    //apply perspective
    transform.m34 = - 1.0 / 500.0;
    
    //rotate by 45 degrees along the Y axis
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    
    //apply to layer
    self.layerView.layer.transform = transform;
}

- (void)p_perspective3DTransform1
{
    //apply perspective transform to container
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = - 1.0 / 500.0;
    self.view.layer.sublayerTransform = perspective;
    
    //rotate layerView1 by 45 degrees along the Y axis
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView.layer.transform = transform1;
    
    //rotate layerView2 by 45 degrees along the Y axis
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.layerView1.layer.transform = transform2;
}

// 扁平化图层，要注意不设置m34和分别设置m34的区别
- (void)method4
{
    //rotate the outer layer 45 degrees
    CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    self.outerView.layer.transform = outer;
    
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    self.innerView.layer.transform = inner;
}

- (void)method5
{
    //rotate the outer layer 45 degrees
    CATransform3D outer = CATransform3DIdentity;
    outer.m34 = -1.0 / 500.0;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    self.outerView.layer.transform = outer;
    
    //rotate the inner layer -45 degrees
    CATransform3D inner = CATransform3DIdentity;
    inner.m34 = -1.0 / 500.0;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    self.innerView.layer.transform = inner;
}

#pragma mark -- LazyLoading

- (UIView *)layerView
{
    if(!_layerView)
    {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.size.width / 2 - 100, 100, 200, 200)];
    }
    return _layerView;
}

- (UIView *)layerView1
{
    if(!_layerView1)
    {
        _layerView1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.size.width / 2 - 100, 350, 200, 200)];
    }
    return _layerView1;
}

- (UIView *)outerView
{
    if(!_outerView)
    {
        _outerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.size.width / 2 - 100, 100, 200, 200)];
        _outerView.backgroundColor = [UIColor whiteColor];
    }
    return _outerView;
}

- (UIView *)innerView
{
    if(!_innerView)
    {
        _innerView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        _innerView.backgroundColor = [UIColor grayColor];
    }
    return _innerView;
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Method1
//    [self p_3DTransform];
    // Metho
//    [self p_perspective3DTransform];
    // Method3
//    [self p_perspective3DTransform1];
    // Method4
//    [self method4];
    // Method5
    [self method5];
}

@end
