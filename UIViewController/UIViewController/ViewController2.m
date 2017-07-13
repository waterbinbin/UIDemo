//
//  ViewController2.m
//  UIViewController
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

// 点击当前控制器2的界面屏幕时
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 使当前的控制器消失
    // P1:是否有动画效果
    // P2:结束后是否调用功能block块操作
    // 方法一：模态
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
