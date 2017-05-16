//
//  VCFirst.m
//  Multi-interface
//
//  Created by 王福滨 on 2017/4/21.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "VCFirst.h"

#import "VCSecond.h"

@interface VCFirst () 

@end

@implementation VCFirst

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

// 推出导航控制器2
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    VCSecond *vcSecond = [[VCSecond alloc] init];
    
    // 将当前的控制器作为代理对象赋值
    vcSecond.delegate = self;
    
    [self.navigationController pushViewController:vcSecond animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- VCSecondDelegate
- (void)changeColor:(UIColor *)color
{
    self.view.backgroundColor = color;
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
