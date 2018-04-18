//
//  CABasicAnimationRotationViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/4.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "CABasicAnimationRotationViewController.h"

@interface CABasicAnimationRotationViewController ()

// 积分 view
@property (nonatomic, strong) UIImageView *integralView;
// 卡券 view
@property (nonatomic, strong) UIImageView *cartCenterView;
// 签到 view
@property (nonatomic, strong) UIImageView *signInView;

@property (nonatomic, assign) int count;

@end

@implementation CABasicAnimationRotationViewController

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
    self.title = @"CABasicAnimationRotation相关动画";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.signInView];
    [self.view addSubview:self.integralView];
    [self.view addSubview:self.cartCenterView];
    
    self.count = 0;
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
- (UIImageView *)signInView
{
    if (!_signInView)
    {
        _signInView = [[UIImageView alloc] init];
        _signInView.clipsToBounds = YES;
        _signInView.contentMode = UIViewContentModeScaleAspectFill;
        _signInView.image = [UIImage imageNamed:@"default_user_icon.png"];
    }
    return _signInView;
}

// 卡券 view
- (UIImageView *)cartCenterView
{
    if (!_cartCenterView)
    {
        _cartCenterView = [[UIImageView alloc] init];
        _cartCenterView.contentMode = UIViewContentModeScaleAspectFill;
        _cartCenterView.clipsToBounds = YES;
        _cartCenterView.image = [UIImage imageNamed:@"icon_gouwuche.png"];
    }
    return _cartCenterView;
}

// 积分
- (UIImageView *)integralView {
    if (!_integralView) {
        _integralView = [[UIImageView alloc] init];
        _integralView.clipsToBounds = YES;
        _integralView.contentMode = UIViewContentModeScaleAspectFill;
        _integralView.image = [UIImage imageNamed:@"home_dingdan.png"];
    }
    return _integralView;
}

// rotation 基本 动画
- (void)p_basicAnimationOfRotation
{
    // A.初始化CAAnimation对象:一般使用animation方法生成实例,
    // 如果是CAPropertyAnimation的子类，还可以通过animationWithKeyPath生成实例
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    // B.设置动画相关属性
    // 设置动画的执行时间、执行曲线、keyPath的目标值、代理等等
    
    // D.核心动画常用属性
    ani.toValue = [NSNumber numberWithFloat:M_PI];
    // duration：动画的持续时间
    ani.duration = 1.0f;
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
    [self.signInView.layer addAnimation:ani forKey:@"RotationAni"];
}

// rotationX 基本 动画
- (void)p_basicAnimationOfRotationX {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    ani.toValue = [NSNumber numberWithFloat:M_PI];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"RotationAni"];
}

// rotationY 基本 动画
- (void)p_basicAnimationOfPositionY {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    ani.toValue = [NSNumber numberWithFloat:M_PI];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"RotationAni"];
}

// rotationZ 基本 动画
- (void)p_basicAnimationOfRotationZ {
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    ani.toValue = [NSNumber numberWithFloat:M_PI];
    ani.removedOnCompletion = NO;
    ani.duration = 1.0f;
    ani.fillMode = kCAFillModeForwards;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.signInView.layer addAnimation:ani forKey:@"RotationAni"];
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if((self.count) % 4 == 0)
    {
        [self p_basicAnimationOfRotation];
    }
    else if(self.count % 4 == 1)
    {
        [self p_basicAnimationOfRotationX];
    }
    else if(self.count % 4 == 2)
    {
        [self p_basicAnimationOfPositionY];
    }
    else if(self.count % 4 == 3)
    {
        [self p_basicAnimationOfRotationZ];
    }
    self.count++;
}


@end
