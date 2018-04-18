//
//  _51CGAffineTransformViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/6.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "_51CGAffineTransformViewController.h"

@interface _51CGAffineTransformViewController ()

@property(nonatomic, strong) UIView *layerView;

@end

@implementation _51CGAffineTransformViewController

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
    self.title = @"5.1仿射变换";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.layerView];
    self.layerView.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"Snowman@2x.png"];
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    
    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
    self.layerView.layer.contentsScale = image.scale;
}

// affinetransform 45度
- (void)p_affineTransformMethod
{
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
    self.layerView.layer.affineTransform = transform;
}

// 混合变换
- (void)p_blendTransform
{
//    图片向右边发生了平移，但并没有指定距离那么远（200像素），另外它还有点向下发生了平移。原因在于当你按顺序做了变换，上一个变换的结果将会影响之后的变换，所以200像素的向右平移同样也被旋转了30度，缩小了50%，所以它实际上是斜向移动了100像素。
    // 初始化一个什么都不做的变换
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    //scale by 50%
    transform = CGAffineTransformScale(transform, 0.5, 0.5);
    
    //rotate by 30 degrees
    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
    
    //translate by 200 points
    transform = CGAffineTransformTranslate(transform, 200, 0);
    
    //apply transform to layer
    self.layerView.layer.affineTransform = transform;
}

#pragma mark -- LazyLoading

- (UIView *)layerView
{
    if(!_layerView)
    {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.size.width / 2 - 100, self.view.size.height / 2 - 100, 200, 200)];
    }
    return _layerView;
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Method1
//    [self p_affineTransformMethod];
    // Method2
    [self p_blendTransform];
}


@end
