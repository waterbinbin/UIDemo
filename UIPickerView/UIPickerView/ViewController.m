//
//  ViewController.m
//  UIPickerView
//
//  Created by 王福滨 on 2017/4/18.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource> // 一个处理视图选择普通事件协议，一个数据代理协议

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建选择视图对象
    // 显示多组数据和多个元素元素以供选择
    // 例如选择日期，时间，日历，地区，地址
    UIPickerView* pickerView = [[UIPickerView alloc] init];
    
    pickerView.frame = CGRectMake(10, 100, 300, 200);
    
    // 设置普通代理对象为当前视图控制器
    pickerView.delegate = self;
    
    // 设置数据代理对象为当前视图控制器
    pickerView.dataSource = self;
    
    [self.view addSubview:pickerView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIPickerViewDataSource
// 实现获取数组的协议函数
// 返回值为选择视图的组数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// 实现每组元素的个数
// 每组元素有多少行
// P1:调用此协议的选择视图本身
// P2:第几组的元素个数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 每组10个
    if(component == 0)
    {
        return 5;
    }
    else if(component == 1)
    {
        return 10;
    }
    else if(component == 2)
    {
        return 15;
    }
    
    return 10;
}

// 显示每个元素的内容
// P1:调用此协议的选择视图本身
// P2:行数
// P3:组数
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str = [NSString stringWithFormat:@"%ld组%ld行", component + 1, row + 1];
    
    return str;
}

// 设置每行元素高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 80;
}

// 可以将自定义
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg", row % 7 + 1]];
    UIImageView *iView = [[UIImageView alloc] initWithImage:image];
    iView.frame = CGRectMake(0, 0, 40, 40);
    return iView;
}
@end
