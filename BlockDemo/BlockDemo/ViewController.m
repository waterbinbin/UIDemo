//
//  ViewController.m
//  BlockDemo
//
//  Created by 王福滨 on 2017/10/19.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

// 用块引用其所属对象时不要出现保留环
// 或者在block外使用weak，里边使用strong

#import "ViewController.h"

#import "BlockDemo.h"

@interface ViewController ()
{
    BlockDemo *_blockDemo;
    NSString *_stringData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self printString];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printString
{
    NSString *url = @"url";
    BlockDemo *blockDemo = [[BlockDemo alloc] initWithURL:url];
    [blockDemo startWithCompletionHandler:^(NSString *sMsg) {
        NSLog(@"Request URL [%@] finished", blockDemo.url);
        _stringData = sMsg;
        NSLog(@"printString stringData:%@", _stringData);
    }];
}

@end
