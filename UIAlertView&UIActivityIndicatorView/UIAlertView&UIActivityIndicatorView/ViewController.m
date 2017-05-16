//
//  ViewController.m
//  UIAlertView&UIActivityIndicatorView
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIAlertView* alertView;
@property(nonatomic, strong) UIActivityIndicatorView* activityIndicator;
@property(nonatomic, strong) UIButton *btn;
@property(nonatomic, strong) UIButton *btn2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 根据类型来创建btn
    // 圆角类型btn：UIButtonTypeRoundedRect
    // 通过类方法来创建buttonWithType：类名+方法名
    _btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    // 设置btn按钮位置
    _btn.frame = CGRectMake(100, 100, 100, 40);
    _btn2.frame = CGRectMake(100, 150, 100, 40);
    
    _btn.tag = 101;
    _btn2.tag = 102;
    
    // 设置按钮的文字内容
    // @parameter
    // P1:字符串类型，显示到按钮上的文字
    // P2:设置文字显示的状态类型：UIControlStateNormal正常模式,UIControlStateHighlighted按下时的状态
    [_btn setTitle:@"警告框" forState:UIControlStateNormal];
    [_btn2 setTitle:@"等待提示" forState:UIControlStateNormal];
    
    // 添加事件响应
    [_btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn2 addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到视图显示
    [self.view addSubview:_btn];
    [self.view addSubview:_btn2];

}

- (void)pressBtn:(UIButton *)btn
{
    if(btn.tag == 101)
    {
        // UIAlertView
        // 创建警告对话框视图对象
        
        // P1:对话框标题
        // P2:提示信息
        // P3:处理按钮事件的代理对象
        // P4:取消按钮的文字
        // P5:其他按钮文字
        // P6:添加其他按钮
        _alertView = [[UIAlertView alloc] initWithTitle:@"警告"
                                                message:@"准备关机"
                                               delegate:nil
                                      cancelButtonTitle:@"取消"
                                      otherButtonTitles:@"OK", nil];
        // 显示对话框
        [_alertView show];
    }
    else if(btn.tag == 102)
    {
        // UIActivityIndicatorView
        // 当下载，或加载比较大的文件时，可以显示此件，处于提示等待状态
        // 宽高不可变
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 300, 80, 80)];
        
        // 设置提示风格：小灰，小白，大白
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_activityIndicator];
        
        // 启动动画并显示
        [_activityIndicator startAnimating];
    }
    

}

// 当点击对话框的按钮时调用
// P1:对话框对象本身
// P2:按钮的索引
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index = %ld",buttonIndex);
}

// 对话框消失
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"willDismissWithButtonIndex：消失");
}

// 对话框已经消失
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"didDismissWithButtonIndex：已经消失");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
