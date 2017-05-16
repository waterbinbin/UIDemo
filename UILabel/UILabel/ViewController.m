//
//  ViewController.m
//  UILabel
//
//  Created by 王福滨 on 2017/4/12.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 初始化
    self.label = [[UILabel alloc] init];
    
    // 显示文字的赋值，字符串对象
    self.label.text = @"UILabel";
    
    // 设置label的显示位置
    self.label.frame = CGRectMake(100, 100, 160, 40);
    
    // 设置label的背景颜色，clearColor表示透明的颜色
    self.label.backgroundColor = [UIColor clearColor];
    
    // 设置label文字的大小，使用系统默认字体，大小12
    self.label.font = [UIFont systemFontOfSize:12];
    
    // 设置字体的颜色
    self.label.textColor = [UIColor blackColor];
    
    // label的高级属性
    // 设置阴影的颜色
    _label.shadowColor = [UIColor orangeColor];
    
    // 设置阴影的偏移量
    _label.shadowOffset = CGSizeMake(5, 5);
    
    // 设置text文字的对齐方式，默认为靠左对齐
    _label.textAlignment = NSTextAlignmentLeft;
    
    // 设置label文字显示的行数，默认值为：1，只用一行显示
    // 其他不为0的行数，文字会尽量按照设定行显示
    // 如果为0：IOS为对文字自动计算所需要的行数来显示
    _label.numberOfLines = 0;
    
    // 将label显示到屏幕上
    [self.view addSubview:_label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
