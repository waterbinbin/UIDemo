//
//  BottomView.m
//  CATransition
//
//  Created by wangfubin on 2018/2/7.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "BottomView.h"

// 下滑出来的view，自身上滑回去

#define Screen_height [UIScreen mainScreen].bounds.size.height

@interface BottomView ()

@property (nonatomic, strong) UIView *maskView;

@end

@implementation BottomView

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
        _maskView.backgroundColor = [UIColor blueColor];
        _maskView.layer.cornerRadius = 10;
        _maskView.layer.masksToBounds = YES;
    }
    return _maskView;
}

#pragma mark - 直播信息界面的滑动

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"xxx %f", self.frame.origin.y);
//    // 垂直手势判断
//    if (self.frame.origin.y < -Screen_height * 0.2) {
//        [UIView animateWithDuration:0.15 animations:^{
//            CGRect frame = self.frame;
//            frame.origin.y = -Screen_height;
//            self.frame = frame;
//
//        }];
//
//    }else{
//        [UIView animateWithDuration:0.06 animations:^{
//            CGRect frame = self.frame;
//            frame.origin.y = 0;
//            self.frame = frame;
//        }];
//    }
//
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    if (self.frame.origin.y < -Screen_height * 0.2) {
//        [UIView animateWithDuration:0.15 animations:^{
//            CGRect frame = self.frame;
//            frame.origin.y = -Screen_height;
//            self.frame = frame;
//
//        }];
//
//    }else{
//        [UIView animateWithDuration:0.06 animations:^{
//            CGRect frame = self.frame;
//            frame.origin.y = 0;
//            self.frame = frame;
//        }];
//    }
//
//}

@end
