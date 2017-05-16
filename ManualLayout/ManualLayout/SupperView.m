//
//  SupperView.m
//  ManualLayout
//
//  Created by 王福滨 on 2017/4/14.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "SupperView.h"

@implementation SupperView

- (void)createSubViews
{
    // 左上角视图
    _view1 = [[UIView alloc] init];
    _view1.frame = CGRectMake(0, 0, 40, 40);
    
    // 右上角视图
    _view2 = [[UIView alloc] init];
    _view2.frame = CGRectMake(self.bounds.size.width - 40, 0, 40, 40);
    
    // 右下角视图
    _view3 = [[UIView alloc] init];
    _view3.frame = CGRectMake(self.bounds.size.width - 40, self.bounds.size.height - 40, 40, 40);
    
    // 左下角视图
    _view4 = [[UIView alloc] init];
    _view4.frame = CGRectMake(0, self.bounds.size.height - 40, 40, 40);
    

    _view1.backgroundColor = [UIColor orangeColor];
    _view2.backgroundColor = [UIColor orangeColor];
    _view3.backgroundColor = [UIColor orangeColor];
    _view4.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:_view1];
    [self addSubview:_view2];
    [self addSubview:_view3];
    [self addSubview:_view4];
    
}

// 当需要重新布局时调用此函数
// 通过此函数重新设定子视图的位置
// 手动调整子视图位置
- (void)layoutSubviews
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    
    _view1.frame = CGRectMake(0, 0, 40, 40);
    _view2.frame = CGRectMake(self.bounds.size.width - 40, 0, 40, 40);
    _view3.frame = CGRectMake(self.bounds.size.width - 40, self.bounds.size.height - 40, 40, 40);
    _view4.frame = CGRectMake(0, self.bounds.size.height - 40, 40, 40);
    
    [UIView commitAnimations];
}

@end
