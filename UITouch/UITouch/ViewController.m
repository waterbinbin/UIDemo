//
//  ViewController.m
//  UITouch
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic) CGPoint mPtLast;
@property(nonatomic, strong) UIImageView* iView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 加载图片到屏幕
    UIImage* image = [UIImage imageNamed:@"2.jpeg"];
    _iView = [[UIImageView alloc] initWithImage:image];
    _iView.frame = CGRectMake(50, 100, 220, 300);
    
    [self.view addSubview:_iView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 当点击屏幕的开始的瞬间调用此函数
// 一次点击的过程
// 1 state：手指触碰屏幕的瞬间
// 2 state：手指触到屏幕并且没有离开，按住屏幕时，包括按住屏幕并且移动手指
// 3 state：手指离开屏幕的瞬间

// 1 state
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"手指触碰瞬间");
    // 获取点击对象，anyObject获取任何一个点击对象
    // 只有一个点击对象，获得的对象就是我们的点击对象
    UITouch* touch = [touches anyObject];
    
    // tapCount记录当前点击的次数
    if(touch.tapCount == 1)
    {
        NSLog(@"one");
    }
    else if(touch.tapCount == 2)
    {
        NSLog(@"two");
    }
    
    _mPtLast = [touch locationInView:self.view];
}

// 2 state
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"手指移动");
    UITouch* touch = [touches anyObject];
    
    // 获得当前手指在屏幕上的相对坐标
    // 相对于当前视图的坐标
    CGPoint pt = [touch locationInView:self.view];
    
    // 每次移动的偏移量
    float xOffset = pt.x - _mPtLast.x;
    float yOffset = pt.y - _mPtLast.y;
    
    //UIImageView* iView = (UIImageView *)[self.view viewWithTag:101];
    _mPtLast = pt;
    NSLog(@"X = %f, Y = %f", pt.x, pt.y);
    
    _iView.frame = CGRectMake(_iView.frame.origin.x + xOffset, _iView.frame.origin.y + yOffset, _iView.frame.size.width, _iView.frame.size.height);
}

// 3 state
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"手指离开");
}

@end
