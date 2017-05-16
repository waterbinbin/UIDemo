//
//  ViewController.m
//  AutoLayout
//
//  Created by 王福滨 on 2017/4/14.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    // 创建父视图
    UIView* _superView;
    
    //左上角label
    UILabel* _label1;
    //右上角label
    UILabel* _label2;
    //右下角label
    UILabel* _label3;
    //左下角label
    UILabel* _label4;
    
    UIView* _viewCenter;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _superView = [[UIView alloc] init];
    _superView.frame = CGRectMake(20, 20, 180, 280);
    _superView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_superView];
    
    // 位置相对于父视图
    _label1 = [[UILabel alloc] init];
    _label1.frame = CGRectMake(0, 0, 40, 40);
    _label1.text = @"1";
    _label1.backgroundColor = [UIColor greenColor];
    
    _label2 = [[UILabel alloc] init];
    _label2.frame = CGRectMake(180 - 40, 0, 40, 40);
    _label2.text = @"2";
    _label2.backgroundColor = [UIColor greenColor];
    
    _label3 = [[UILabel alloc] init];
    _label3.frame = CGRectMake(180 - 40, 280 - 40, 40, 40);
    _label3.text = @"3";
    _label3.backgroundColor = [UIColor greenColor];
    
    _label4 = [[UILabel alloc] init];
    _label4.frame = CGRectMake(0, 280 - 40, 40, 40);
    _label4.text = @"4";
    _label4.backgroundColor = [UIColor greenColor];
    
    [_superView addSubview:_label1];
    [_superView addSubview:_label2];
    [_superView addSubview:_label3];
    [_superView addSubview:_label4];
    
    _viewCenter = [[UIView alloc] init];
    _viewCenter.frame = CGRectMake(0, 0, _superView.bounds.size.width, 40);
    _viewCenter.center = CGPointMake(180 / 2, 280 / 2);
    _viewCenter.backgroundColor = [UIColor orangeColor];
    [_superView addSubview:_viewCenter];
    
    // 自动布局属性设置，通过此变量来调整视图在父亲视图中的位置和大小
    _viewCenter.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _label2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    _label3.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
    _label4.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static BOOL isLarge = NO;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    
    if(isLarge == NO)
    {
        _superView.frame = CGRectMake(10, 10, 300, 480);
    }
    else
    {
        _superView.frame = CGRectMake(20, 20, 180, 280);
    }
    
    [UIView commitAnimations];
    
    isLarge = !isLarge;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
