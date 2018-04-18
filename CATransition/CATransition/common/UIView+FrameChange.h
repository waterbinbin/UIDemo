//
//  UIView+FrameChange.h
//  CATransition
//
//  Created by wangfubin on 2018/1/2.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameChange)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign, readonly) CGFloat bottomFromSuperView;

@end
