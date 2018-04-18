//
//  SpringAnimationViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/3.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "SpringAnimationViewController.h"

@interface SpringAnimationViewController ()

// 积分 view
@property (nonatomic, strong) UIImageView *integralView;
// 卡券 view
@property (nonatomic, strong) UIImageView *cartCenterView;
// 签到 view
@property (nonatomic, strong) UIImageView *signInView;

@end

#pragma mark -- Life Circle

@implementation SpringAnimationViewController

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
    self.title = @"弹簧Block动画";
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

// 弹簧动画
- (void)p_blockChangeFrameWithSpringAnimation
{
    // UIViewAnimationOptions的枚举值如下,可组合使用:
    //    UIViewAnimationOptionLayoutSubviews            //进行动画时布局子控件
    //    UIViewAnimationOptionAllowUserInteraction      //进行动画时允许用户交互
    //    UIViewAnimationOptionBeginFromCurrentState     //从当前状态开始动画
    //    UIViewAnimationOptionRepeat                    //无限重复执行动画
    //    UIViewAnimationOptionAutoreverse               //执行动画回路
    //    UIViewAnimationOptionOverrideInheritedDuration //忽略嵌套动画的执行时间设置
    //    UIViewAnimationOptionOverrideInheritedCurve    //忽略嵌套动画的曲线设置
    //    UIViewAnimationOptionAllowAnimatedContent      //转场：进行动画时重绘视图
    //    UIViewAnimationOptionShowHideTransitionViews   //转场：移除（添加和移除图层的）动画效果
    //    UIViewAnimationOptionOverrideInheritedOptions  //不继承父动画设置
    //
    //    UIViewAnimationOptionCurveEaseInOut            //时间曲线，慢进慢出（默认值）
    //    UIViewAnimationOptionCurveEaseIn               //时间曲线，慢进
    //    UIViewAnimationOptionCurveEaseOut              //时间曲线，慢出
    //    UIViewAnimationOptionCurveLinear               //时间曲线，匀速
    //
    //    UIViewAnimationOptionTransitionNone            //转场，不使用动画
    //    UIViewAnimationOptionTransitionFlipFromLeft    //转场，从左向右旋转翻页
    //    UIViewAnimationOptionTransitionFlipFromRight   //转场，从右向左旋转翻页
    //    UIViewAnimationOptionTransitionCurlUp          //转场，下往上卷曲翻页
    //    UIViewAnimationOptionTransitionCurlDown        //转场，从上往下卷曲翻页
    //    UIViewAnimationOptionTransitionCrossDissolve   //转场，交叉消失和出现
    //    UIViewAnimationOptionTransitionFlipFromTop     //转场，从上向下旋转翻页
    //    UIViewAnimationOptionTransitionFlipFromBottom  //转场，从下向上旋转翻页
    
    [UIView animateWithDuration:1.0                                           // 动画持续时间
                          delay:0.5                                           // 动画延迟执行的时间
         usingSpringWithDamping:0.01                                          // 震动效果，范围0~1，数值越小震动效果越明显
          initialSpringVelocity:10.0f                                         // 初始速度，数值越大初始速度越快
                        options:UIViewAnimationOptionCurveEaseInOut           // 动画的过渡效果
                     animations:^{                                            // 执行的动画
                         self.cartCenterView.frame = self.signInView.frame;
                     }
                     completion:^(BOOL finished) {                            //动画执行完毕后的操作
                         self.cartCenterView.hidden = YES;
                     }];
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self p_blockChangeFrameWithSpringAnimation];
}


@end
