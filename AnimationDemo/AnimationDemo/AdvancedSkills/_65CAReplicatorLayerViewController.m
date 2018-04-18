//
//  _65CAReplicatorLayerViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/8.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "_65CAReplicatorLayerViewController.h"
#import "ReflectionView.h"

@interface _65CAReplicatorLayerViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ReflectionView *reflectionView;

@end

@implementation _65CAReplicatorLayerViewController

#pragma mark -- Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupNavigationController];
    [self p_setupUI];
    // Method1
//    [self replicatorLayerMehtod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private

- (void)p_setupNavigationController
{
    self.title = @"6.5 CAReplicatorLayer";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor grayColor];
    // Method1
//    [self.view addSubview:self.containerView];
    // Method2 不起作用
    [self.view addSubview:self.reflectionView];
    self.reflectionView.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"Anchor@2x.png"];
    self.reflectionView.layer.contents = (__bridge id)image.CGImage;
    self.reflectionView.layer.contentsGravity = kCAGravityResizeAspect;
    self.reflectionView.layer.contentsScale = image.scale;
}

// 重复图层
- (void)replicatorLayerMehtod
{
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    //configure the replicator
    replicator.instanceCount = 10;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 100, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -100, 0);
    replicator.instanceTransform = transform;
    
    //apply a color shift for each instance
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
}

#pragma mark -- LazyLoad

- (UIView *)containerView
{
    if(!_containerView)
    {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    }
    return _containerView;
}

- (ReflectionView *)reflectionView
{
    if(!_reflectionView)
    {
        _reflectionView = [[ReflectionView alloc] initWithFrame:CGRectMake(100, 200, 160, 160)];
    }
    return _reflectionView;
}

@end
