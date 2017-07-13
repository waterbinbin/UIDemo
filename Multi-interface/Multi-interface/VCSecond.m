//
//  VCSecond.m
//  Multi-interface
//
//  Created by 王福滨 on 2017/4/21.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "VCSecond.h"
#import "AppStatus.h"


@interface VCSecond ()

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UITextField *textField1;
@property(nonatomic, strong) UITextField *textField2;
@property(nonatomic, strong) UIButton *button;

@end

@implementation VCSecond

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.属性传值
    _textField = [[UITextField alloc] init];
    [_textField setFrame:CGRectMake(170, 100, 150, 40)];
    _textField.text = _firstValue;
    [self.view addSubview:_textField];
    
    _textField1 = [[UITextField alloc] init];
    [_textField1 setFrame:CGRectMake(170, 150, 150, 40)];
    _textField1.text = @"通知传值";
    [self.view addSubview:_textField1];
    
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(170, 200, 100, 40)];
    [_button setTitle:@"block传值" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _textField2 = [[UITextField alloc] init];
    [_textField2 setFrame:CGRectMake(170, 250, 150, 40)];
    _textField2.text = [AppStatus shareInstance].contextStr;
    [self.view addSubview:_textField2];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *btnChange = [[UIBarButtonItem alloc] initWithTitle:@"改变颜色" style:UIBarButtonItemStyleDone target:self action:@selector(pressChange)];
    self.navigationItem.rightBarButtonItem = btnChange;
}


// 点击按钮，触发代理事件
- (void)pressChange
{
    // 2.委托delegate方式
    [_delegate changeColor:[UIColor redColor]];
    
    // 3.通知notification方式
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeNameNotification"
                                                        object:self
                                                      userInfo:@{@"name":_textField1.text}];
}

// 4.block方式
- (void)returnTextName:(SecondBlock)block
{
    self.secondBlock = block;
}

- (void)buttonPress
{
    if(self.secondBlock != nil)
    {
        self.secondBlock(_button.titleLabel.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
