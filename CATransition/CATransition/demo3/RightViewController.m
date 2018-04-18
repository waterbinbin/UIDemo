//
//  RightViewController.m
//  CATransition
//
//  Created by wangfubin on 2018/1/23.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "RightViewController.h"

#import "XWInteractiveTransition.h"
#import "XWPageCoverTransition.h"

@interface RightViewController ()

@property (nonatomic, strong) XWInteractiveTransition *interactiveTransitionPop;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    //初始化手势过渡的代理
    _interactiveTransitionPop = [XWInteractiveTransition interactiveTransitionWithTransitionType:XWInteractiveTransitionTypePop GestureDirection:XWInteractiveTransitionGestureDirectionLeft];
    //给当前控制器的视图添加手势
    [_interactiveTransitionPop addPanGestureForViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    //分pop和push两种情况分别返回动画过渡代理相应不同的动画操作
    return [XWPageCoverTransition transitionWithType:operation == UINavigationControllerOperationPush ? XWPageCoverTransitionTypePush : XWPageCoverTransitionTypePop];
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    if (_operation == UINavigationControllerOperationPush) {
        XWInteractiveTransition *interactiveTransitionPush = [_delegate interactiveTransitionForPush];
        return interactiveTransitionPush.interation ? interactiveTransitionPush : nil;
    }else{
        return _interactiveTransitionPop.interation ? _interactiveTransitionPop : nil;
    }
}

@end
