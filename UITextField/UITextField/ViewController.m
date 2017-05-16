//
//  ViewController.m
//  UITextField
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

//添加代理
@interface ViewController () 

@property(nonatomic, strong) UITextField* textField;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建UITextView，只能输入单行文字，不能多行
    _textField = [[UITextField alloc] init];
    
    _textField.frame = CGRectMake(100, 100, 180, 40);
    
    // 设置内容文字
    //_textField.text = @"用户名";
    
    // 设置文字的字体大小
    _textField.font = [UIFont systemFontOfSize:15];
    
    // 设置字体的颜色
    _textField.textColor = [UIColor blackColor];
    
    // 设置边框的风格
    // UITextBorderStyleRoundedRect：圆角风格
    // UITextBorderStyleLine：线框风格
    // UITextBorderStyleBezel：bezel线框
    // UITextBorderStyleNone：无边框风格
    _textField.keyboardType = UITextBorderStyleRoundedRect;
    
    // 设置虚拟键盘风格
    // UIKeyboardTypeDefault：默认
    // UIKeyboardTypePhonePad：字母和数字组合
    // UIKeyboardTypeNumberPad:纯数字风格
    _textField.keyboardType = UIKeyboardTypeDefault;
    
    // 提示文字信息
    // 当text属性为空，显示此条信息
    // 浅灰色提示文字
    _textField.placeholder = @"请输入用户名";
    
    // 是否作为密码输入
    // YES:作为处理，圆点加密
    // NO：正常显示输入的文字
    _textField.secureTextEntry = NO;
    
    [self.view addSubview:_textField];
    
    // 设置代理对象
    _textField.delegate = self;
}

// 点击空白出调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 使虚拟键盘收回，不再作为第一消息响应者
    [_textField resignFirstResponder];
}

#pragma mark 设置代理函数
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"结束编辑");
}

// 是否可以输入
// YES：默认，可以输入
// NO：不能输入
- (BOOL)textFieldShouldBeginEditing:(UITextView *)textField
{
    return YES;
}

// 是否可以结束输入，默认为YES，可以
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
