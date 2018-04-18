//
//  ModalViewController.h
//  CATransition
//
//  Created by wangfubin on 2018/1/2.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

-(void) modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController;

@end

@interface ModalViewController : UIViewController

@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;

@end
