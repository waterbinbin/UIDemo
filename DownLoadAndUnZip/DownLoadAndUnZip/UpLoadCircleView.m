//
//  UpLoadCircleView.m
//  hooya
//
//  Created by wangfubin on 2017/11/14.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "UpLoadCircleView.h"

@interface UpLoadCircleView ()

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, strong) CALayer *gradientLayer;

@end

@implementation UpLoadCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor clearColor];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:_imageView];
        [self addSubview:self.label];
    }
    return self;
}

- (UILabel *)label
{
    if (_label == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        [self addSubview:label];
        _label = label;
    }
    return _label;
}

- (void)drawProgress:(CGFloat )progress
{
    _progress = progress;
    [_progressLayer removeFromSuperlayer];
    [_gradientLayer removeFromSuperlayer];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self drawCycleProgress];
    
}

- (void)drawCycleProgress
{
    CGPoint center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGFloat radius = 30;
    CGFloat startA = - M_PI_2;  //设置进度条起点位置
    CGFloat endA = -M_PI_2 + M_PI * 2 * _progress;  //设置进度条终点位置
    
    
    //获取环形路径（画一个圆形，填充色透明，设置线框宽度为10，这样就获得了一个环形）
    _progressLayer = [CAShapeLayer layer];//创建一个track shape layer
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];  //填充色为无色
    _progressLayer.strokeColor = [[UIColor yellowColor] CGColor]; //指定path的渲染颜色,这里可以设置任意不透明颜色
    _progressLayer.opacity = 1; //背景颜色的透明度
    _progressLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _progressLayer.lineWidth = 3;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];//上面说明过了用来构建圆形
    _progressLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    [self.layer addSublayer:_progressLayer];
}

@end
