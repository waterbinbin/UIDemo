//
//  UpLoadCircleView.h
//  hooya
//
//  Created by wangfubin on 2017/11/14.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpLoadCircleView : UIView

@property (nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UIImageView *imageView;

- (instancetype)initWithFrame:(CGRect)frame;
- (void)drawProgress:(CGFloat )progress;

@end
