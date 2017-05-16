//
//  ViewController.m
//  UISlider&UIProgressView
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIProgressView* progressView;
@property(nonatomic, strong) UISlider* slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // UIProgressView
    // 进度条的创建
    _progressView = [[UIProgressView alloc] init];
    
    // 进度条的位置大小设置
    // 进度条的高度不可以变化
    _progressView.frame = CGRectMake(50, 100, 200, 40);
    
    // 设置进度条的风格颜色
    _progressView.progressTintColor = [UIColor redColor];
    
    // 设置进度条的进度值，范围0-1
    _progressView.progress = 0.5;
    
    // 进度条的风格特征
    _progressView.progressViewStyle = UIProgressViewStyleDefault;
    
    [self.view addSubview:_progressView];
    
    // UISlider
    // 创建滑动条
    _slider = [[UISlider alloc] init];
    
    // 位置设置，高度不可变
    _slider.frame = CGRectMake(10, 200, 300, 40);
    
    // 设置滑动条最大值
    _slider.maximumValue = 100;
    
    // 设置滑动条的最小值，可以为负
    _slider.minimumValue = 0;
    
    // 设置滑动块的位置float值
    _slider.value = 30;
    
    // 左侧滑条背景颜色
    _slider.minimumTrackTintColor = [UIColor blueColor];
    
    // 右侧滑条背景颜色
    _slider.maximumTrackTintColor = [UIColor greenColor];
    
    // 设置滑块颜色
    _slider.thumbTintColor = [UIColor orangeColor];
    
    // 对滑动条添加事件函数
    [_slider addTarget:self action:@selector(pressSlider) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_slider];
}

// 进度条跟着滑动条
- (void)pressSlider
{
    _progressView.progress = (_slider.value - _slider.minimumValue) / (_slider.maximumValue - _slider.minimumValue);
    NSLog(@"value = %f", _slider.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
