//
//  ViewController.m
//  NSUerDefaults
//
//  Created by 王福滨 on 2017/4/21.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 80, 40);
    [btn setTitle:@"写入文件" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pressWrite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btnRead = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnRead.frame = CGRectMake(100, 200, 80, 40);
    [btnRead setTitle:@"读取文件" forState:UIControlStateNormal];
    [btnRead addTarget:self action:@selector(pressRead) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRead];
}


// 按下写入按钮
- (void)pressWrite
{
    // 定义一个用户默认数据对象
    // 不需要alloc创建，用户默认数据对象单例模式
    // standardUserDefaults：获取全局唯一的实例对象
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    // 存储字符串对象
    // 可以将对象存储到内部文件中国年
    // P1:要存储的对象id
    // P2:对象的名字key：NSString
    [ud setObject:@"Michael" forKey:@"NAME"];
    
    NSNumber *num = [NSNumber numberWithInt:100];
    
    // 存储数据对象
    // 只能存储能够文件化的对象
    [ud setObject:num forKey:@"NUM"];
    
    // 不能存储动态创建的对象
    // 不能存储不能够文件化的对象
    //[ud setObject:self.view forKey:@"VIEW"];
    
    // 存整型数据
    [ud setInteger:123 forKey:@"INT"];
    
    // 存BOOL数据
    [ud setBool:YES forKey:@"BOOL"];
    
    // 存整型数据
    [ud setFloat:1.555f forKey:@"FLOAT"];
    
    NSArray *array = [NSArray arrayWithObjects:@"11", @"22", @"33", nil];
    // 存数组
    [ud setObject:array forKey:@"ARRAY"];
}

// 按下读取按钮
- (void)pressRead
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    id object = [ud objectForKey:@"NAME"];
    NSString *name = (NSString *)object;
    NSLog(@"name = %@", name);
    
    object = [ud objectForKey:@"NUM"];
    NSNumber *num = (NSNumber *)object;
    NSLog(@"num = %@", num);
    
    NSInteger iv = [ud integerForKey:@"INT"];
    NSLog(@"iv = %ld", iv);
    
    BOOL bv = [ud boolForKey:@"BOOL"];
    NSLog(@"bv = %d", bv);
    
    float fv = [ud floatForKey:@"FLOAT"];
    NSLog(@"fv = %f", fv);
    
    NSArray *array = [ud objectForKey:@"ARRAY"];
    NSLog(@"array = %@", array);
    
    [ud removeObjectForKey:@"ARRAY"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
