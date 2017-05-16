//
//  ViewController.m
//  UIView
//
//  Created by 王福滨 on 2017/4/12.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 显示在屏幕上的所有对象的基础类
    // 所有显示在屏幕上的对象一定都继承于UIView
    // 屏幕上能看到的对象都是UIView的子类
    // UIView时一个矩形对象，有背景颜色，层级关系
    UIView *view = [[UIView alloc] init];
    
    // 设置UIView位置
    view.frame = CGRectMake(100, 100, 100, 200);
    view.backgroundColor = [UIColor orangeColor];
    
    // 将所建的视图添加到父视图
    // 1:将新建的视图显示到屏幕上
    // 2:将视图作为父视图的字视图管理起来
    [self.view addSubview:view];
    
    // 是否隐藏视图对象
    // YES：不显示
    // NO：显示，为默认值
    view.hidden = NO;
    
    // 设置视图的透明度
    // alpha = 1；不透明
    // alpha = 0；透明
    // alpha = 0。5；半透明
    view.alpha = 0.9;
    
    self.view.backgroundColor = [UIColor blueColor];
    
    // 设置是否显示不透明
    view.opaque = NO;
    
    // 将自己从父视图删除
    // 1:从父视图的管理中删除
    // 2:不会显示在屏幕上
    //[view removeFromSuperview];
    
    // view的层级关系
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(100, 100, 100, 200);
    view1.backgroundColor = [UIColor redColor];
    
    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(100, 100, 100, 200);
    view2.backgroundColor = [UIColor greenColor];
    
    UIView *view3 = [[UIView alloc] init];
    view3.frame = CGRectMake(100, 100, 100, 200);
    view3.backgroundColor = [UIColor yellowColor];
    
    // 将三个视图对象显示到屏幕上
    // 并添加到父视图中
    // 哪一个视图被先添加到父视图中，就先绘制哪一个
    // 哪一个最后添加，最后就绘制哪一个
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    [self.view addSubview:view3];
    
    // 将某一个视图调整到最前面显示
    // 参数：UIView对象，调整哪一个视图到最前方
    [self.view bringSubviewToFront:view1];
    // 将某一个视图调整到最后显示
    // 参数：UIView对象，调整哪一个视图到最后方
    [self.view sendSubviewToBack:view3];
    
    // subviews管理所有self.view的子视图的数组,总共又4个view在self.view中
    // 由于view3和view交换了位置所以subviews[3] = view
    UIView *viewBack = self.view.subviews[3];
    if(viewBack == view)
    {
        NSLog(@"相等");
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
