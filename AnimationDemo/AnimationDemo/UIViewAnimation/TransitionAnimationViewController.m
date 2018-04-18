//
//  TransitionAnimationViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/3.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "TransitionAnimationViewController.h"

@interface TransitionAnimationViewController ()

// 积分 view
@property (nonatomic, strong) UIImageView *integralView;
// 卡券 view
@property (nonatomic, strong) UIImageView *cartCenterView;
// 签到 view
@property (nonatomic, strong) UIImageView *signInView;

@property (nonatomic, assign) int count;

@end

@implementation TransitionAnimationViewController

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
    self.title = @"转场动画Block";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.signInView];
    [self.view addSubview:self.cartCenterView];
    [self.view addSubview:self.integralView];
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
        make.left.mas_equalTo(60);
        make.top.mas_equalTo(230);
        make.width.mas_equalTo((self.view.frame.size.width - 120) / 2);
        make.height.mas_equalTo(60);
    }];
    
    [self.integralView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(60 + (self.view.frame.size.width - 120) / 2);
        make.top.mas_equalTo(230);
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

// 转场 动画 单个 视图 过渡 效果
- (void)p_blockTransitionWithSingleViewAnimation
{
    [UIView transitionWithView:self.signInView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        self.signInView.image = [UIImage imageNamed:@"serviceActivity.png"];
                        
                    }
                    completion:^(BOOL finished) {
                        NSLog(@"动画结束");
                        self.view.backgroundColor = [UIColor lightGrayColor];
                    }];
}

// 转场 动画 (旧视图 到 新 视图)
- (void)p_blockTransitionFromViewToViewAnimation {
    UIImageView *tmpNewImageView = [[UIImageView alloc] initWithFrame:self.signInView.frame];
    tmpNewImageView.image = [UIImage imageNamed:@"serviceActivity.png"];
    [UIView transitionFromView:self.signInView
                        toView:tmpNewImageView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                        NSLog(@"动画结束");
                        self.view.backgroundColor = [UIColor brownColor];
                    }];
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if((self.count ++) % 2 == 0)
    {
        [self p_blockTransitionWithSingleViewAnimation];
    }
    else
    {
        [self p_blockTransitionFromViewToViewAnimation];
    }
}

@end
