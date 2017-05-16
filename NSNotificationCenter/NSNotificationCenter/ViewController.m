//
//  ViewController.m
//  NSNotificationCenter
//
//  Created by wangfubin on 2017/5/9.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import "ViewController.h"

#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"进入下一页" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(100, 100, 200, 30);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 200, 30)];
    label.tag = 9090;
    label.textColor = [UIColor blackColor];
    label.text = @"------";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    // 注册通知 self接受名为@"CHANGE_LABELTEXT"的通知后,执行notification:方法
    // nil表示不限制通知的发送者
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notification:)
                                                 name:@"CHANGE_LABELTEXT"
                                               object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 接受对应通知之后执行的方法
- (void)notification:(NSNotification *)notification {
    //    notification.name 通知的name
    //    notification.object 通知的内容, 可自定义
    NSString *str = (NSString *)notification.object;
    ((UILabel *)[self.view viewWithTag:9090]).text = str;
}

- (void)btnAction:(UIButton *)btn {
    SecondViewController *vc = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc {
    // 注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
