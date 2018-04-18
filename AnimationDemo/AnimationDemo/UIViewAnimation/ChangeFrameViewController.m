//
//  ChangeFrameViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/3.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "ChangeFrameViewController.h"

@interface ChangeFrameViewController ()

// 积分 view
@property (nonatomic, strong) UIImageView *integralView;
// 卡券 view
@property (nonatomic, strong) UIImageView *cartCenterView;
// 签到 view
@property (nonatomic, strong) UIImageView *signInView;


@end

@implementation ChangeFrameViewController

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
    self.title = @"ChangeFrame动画";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.signInView];
    [self.view addSubview:self.cartCenterView];
    [self.view addSubview:self.integralView];
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

// 改变 frame （cartCenterView）
- (void)p_changeFrame
{
    // 第一个参数: 动画标识
    // 第二个参数: 附加参数,在设置代理情况下，此参数将发送到setAnimationWillStartSelector和setAnimationDidStopSelector所指定的方法，大部分情况，设置为nil.
    [UIView beginAnimations:@"FrameAni" context:nil];
    
    // 动画持续时间
    [UIView setAnimationDuration:1.0];
    
    // 动画的代理对象
    [UIView setAnimationDelegate:self];
    
    // 设置动画将开始时代理对象执行的SEL
    [UIView setAnimationWillStartSelector:@selector(startAni:)];
    // 设置动画将结束时代理对象执行的SEL
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    
    // 设置动画的重复次数
    [UIView setAnimationRepeatCount:1.0];
    
    // 设置动画的曲线
    // UIViewAnimationCurve的枚举值如下：
    // UIViewAnimationCurveEaseInOut,         // 慢进慢出（默认值）
    // UIViewAnimationCurveEaseIn,            // 慢进
    // UIViewAnimationCurveEaseOut,           // 慢出
    // UIViewAnimationCurveLinear             // 匀速
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    // 设置是否从当前状态开始播放动画
    // 假设上一个动画正在播放，且尚未播放完毕，我们将要进行一个新的动画：
    // 当为YES时：动画将从上一个动画所在的状态开始播放
    // 当为NO时：动画将从上一个动画所指定的最终状态开始播放（此时上一个动画马上结束）
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    // 设置动画是否继续执行相反的动画
    [UIView setAnimationRepeatAutoreverses:NO];
    
    // 是否禁用动画效果（对象属性依然会被改变，只是没有动画效果）
    [UIView setAnimationsEnabled:YES];
    
    // 动画变化
    self.cartCenterView.frame = self.signInView.frame;
    
    // 结束动画标记
    [UIView commitAnimations];
}

#pragma mark -- Event Response

// 开始 动画
- (void)startAni:(NSString *)aniId
{
    NSLog(@"%@ start",aniId);
}

// 结束 动画
- (void)stopAni:(NSString *)aniId
{
    NSLog(@"%@ stop",aniId);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self p_changeFrame];
}

@end
