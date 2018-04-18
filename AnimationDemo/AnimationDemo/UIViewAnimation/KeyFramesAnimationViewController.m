//
//  KeyFramesAnimationViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/3.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "KeyFramesAnimationViewController.h"

@interface KeyFramesAnimationViewController ()

// 积分 view
@property (nonatomic, strong) UIImageView *integralView;
// 卡券 view
@property (nonatomic, strong) UIImageView *cartCenterView;
// 签到 view
@property (nonatomic, strong) UIImageView *signInView;

@end

#pragma mark -- Life Circle

@implementation KeyFramesAnimationViewController

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
    self.title = @"Keyframes Block动画";
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

// 关键帧 放大 动画(IOS7.0后新增了关键帧动画，支持属性关键帧，不支持路径关键帧)
- (void)p_blockAmplifyAnimation
{
    // UIViewKeyframeAnimationOptions的枚举值如下，可组合使用：
//    UIViewAnimationOptionLayoutSubviews           //进行动画时布局子控件
//    UIViewAnimationOptionAllowUserInteraction     //进行动画时允许用户交互
//    UIViewAnimationOptionBeginFromCurrentState    //从当前状态开始动画
//    UIViewAnimationOptionRepeat                   //无限重复执行动画
//    UIViewAnimationOptionAutoreverse              //执行动画回路
//    UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
//    UIViewAnimationOptionOverrideInheritedOptions //不继承父动画设置
//    
//    UIViewKeyframeAnimationOptionCalculationModeLinear     //运算模式 :连续
//    UIViewKeyframeAnimationOptionCalculationModeDiscrete   //运算模式 :离散
//    UIViewKeyframeAnimationOptionCalculationModePaced      //运算模式 :均匀执行
//    UIViewKeyframeAnimationOptionCalculationModeCubic      //运算模式 :平滑
//    UIViewKeyframeAnimationOptionCalculationModeCubicPaced //运算模式 :平滑均匀
    
    self.signInView.transform = CGAffineTransformIdentity;
    self.signInView.image = [UIImage imageNamed:@"serviceActivity.png"];
    [UIView animateKeyframesWithDuration:1.5                                                  // 动画持续时间
                                   delay:0                                                    // 动画延迟执行的时间
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear   // 动画的过渡效果
                              animations:^{                                                   // 执行的关键帧动画
                                  // 增加关键帧方法:
                                  [UIView addKeyframeWithRelativeStartTime:0                  // 动画开始的时间（占总时间的比例）
                                                          relativeDuration:1/3.0              // 动画持续时间（占总时间的比例）
                                                                animations:^{                 // 执行的动画
                                      self.signInView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                                  }];
        
                                  [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{
                                      self.signInView.transform = CGAffineTransformMakeScale(0.8, 0.8);
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations:^{
                                      self.signInView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                  }];
        
                              }
                              completion:^(BOOL finished) {                                     // 动画执行完毕后的操作
                                  NSLog(@"动画结束");
                              }];
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self p_blockAmplifyAnimation];
}


@end
