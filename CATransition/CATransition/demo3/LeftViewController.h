//
//  LeftViewController.h
//  CATransition
//
//  Created by wangfubin on 2018/1/23.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PushControllerDelegate.h"

@interface LeftViewController : UIViewController<UINavigationControllerDelegate>

@property (nonatomic, weak) id<PushControllerDelegate> delegate;

@end
