//
//  Demo1ViewController.m
//  CATransition
//
//  Created by wangfubin on 2018/1/2.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "Demo1ViewController.h"

#import "ModalViewController.h"
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
#import "SwipeUpInteractiveTransition.h"

@interface Demo1ViewController ()<ModalViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) BouncePresentAnimation *presentAnimation;
@property (nonatomic, strong) NormalDismissAnimation *dismissAnimation;
@property (nonatomic, strong) SwipeUpInteractiveTransition *transitionController;

@end

@implementation Demo1ViewController

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
    self.title = @"简单自定义present";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)p_setupUI
{
    _presentAnimation = [BouncePresentAnimation new];
    _dismissAnimation = [NormalDismissAnimation new];
    _transitionController = [SwipeUpInteractiveTransition new];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark -- Action

- (void)buttonClicked:(id)sender
{
    ModalViewController *mvc =  [[ModalViewController alloc] init];
    mvc.transitioningDelegate = self;
    mvc.delegate = self;
    [self.transitionController wireToViewController:mvc];
    [self presentViewController:mvc animated:YES completion:nil];
}

#pragma mark -- ModalViewControllerDelegate

- (void)modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UIViewControllerTransitioningDelegate

// 返回一个管理prenent动画过渡的对象
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}

// 返回一个管理pop动画过渡的对象
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

// 返回一个管理prenent手势过渡的对象
- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return self.transitionController.interacting ? self.transitionController : nil;
}

// 返回一个管理pop动画过渡的对象

@end
