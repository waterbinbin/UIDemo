//
//  VCFirst.m
//  UITabBarController
//
//  Created by 王福滨 on 2017/4/17.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "VCFirst.h"

@interface VCFirst ()

@end

@implementation VCFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 方法1:
    // 创建一个分栏按钮对象
    // P1:文字
    // P2:显示图片图标
    // P3:设置按钮的tab
//    UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTitle:@"111" image:nil tag:101];
//    self.tabBarItem = tabBarItem;/Users/wangfubin/Documents/WFB IOSDemo/TestDemo/UIDemo/UIPickerView/UIPickerView/ViewController.m
    
    // 方法2:
    // P1:系统风格设定
    UITabBarItem* tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemContacts tag:101];
    // 按钮右上角的提示信息
    // 通常用来提示未读的信息
    tabBarItem.badgeValue = @"22";
    self.tabBarItem = tabBarItem;
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
