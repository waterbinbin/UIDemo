//
//  ViewController.m
//  CycleProgress
//
//  Created by wangfubin on 2017/11/15.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

#import "ViewController.h"

#import "CycleView.h"

@interface ViewController ()

@property(nonatomic, strong) CycleView *cycleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _cycleView = [[CycleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:_cycleView];
    _cycleView.label.text = [NSString stringWithFormat:@"%.2f%%", 0.02*100];
    [self.cycleView drawProgress:0.5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
