//
//  CAKeyframeAnimationPositionViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/4.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "CAKeyframeAnimationPositionViewController.h"

@interface CAKeyframeAnimationPositionViewController ()

// 积分 view
@property (nonatomic, strong) UIButton *integralView;
// 卡券 view
@property (nonatomic, strong) UIButton *cartCenterView;
// 签到 view
@property (nonatomic, strong) UIButton *signInView;

@end

@implementation CAKeyframeAnimationPositionViewController

#pragma mark -- Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupNavigationController];
    [self p_setupUI];
    [self p_setupMasonry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private

- (void)p_setupNavigationController
{
    self.title = @"CAKeyframeAnimationPosition相关动画";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.signInView];
    [self.view addSubview:self.integralView];
    [self.view addSubview:self.cartCenterView];
}

- (void)p_setupMasonry
{
    [self.signInView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(120);
        make.width.mas_equalTo(self.view.frame.size.width - 120);
        make.height.mas_equalTo(100);
    }];
    
    [self.cartCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.signInView);
        make.top.equalTo(self.signInView.mas_bottom).with.offset(10);
        make.width.mas_equalTo((self.view.frame.size.width - 120) / 2);
        make.height.mas_equalTo(60);
    }];
    
    [self.integralView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cartCenterView.mas_right);
        make.top.equalTo(self.signInView.mas_bottom).with.offset(10);
        make.width.mas_equalTo((self.view.frame.size.width - 120) / 2);
        make.height.mas_equalTo(60);
    }];
}

#pragma mark -- LazyLoading

// 签到 view
- (UIButton *)signInView
{
    if (!_signInView)
    {
        _signInView = [UIButton buttonWithType:UIButtonTypeCustom];
        _signInView.clipsToBounds = NO;
        [_signInView setImage:[UIImage imageNamed:@"default_user_icon.png"] forState:UIControlStateNormal];
    }
    return _signInView;
}

// 卡券 view
- (UIButton *)cartCenterView
{
    if (!_cartCenterView)
    {
        _cartCenterView = [UIButton buttonWithType:UIButtonTypeCustom];
        _cartCenterView.clipsToBounds = YES;
        [_cartCenterView setImage: [UIImage imageNamed:@"icon_gouwuche.png"] forState:UIControlStateNormal];
    }
    return _cartCenterView;
}

// 积分
- (UIButton *)integralView {
    if (!_integralView) {
        _integralView = [UIButton buttonWithType:UIButtonTypeCustom];
        _integralView.clipsToBounds = YES;
        [_integralView setImage: [UIImage imageNamed:@"home_dingdan.png"] forState:UIControlStateNormal];
    }
    return _integralView;
}

// position  正方形动画
- (void)p_positionKeyFrameAnimation
{
    // A.初始化CAAnimation对象:一般使用animation方法生成实例,
    // 如果是CAPropertyAnimation的子类，还可以通过animationWithKeyPath生成实例
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    // B.设置动画相关属性
    // 设置动画的执行时间、执行曲线、keyPath的目标值、代理等等
    
    // D.核心动画常用属性
    // duration：动画的持续时间
    ani.duration = 5.0f;
    // removedOnCompletion：动画执行完毕后是否从图层上移除，默认为YES（视图会恢复到动画前的状态），可设置为NO（图层保持动画执行后的状态，前提是fillMode设置为kCAFillModeForwards）
    ani.removedOnCompletion = NO;
    // fillMode：视图在非Active时的行为
    ani.fillMode = kCAFillModeForwards;
    // timingFunction：动画的时间节奏控制
    // timingFunctionName的enum值如下：
    // kCAMediaTimingFunctionLinear 匀速
    // kCAMediaTimingFunctionEaseIn 慢进
    // kCAMediaTimingFunctionEaseOut 慢出
    // kCAMediaTimingFunctionEaseInEaseOut 慢进慢出
    // kCAMediaTimingFunctionDefault 默认值（慢进慢出）
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    // values：关键帧数组对象，里面每一个元素即为一个关键帧，动画会在对应的时间内，依次执行数组中每一个关键帧的动画。
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(150, 100)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(250, 100)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(250, 200)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(150, 100)];
    ani.values = @[value1, value2, value3, value4, value5];
    
    // keyTimes：设置关键帧对应的时间点，范围:0-1.如果没有设置该属性，则每一帧的时间平分。
    ani.keyTimes = [NSArray arrayWithObjects:
                    [NSNumber numberWithFloat:0.0],
                    [NSNumber numberWithFloat:0.2],
                    [NSNumber numberWithFloat:0.3],
                    [NSNumber numberWithFloat:0.6],
                    [NSNumber numberWithFloat:1.0],
                    nil];
    
    // path：动画路径对象，可以指定一个路径，在执行动画时会沿着路径移动，path在路径中只会影响视图的Position.
    
    // 其他属性
    // repeatCount：动画的重复次数
    // beginTime：动画延迟执行时间（通过CACurrentMediaTime() + your time 设置）
    // delegate：代理
    // 代理方法如下：
    // - (void)animationDidStart:(CAAnimation *)anim;  //动画开始
    // - (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag; //动画结束
    
    // C.动画的添加和移除
    // 调用CALayer的addAnimation:forKey: 方法将动画添加到CALayer中，这样动画就开始执行了
    // 调用CALayer的removeAnimation方法停止CALayer中的动画
    // - (void)removeAnimationForKey:(NSString *)key;
    // - (void)removeAllAnimations;
    [self.signInView.layer addAnimation:ani forKey:@"PositionKeyFrameAni"];
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self p_positionKeyFrameAnimation];
}

@end
