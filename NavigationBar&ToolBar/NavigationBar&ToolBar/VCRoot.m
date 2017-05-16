//
//  VCRoot.m
//  NavigationBar&ToolBar
//
//  Created by 王福滨 on 2017/4/14.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "VCRoot.h"

#import "VCSecond.h"

@interface VCRoot ()

@end

@implementation VCRoot

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    // 设置导航栏风格颜色
    // UIBarStyleBlack：黑色风格，半透明风格
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    // 将风格设置为不透明
    self.navigationController.navigationBar.translucent = NO;
    
    // 设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    
    // 设置导航栏的按钮风格颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    // 隐藏导航栏
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
    
    self.title = @"根视图";
    
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithTitle:@"右侧按钮" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = btn;
    
    // 实现工具栏对象
    // 默认工具栏时隐藏
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.translucent = NO;
    
    // 创建3个工具栏按钮
    UIBarButtonItem* btn1 = [[UIBarButtonItem alloc] initWithTitle:@"left" style:UIBarButtonItemStylePlain target:nil action:nil];
    UIBarButtonItem* btn2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(pressNext)];
    
    UIButton* btnImage = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnImage setImage:[UIImage imageNamed:@"tennis.gif"] forState:UIControlStateNormal];
    btnImage.frame = CGRectMake(0, 0, 60, 60);
    
    UIBarButtonItem* btn3 = [[UIBarButtonItem alloc] initWithCustomView:btnImage];
    
    // 固定宽度占位按钮
    UIBarButtonItem* btnF1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    btnF1.width = 30;
    
    // 创建自动计算宽度按钮
    UIBarButtonItem* btnF2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // 按钮数组创建
    NSArray* arrayBtns = [NSArray arrayWithObjects:btn1, btnF1, btn2, btnF2, btn3, nil];
    
    self.toolbarItems = arrayBtns;
}

- (void)pressNext
{
    VCSecond* vc = [[VCSecond alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
