//
//  LeftView.m
//  CATransition
//
//  Created by wangfubin on 2018/2/7.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "LeftView.h"

// 左滑出来的view，自身右滑回去

#define Screen_width [UIScreen mainScreen].bounds.size.width

@interface LeftView ()

@property (nonatomic, strong) UIView *maskView;

@end

@implementation LeftView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.maskView];
    }
    return self;
}

- (UIView *)maskView
{
    if(!_maskView)
    {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(20, 108, self.frame.size.width - 40, self.frame.size.height - 40 - 108)];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.layer.cornerRadius = 10;
        _maskView.layer.masksToBounds = YES;
    }
    return _maskView;
}

#pragma mark - 直播信息界面的滑动

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //    水平手势判断
    NSLog(@"xxx %f", self.frame.origin.x);
    if (self.frame.origin.x > Screen_width * 0.2) {
        [UIView animateWithDuration:0.15 animations:^{
            CGRect frame = self.frame;
            frame.origin.x = Screen_width;
            self.frame = frame;
            
        }];
        
    }else{
        [UIView animateWithDuration:0.06 animations:^{
            CGRect frame = self.frame;
            frame.origin.x = 0;
            self.frame = frame;
        }];
    }
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.frame.origin.x > Screen_width * 0.2) {
        [UIView animateWithDuration:0.15 animations:^{
            CGRect frame = self.frame;
            frame.origin.x = Screen_width;
            self.frame = frame;
            
        }];
        
    }else{
        [UIView animateWithDuration:0.06 animations:^{
            CGRect frame = self.frame;
            frame.origin.x = 0;
            self.frame = frame;
        }];
    }
    
}

@end
