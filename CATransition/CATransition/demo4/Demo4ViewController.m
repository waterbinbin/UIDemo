//
//  Demo4ViewController.m
//  CATransition
//
//  Created by wangfubin on 2018/2/7.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "Demo4ViewController.h"

#import "LeftView.h"
#import "BottomView.h"

@interface Demo4ViewController ()

@property (assign, nonatomic) BOOL isBeginSlid;//记录开始触摸的方向
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) LeftView *leftView;
@property (nonatomic, weak) BottomView *bottomView;

@end

@implementation Demo4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"上下左右拖动view出来";
    [self.view addSubview:self.imageView];
    self.imageView.userInteractionEnabled = YES;
    
    LeftView *tmpLeftView = [[LeftView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:tmpLeftView];
    self.leftView = tmpLeftView;
    
    BottomView *tmpBottomView = [[BottomView alloc] initWithFrame:CGRectMake(0, -self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:tmpBottomView];
    self.bottomView = tmpBottomView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView *)imageView
{
    if(!_imageView)
    {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
        [_imageView setImage:[UIImage imageNamed:@"0.jpeg"]];
    }
    return _imageView;
}

#pragma mark -- 界面的滑动

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.isBeginSlid = YES;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //    1.获取手指
    UITouch *touch = [touches anyObject];
    //    2.获取触摸的上一个位置
    CGPoint lastPoint;
    CGPoint currentPoint;
    
    //    3.获取偏移位置
    CGPoint tempCenter;
    
    if (self.isBeginSlid) {//首次触摸进入
        lastPoint = [touch previousLocationInView:self.imageView];
        currentPoint = [touch locationInView:self.imageView];
        
        
        //判断是左右滑动还是上下滑动
        if (ABS(currentPoint.x - lastPoint.x) > ABS(currentPoint.y - lastPoint.y)) {
            //    3.获取偏移位置
            tempCenter = self.leftView.center;
            tempCenter.x += currentPoint.x - lastPoint.x;//左右滑动
            //禁止向左划
            if (self.leftView.frame.origin.x == 0 && currentPoint.x -lastPoint.x > 0) {//滑动开始是从0点开始的，并且是向右滑动
                self.leftView.center = tempCenter;
                
            }
            //            else if(self.livingInfoView.frame.origin.x > 0){
            //                self.livingInfoView.center = tempCenter;
            //            }
            //            NSLog(@"%@-----%@",NSStringFromCGPoint(tempCenter),NSStringFromCGPoint(self.livingInfoView.center));
        }else{
            //    3.获取偏移位置
            tempCenter = self.bottomView.center;
            tempCenter.y += currentPoint.y - lastPoint.y;//上下滑动
            //禁止向划
            if (self.bottomView.frame.origin.y == 0 && currentPoint.y -lastPoint.y < 0) {//滑动开始是从0点开始的，并且是向下滑动
                self.bottomView.center = tempCenter;
                
            }
        }
    }else{//滑动开始后进入，滑动方向要么水平要么垂直
        if (self.bottomView.frame.origin.y != 0){//垂直的优先级高于左右滑，因为左右滑的判定是不等于0
            
            lastPoint = [touch previousLocationInView:self.bottomView];
            currentPoint = [touch locationInView:self.bottomView];
            tempCenter = self.bottomView.center;
            
            tempCenter.y += currentPoint.y -lastPoint.y;
            NSLog(@"xxx %f", tempCenter.y);
            //禁止向下划
            if (self.bottomView.frame.origin.y == 0 && currentPoint.y -lastPoint.y > 0) {//滑动开始是从0点开始的，并且是向下滑动
                self.bottomView.center = tempCenter;
                
            }else if(self.bottomView.frame.origin.y < 0){
                self.bottomView.center = tempCenter;
            }
            
        }else if (self.leftView.frame.origin.x != 0) {
            
            lastPoint = [touch previousLocationInView:self.leftView];
            currentPoint = [touch locationInView:self.leftView];
            tempCenter = self.leftView.center;
            
            tempCenter.x += currentPoint.x -lastPoint.x;
            
            //禁止向左划
            
            if (self.leftView.frame.origin.x == 0 && currentPoint.x -lastPoint.x > 0) {//滑动开始是从0点开始的，并且是向右滑动
                self.leftView.center = tempCenter;
                
            }else if(self.leftView.frame.origin.x > 0){
                self.leftView.center = tempCenter;
            }
            
        }
    }
    
    self.isBeginSlid = NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //    NSLog(@"%.2f-----%.2f",livingInfoView.frame.origin.y,Screen_height * 0.8);
    
    //    水平滑动判断
    //在控制器这边滑动判断如果滑动范围没有超过屏幕的十分之八livingInfoView还是离开屏幕
    if (self.leftView.frame.origin.x > self.view.frame.size.width * 0.8) {
        [UIView animateWithDuration:0.06 animations:^{
            CGRect frame = self.leftView.frame;
            frame.origin.x = self.view.frame.size.width;
            self.leftView.frame = frame;
        }];

    }else{//否则则回到屏幕0点
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.leftView.frame;
            frame.origin.x = 0;
            self.leftView.frame = frame;

        }];
    }
    
    NSLog(@"xxxx %f", self.bottomView.frame.origin.y);
    //    上下滑动判断
    if (self.bottomView.frame.origin.y > -self.view.frame.size.height * 0.8) {
        //        切换到下一频道
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.bottomView.frame;
            frame.origin.y = 0;
            self.bottomView.frame = frame;
        }];
        
    }else{
        //        切换到上一频道
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.bottomView.frame;
            frame.origin.y = -self.view.frame.size.height;
            self.bottomView.frame = frame;
        }];
        
    }
    //        回到原始位置等待界面重新加载
//    CGRect frame = self.imageView.frame;
//    frame.origin.y = 0;
//    self.imageView.frame = frame;
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //    水平滑动判断
    //在控制器这边滑动判断如果滑动范围没有超过屏幕的十分之八livingInfoView还是离开屏幕
    if (self.leftView.frame.origin.x > self.view.frame.size.width * 0.8) {
        [UIView animateWithDuration:0.06 animations:^{
            CGRect frame = self.leftView.frame;
            frame.origin.x = self.view.frame.size.height;
            self.leftView.frame = frame;
        }];
        
    }else{//否则则回到屏幕0点
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.leftView.frame;
            frame.origin.x = 0;
            self.leftView.frame = frame;
            
        }];
    }
    
    //    上下滑动判断
    if (self.bottomView.frame.origin.y > self.view.frame.size.height * 0.2) {
        //        切换到下一频道
        [UIView animateWithDuration:0.06 animations:^{
            CGRect frame = self.bottomView.frame;
            frame.origin.y = -self.view.frame.size.height;
            self.bottomView.frame = frame;
        }];

    }else {
        //        切换到上一频道
        [UIView animateWithDuration:0.06 animations:^{
            CGRect frame = self.bottomView.frame;
            frame.origin.y = 0;
            self.bottomView.frame = frame;
        }];

    }
    //        回到原始位置等待界面重新加载
//    CGRect frame = self.leftView.frame;
//    frame.origin.y = 0;
//    self.leftView.frame = frame;
}

@end
