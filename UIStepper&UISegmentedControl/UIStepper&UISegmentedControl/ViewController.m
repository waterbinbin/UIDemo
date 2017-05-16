//
//  ViewController.m
//  UIStepper&UISegmentedControl
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) UIStepper* stepper;
@property(nonatomic, strong) UISegmentedControl* segControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // UIStepper
    // 创建步进器对象
    _stepper = [[UIStepper alloc] init];
    
    // 设置位置，宽高不能变更
    _stepper.frame = CGRectMake(100, 100, 80, 40);
    
    // 设置步进器的最小值
    _stepper.minimumValue = 0;
    
    // 设置步进器的最大值
    _stepper.maximumValue = 0;
    
    // 设置步进器的当前值，默认为0
    _stepper.value = 10;
    
    // 设置步进值，每次向前或者向后的步伐值
    _stepper.stepValue = 1;
    
    // 是否可以重复响应事件操作
    _stepper.autorepeat = YES;
    
    // 是否将步进结果通过事件函数响应出来
    _stepper.continuous = YES;
    
    [_stepper addTarget:self action:@selector(stepChange) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_stepper];
    
    // UISegmentedControl
    // 创建分栏控制器
    _segControl = [[UISegmentedControl alloc] init];
    
    _segControl.frame = CGRectMake(10, 200, 300, 40);
    
    // 添加一个按钮元素
    // P1:按钮选项文字
    // P2:按钮的索引位置
    // P3:是否插入动画
    [_segControl insertSegmentWithTitle:@"0元" atIndex:0 animated:NO];
    [_segControl insertSegmentWithTitle:@"5元" atIndex:1 animated:NO];
    [_segControl insertSegmentWithTitle:@"10元" atIndex:2 animated:NO];
    
    // 当前默认按钮索引设置
    _segControl.selectedSegmentIndex = 0;
    
    [_segControl addTarget:self action:@selector(segChange) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_segControl];
}

- (void)stepChange
{
    NSLog(@"_stepper");
}

- (void)segChange
{
    NSLog(@"_segControl");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
