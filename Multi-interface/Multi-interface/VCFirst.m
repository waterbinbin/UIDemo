//
//  VCFirst.m
//  Multi-interface
//
//  Created by 王福滨 on 2017/4/21.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

// 多界面传值：
// 1.属性传值
// 2.委托delegate方式
// 3.通知notification方式
// 4.block方式
// 5.单例模式方式
// 6.UserDefault或者文件方式

#import "VCFirst.h"

#import "VCSecond.h"
#import "AppStatus.h"

@interface VCFirst ()

@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UIButton *button1;

@end

@implementation VCFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button setFrame:CGRectMake(50, 100, 100, 40)];
    [_button setTitle:@"跳转到界面2" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _textField = [[UITextField alloc] init];
    [_textField setFrame:CGRectMake(170, 100, 150, 40)];
    _textField.text = @"界面1的值传到2";
    [self.view addSubview:_textField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ChangeNameNotification:)
                                                 name:@"ChangeNameNotification"
                                               object:nil];
    
    _button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_button1 setFrame:CGRectMake(100, 200, 100, 40)];
    [_button1 setTitle:@"单例传值" forState:UIControlStateNormal];
    [_button1 addTarget:self action:@selector(buttonPress1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 1.属性传值
- (void)buttonPress
{
    VCSecond *vcSecond = [[VCSecond alloc] init];
    vcSecond.firstValue = _textField.text;
    [self.navigationController pushViewController:vcSecond animated:YES];
    
    // 4.block方式
    [vcSecond returnTextName:^(NSString *name) {
        _textField.text = name;
    }];
}

// 2.委托delegate方式
// 推出导航控制器2
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    VCSecond *vcSecond = [[VCSecond alloc] init];
    
    // 将当前的控制器作为代理对象赋值
    vcSecond.delegate = self;
    
    [self.navigationController pushViewController:vcSecond animated:YES];
}

// 3.通知notification方式
- (void)ChangeNameNotification:(NSNotification *)notification
{
    NSDictionary *nameDictionary = [notification userInfo];
    _textField.text = [nameDictionary objectForKey:@"name"];
}

// 5.单例模式方式
- (void)buttonPress1
{
    [AppStatus shareInstance].contextStr = @"单例传值";
    VCSecond *vcSecond = [[VCSecond alloc] init];
    [self.navigationController pushViewController:vcSecond animated:YES];
}

#pragma mark -- VCSecondDelegate
- (void)changeColor:(UIColor *)color
{
    self.view.backgroundColor = color;
}

-(void)addNotificationObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
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
