//
//  CycleView.h
//  CycleProgress
//
//  Created by wangfubin on 2017/11/15.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleView : UIView

@property (nonatomic, strong) UILabel *label;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)drawProgress:(CGFloat )progress;

@end
