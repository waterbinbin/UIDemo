//
//  ViewController.m
//  DuiduipengGame
//
//  Created by wangfubin on 2017/5/16.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)startGame
{
    NSMutableArray *arrStr = [[NSMutableArray alloc] init];
    for(int k = 0; k < 18; ++k)
    {
        // 产生随机图片
        int random = arc4random() % 7;
        NSString *strImage = [NSString stringWithFormat:@"%d", random];
        [arrStr addObject:strImage];
        [arrStr addObject:strImage];
    }
    
    for(int i = 0; i < 6; ++i)
    {
        for(int j = 0; j < 6; j++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:3];
    
            btn.frame = CGRectMake(10 + 44 * j, 40 + 44 * i, 44, 44);
            
            [UIView commitAnimations];
            // 产生随机图片
            int randomIndex = arc4random() % arrStr.count;
            NSString *strImage = arrStr[randomIndex];
            NSInteger tag = [strImage integerValue];
            btn.tag = tag;
            
            [arrStr removeObjectAtIndex:randomIndex];
            UIImage *image = [UIImage imageNamed:strImage];
            [btn setImage:image forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        }
    }
}

- (void)pressBtn:(UIButton *)btn
{
    // 创建一个静态变量保存第一次按下的按钮
    static UIButton *btnFirst = nil;
    if(btnFirst == nil)
    {
        btnFirst = btn;
        // 锁定第一个按钮
        btnFirst.enabled = NO;
    }
    else
    {
        if(btnFirst.tag == btn.tag)
        {
            // 2个按钮相同
            btnFirst.hidden = YES;
            btn.hidden = YES;
            btnFirst = nil;
        }
        else
        {
            btnFirst.enabled = YES;
            btnFirst = nil;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self startGame];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
