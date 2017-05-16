//
//  ViewController.m
//  UIGesture
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"
// 这个协议可以使多个手势同时操作
@interface ViewController () <UIGestureRecognizerDelegate>

// 定义一个缩放手势，用来对视图可以进行放大缩小
// Pinch：捏合手势
@property(nonatomic, strong) UIPinchGestureRecognizer* pinchGes;

// 定义一个旋转手势，主要用来旋转图像视图
@property(nonatomic, strong) UIRotationGestureRecognizer* rotGes;

@property(nonatomic, strong) UIImageView* iView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 加载图片到屏幕
    UIImage* image = [UIImage imageNamed:@"2.jpeg"];
    _iView = [[UIImageView alloc] initWithImage:image];
    _iView.frame = CGRectMake(50, 80, 200, 300);
    
    [self.view addSubview:_iView];
    
    // 开启交互事件响应开关
    // YES：可以响应交互事件
    // NO：不可以响应交互事件，默认值为NO
    _iView.userInteractionEnabled = YES;
    
    // 1. 创建一个点击手势对象,手势是针对某个指定视图，不像UITouch针对屏幕
    // UITapGestureRecognizer：点击手势类
    // 功能：识别点击手势事件
    // P1:响应事件的拥有者对象，self表示当前
    // P2:响应事件的函数
    UITapGestureRecognizer* tapOneGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOneAct:)];
    
    // 表示手势识别事件的事件类型：几次点击触发
    // 默认值：1
    tapOneGes.numberOfTapsRequired = 1;
    
    // 将点击事件添加到视图中，视图即可响应事件
    [_iView addGestureRecognizer:tapOneGes];
    
    // 2. 添加第二个手势
    // 创建双击手势
    UITapGestureRecognizer* tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwo:)];
    tapTwo.numberOfTapsRequired = 2;
    tapTwo.numberOfTouchesRequired = 1;
    [_iView addGestureRecognizer:tapTwo];
    
    // 当单击操作遇到双击操作时，单击操作失效
    [tapOneGes requireGestureRecognizerToFail:tapTwo];
    
    // 3. 创建一个捏合手势
    _pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAct:)];
    // 将捏合手势添加到视图
    [_iView addGestureRecognizer:_pinchGes];
    
    // 4. 创建一个旋转手势
    _rotGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotAct:)];
    [_iView addGestureRecognizer:_rotGes];
    
    // 设置手势代理
    _pinchGes.delegate = self;
    _rotGes.delegate = self;
    
    // 5. 创建一个平移手势
    // P1:事件函数处理对象
    // P1:事件函数
    UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAct:)];
    [_iView addGestureRecognizer:pan];
    
    // 6. 创建一个滑动手势
    // P1:事件函数处理对象
    // P1:事件函数
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAct:)];
    [_iView addGestureRecognizer:swipe];
    
    UISwipeGestureRecognizer* swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAct:)];
    [_iView addGestureRecognizer:swipeRight];
    
    // 设定滑动手势接受事件的类型
    // UISwipeGestureRecognizerDirectionLeft:向左滑动
    // UISwipeGestureRecognizerDirectionRight：向右滑动
    // UISwipeGestureRecognizerDirectionUp：向上滑动
    // UISwipeGestureRecognizerDirectionDown：向下滑动
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;//UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    
    pan.delegate = self;
    swipe.delegate = self;
    swipeRight.delegate = self;
    
    // 7. 创建一个长按手势
    // P1:事件函数处理对象
    // P1:事件函数
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressLong:)];
    [_iView addGestureRecognizer:longPress];
    // 设置长按手势的时间，默认0.5秒的时间时长按手势
    longPress.minimumPressDuration = 1;
}

// 事件响应函数,放大图片
// 参数手势点击事件对象
- (void)tapOneAct:(UITapGestureRecognizer *)tap
{
    // 获取手势监控的视图对象
    UIImageView* imageView = (UIImageView *)tap.view;
    
    // 开始动画过程
    [UIView beginAnimations:nil context:nil];
    // 设置动画过渡时间
    [UIView setAnimationDuration:2];
    imageView.frame = CGRectMake(0, 0, 320, 568);
    
    // 结束动画过程
    [UIView commitAnimations];
}

// 事件响应函数,缩小图片
- (void)tapTwo:(UITapGestureRecognizer *)tap
{
    // 获取手势监控的视图对象
    UIImageView* imageView = (UIImageView *)tap.view;
    
    // 开始动画过程
    [UIView beginAnimations:nil context:nil];
    // 设置动画过渡时间
    [UIView setAnimationDuration:2];
    imageView.frame = CGRectMake(50, 80, 200, 300);
    
    // 结束动画过程
    [UIView commitAnimations];
}

// 捏合手势事件函数
- (void)pinchAct:(UIPinchGestureRecognizer *)pinch
{
    // 获取监控视图对象
    UIImageView* iView = (UIImageView *)pinch.view;
    // 对图像视图对象进行矩形变换计算并赋值
    // transform：表示图形学中的变换矩阵
    // CGAffineTransformScale：通过缩放的方式产生一个新矩阵
    // P1:原来的矩阵
    // P2:x方向的缩放比例
    // P3:y方向的缩放比例
    // 返回值是新的缩放后的矩阵变换
    iView.transform = CGAffineTransformScale(iView.transform, pinch.scale, pinch.scale);
    // 将缩放值归为单位值
    // scale=1:原来的大小
    // scale<1:缩小效果
    // scale>1:放大效果
    pinch.scale = 1;
}

// 旋转手势事件函数
- (void)rotAct:(UIRotationGestureRecognizer *)rot
{
    // 获取监控视图对象
    UIImageView* iView = (UIImageView *)rot.view;
    
    // 计算旋转的变换矩阵并赋值
    iView.transform = CGAffineTransformRotate(iView.transform, rot.rotation);
    // 旋转角度清零
    rot.rotation = 0;
}

// 平移事件函数，只要手指坐标在屏幕上发生变化就调用
- (void)panAct:(UIPanGestureRecognizer *)pan
{
    // 获取移动的坐标，现对于视图的坐标系
    // 参数，相对视图对象
    CGPoint pt = [pan translationInView:self.view];
    
    // 获取移动时的相对速度
    CGPoint pV = [pan velocityInView:self.view];
    
    NSLog(@"pV.x = %.2f, pV.y = %.2f", pV.x, pV.y);
}

// 滑动事件函数
- (void)swipeAct:(UISwipeGestureRecognizer *)swipe
{
    if(swipe.direction & UISwipeGestureRecognizerDirectionLeft)
    {
        NSLog(@"right");
    }
    else if(swipe.direction & UISwipeGestureRecognizerDirectionRight)
    {
        NSLog(@"left");
    }
}

// 长按时间函数
- (void)pressLong:(UILongPressGestureRecognizer *)press
{
    // 手势的状态对象，到达规定的时间1秒，触发
    if(press.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"start");
    }
    // 当手指离开状态结束
    else if(press.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"end");
    }
    NSLog(@"longPress");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark 协议
// 是否可以同时响应2个手势
// 如果返回值YES：可以
// NO：不可以
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
