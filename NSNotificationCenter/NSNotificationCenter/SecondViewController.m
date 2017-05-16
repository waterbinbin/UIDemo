//
//  SecondViewController.m
//  NSNotificationCenter
//
//  Created by wangfubin on 2017/5/9.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"第二页";
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"触发通知" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(100, 100, 150, 30);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 用按钮事件模拟触发通知
- (void)btnAction:(UIButton *)btn {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGE_LABELTEXT" object:@"第二页的通知内容"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"APPDELEGATE_NOTIFICATION" object:@"通知Applegate执行事件"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
