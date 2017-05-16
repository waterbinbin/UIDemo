//
//  ViewController.m
//  AdvancedAnimation
//
//  Created by wangfubin on 2017/5/16.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

// HMGLTransitions下载：git@github.com:Split82/HMGLTransitions.git
// 添加3个framework
// BuileSetting的Objective-C automatic reference count设置为NO
// Compile Source AS 改为Objective C++

#import "ViewController.h"
#import "HMGLTransitionManager.h"
#import "ClothTransition.h"
#import "DoorsTransition.h"
#import "Switch3DTransition.h"

@interface ViewController ()
{
    UIView *_parentView;
    UIImageView *_imageView01;
    UIImageView *_imageView02;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _parentView = [[UIView alloc] initWithFrame:CGRectMake(40, 80, 260, 380)];
    [self.view addSubview:_parentView];
    
    _imageView01 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"0.jpeg"]];
    _imageView01.frame = CGRectMake(0, 0, 260, 380);
    [_parentView addSubview:_imageView01];
    
    _imageView02 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpeg"]];
    _imageView02.frame = CGRectMake(0, 0, 260, 380);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self animaMove];
}

- (void)animaMove
{
    // 创建动画管理器对象
    HMGLTransitionManager *manager = [HMGLTransitionManager sharedTransitionManager];
    // 动画变换1
    Switch3DTransition *sAnim = [[Switch3DTransition alloc] init];
    // 设置动画的方向类型
    [sAnim setTransitionType:Switch3DTransitionLeft];
    
    // 动画变换2
    DoorsTransition *door = [[DoorsTransition alloc] init];
    [door setTransitionType:DoorsTransitionTypeOpen];
    
    // 动画变换3
    ClothTransition *cloth = [[ClothTransition alloc] init];

    // 设置动画类型
    [manager setTransition:cloth];
    // 设置动画视图的容器对象
    [manager beginTransition:_parentView];
    
    static BOOL isFirst = YES;
    if(isFirst)
    {
        // 让第一个图像视图消失
        [_imageView01 removeFromSuperview];
        _imageView02.frame = _imageView01.frame;
        // 将视图2添加到图像容器中
        [_parentView addSubview:_imageView02];
    }
    else
    {
        // 让第二个图像视图消失
        [_imageView02 removeFromSuperview];
        _imageView01.frame = _imageView02.frame;
        // 将视图1添加到图像容器中
        [_parentView addSubview:_imageView01];
    }
    isFirst = !isFirst;
    
    // 提交动画效果
    [manager commitTransition];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
