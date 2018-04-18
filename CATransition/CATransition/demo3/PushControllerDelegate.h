//
//  PushControllerDelegate.h
//  CATransition
//
//  Created by wangfubin on 2018/1/23.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PushControllerDelegate <NSObject>

- (id<UIViewControllerInteractiveTransitioning>)interactiveTransitionForPush;

@end
