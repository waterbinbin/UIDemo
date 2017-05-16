//
//  VCRoot.m
//  UINavigationController
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
    
    // 设置导航栏的标题文字
    self.title = @"根视图";
    
    // 设置导航元素项目的标题
    // 如果没有设置navigationItem.title，为nil
    // 系统会使用self.title作为标题
    // 如果navigationItem.title不为空
    // 将navigationItem.title设置为标题内容
    self.navigationItem.title = @"Title";
    
    // 创建一个导航拦左侧的按钮
    // 根据title文字来创建按钮
    // P1:按钮上的文字
    // P2:按钮风格
    // P3:事件拥有着
    // P4:按钮事件
    UIBarButtonItem* leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"左侧" style:UIBarButtonItemStyleDone target:self action:@selector(pressLeft)];
    // 将导航元素项的左侧按钮赋值
    self.navigationItem.leftBarButtonItem = leftBtn;
    
//    // 系统按钮的创建方法
//    UIBarButtonItem* rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pressRight)];
//    
//    // 标签对象
//    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 40)];
//    label.text = @"test";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor blueColor];
//    
//    // 将任何类型的控件添加到导航按钮的方法
//    UIBarButtonItem* item3 = [[UIBarButtonItem alloc] initWithCustomView:label];
//    // 创建按钮数组
//    NSArray* arrayBtn = [NSArray arrayWithObjects:rightBtn, item3, nil];
//    // 将右侧按钮数组赋值
//    self.navigationItem.rightBarButtonItems = arrayBtn;
    
    UIBarButtonItem* next = [[UIBarButtonItem alloc] initWithTitle:@"第二级" style:UIBarButtonItemStylePlain target:self action:@selector(pressRight)];
    self.navigationItem.rightBarButtonItem = next;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pressLeft
{
    NSLog(@"left button");
}

- (void)pressRight
{
    //NSLog(@"right button");
    // 创建新的视图控制器
    VCSecond* vcSecond = [[VCSecond alloc] init];
    
    // 使用当前视图控制器的导航控制器对象
    [self.navigationController pushViewController:vcSecond animated:YES];
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
