//
//  ViewController.m
//  UIButton
//
//  Created by 王福滨 on 2017/4/12.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 初始化
    //_btn = [[UIButton alloc] init];
    
    // 根据类型来创建btn
    // 圆角类型btn：UIButtonTypeRoundedRect
    // 通过类方法来创建buttonWithType：类名+方法名
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    // 设置btn按钮位置
    _btn.frame = CGRectMake(100, 100, 100, 40);
    
    // 设置按钮的文字内容
    // @parameter
    // P1:字符串类型，显示到按钮上的文字
    // P2:设置文字显示的状态类型：UIControlStateNormal正常模式,UIControlStateHighlighted按下时的状态
    [_btn setTitle:@"按钮01" forState:UIControlStateNormal];
    [_btn setTitle:@"按钮按下" forState:UIControlStateHighlighted];
    
    // 背景颜色
    _btn.backgroundColor = [UIColor grayColor];
    
    // 设置文字显示颜色
    // @parameter
    // P1:颜色
    // P2:状态
    [_btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    // 设置按钮的风格颜色
    [_btn setTintColor:[UIColor whiteColor]];
    
    // titleLabel:UILabel空间
    _btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    // 设置按钮的标值
    _btn.tag = 101;
    
    // 添加事件响应
    [_btn addTarget:self action:@selector(createImageBtn) forControlEvents:UIControlEventTouchUpInside];

    // 添加到视图显示
    [self.view addSubview:_btn];
    
}

// 创建一个可以显示图片的按钮
- (void)createImageBtn
{
    // 创建一个自定义类型的btn
    UIButton *btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnImage.frame = CGRectMake(100, 200, 100, 100);
    UIImage *icon01 = [UIImage imageNamed:@"tennis.gif"];
    UIImage *icon02 = [UIImage imageNamed:@"triathlon.gif"];
    [btnImage setImage:icon01 forState:UIControlStateNormal];
    [btnImage setImage:icon02 forState:UIControlStateHighlighted];
    [self.view addSubview:btnImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
