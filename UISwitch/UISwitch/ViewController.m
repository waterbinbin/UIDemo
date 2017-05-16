//
//  ViewController.m
//  UISwitch
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UISwitch* mySwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _mySwitch = [[UISwitch alloc] init];
    // 苹果官方的空间的位置设置
    // 位置X，Y的值可以改变
    // 宽度和高度值无法改变
    _mySwitch.frame = CGRectMake(100, 200, 180, 40);
    
    _mySwitch.backgroundColor = [UIColor blueColor];
    
    // 开光状态设置属性
    // YES：开启
    // NO：关闭
    _mySwitch.on = YES;
    // 也可以使用set函数
    [_mySwitch setOn:YES];
    
    // 设置开关状态
    // P1:状态设置
    // P2:是否开启动画效果
    [_mySwitch setOn:YES animated:YES];
    
    [self.view addSubview:_mySwitch];
    
    // 设置开启状态的风格颜色
    [_mySwitch setOnTintColor:[UIColor redColor]];
    
    // 设置开关圆按钮的风格颜色
    [_mySwitch setThumbTintColor:[UIColor greenColor]];
    
    // 设置整体风格颜色
    [_mySwitch setTintColor:[UIColor purpleColor]];
    
    // 向开关添加事件
    // P3:事件响应时的事件类型，UIControlEventValueChanged：状态发生变化时触发函数
    [_mySwitch addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
}

// 参数传入开关对象本身
- (void)swChange:(UISwitch *)sw
{
    // on表示当前结束的状态
    if(sw.on == YES)
    {
        NSLog(@"open!");
    }
    else
    {
        NSLog(@"close!");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
