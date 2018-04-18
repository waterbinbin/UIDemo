//
//  CentreViewController.m
//  CATransition
//
//  Created by wangfubin on 2018/1/23.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "CentreViewController.h"

#import "XWInteractiveTransition.h"
#import "LeftViewController.h"
#import "RightViewController.h"

@interface CentreViewController ()<UIGestureRecognizerDelegate, PushControllerDelegate>

@property (nonatomic, strong) XWInteractiveTransition *interactiveTransitionPush;
@property (nonatomic, strong) XWInteractiveTransition *interactiveTransitionPush1;

@end

@implementation CentreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
//    _interactiveTransitionPush = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePush GestureDirection:XWInteractiveTransitionGestureDirectionLeft];
//    typeof(self)weakSelf = self;
//    _interactiveTransitionPush.pushConifg = ^(){
//        [weakSelf push];
//    };
//    //此处传入self.navigationController， 不传入self，因为self.view要形变，否则手势百分比算不准确；
//    [_interactiveTransitionPush addPanGestureForViewController:self];
//
    typeof(self)weakSelf = self;
    _interactiveTransitionPush1 = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePush GestureDirection:XWInteractiveTransitionGestureDirectionRight];
    [_interactiveTransitionPush1 addPanGestureForViewController:self];
    _interactiveTransitionPush1.pushConifg = ^(){
        [weakSelf pushRight];
    };
    //此处传入self.navigationController， 不传入self，因为self.view要形变，否则手势百分比算不准确；
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 取消右滑pop手势
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }

}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    // 取消右滑pop手势
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
//    _interactiveTransitionPush1 = nil;
}
#pragma mark -- UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer
{
    // 取消右滑pop手势
    return gestureRecognizer != self.navigationController.interactivePopGestureRecognizer;
}

- (void)push{
    LeftViewController *pushVC = [LeftViewController new];
    self.navigationController.delegate = pushVC;
    pushVC.delegate = self;
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (void)pushRight
{
    RightViewController *pushVC = [RightViewController new];
    self.navigationController.delegate = pushVC;
    pushVC.delegate = self;
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush{
    return _interactiveTransitionPush1;
}

@end
