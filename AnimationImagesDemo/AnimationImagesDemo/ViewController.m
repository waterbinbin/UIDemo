//
//  ViewController.m
//  AnimationImagesDemo
//
//  Created by 王福滨 on 2017/5/17.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"
#import <YYKit.h>

@interface ViewController ()

@property (nonatomic, strong) YYAnimatedImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat width = [UIScreen mainScreen].bounds.size.width/3.0;
    CGFloat heigth = [UIScreen mainScreen].bounds.size.height - 44;
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, heigth, width, 44)];
    [btn1 setTitle:@"播放" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor redColor];
    btn1.tag = 1;
    [btn1 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(width, heigth, width, 44)];
    [btn2 setTitle:@"暂停" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor greenColor];
    btn2.tag = 2;
    [btn2 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(2*width, heigth, width, 44)];
    [btn3 setTitle:@"停止" forState:UIControlStateNormal];
    btn3.tag = 3;
    [btn3 addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn3.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn3];
    
    [self animationImages];
    //[self animationImagesWithYYImage];

}

- (void)btnClicked:(UIButton *)btn  {
    switch (btn.tag) {
        case 1: // play
        {
            [_imageView startAnimating];
        }
            break;
        case 2: // pause
        {
            
        }
            break;
        case 3: // stop
        {
            [_imageView stopAnimating];
        }
            break;
            
        default:
            break;
    }
}


/// 内存占用，YYImage 重写的imageNamed和原生的内存占用差别不大
- (void)YYImageTest2 {
    // 循环500次测试
    for (NSInteger i = 0;  i < 500; i ++ ) {
        
        //        UIImage *image2 = [UIImage imageNamed:@"pickView01"];
        //        UIImageView *imageView3 = [[UIImageView alloc] initWithImage:image2];
        //        [self.view addSubview:imageView3];
        
        YYImage *image = [YYImage imageNamed:@"1"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self.view addSubview:imageView];
    }
}

/// 内存占用，YYImage 重写的imageWithData会对内存进行优化，降低内存占用
- (void)YYImageTest1 {
    // 循环100次测试
    for (NSInteger i = 0;  i < 100; i ++ ) {
        
        UIImage *image2 = [UIImage imageNamed:@"1"];
        NSData *data = UIImagePNGRepresentation(image2);
        //        UIImage *image3 = [UIImage imageWithData:data scale:1]; // 原始方法加载的图片内存中没情况，会一直累加，大概68M
        YYImage *image3 = [YYImage imageWithData:data scale:1];// 每次for循环结束都会回收内存，大概30M，区别很明显
        UIImageView *imageView3 = [[UIImageView alloc] initWithImage:image3];
        [self.view addSubview:imageView3];
    }
}

/// iOS 信号量机制使用
- (void)seamaphore  {
    int data = 3;
    __block int mainData = 0;
    __block dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    
    dispatch_queue_t queue = dispatch_queue_create("StudyBlocks", NULL);
    
    dispatch_async(queue, ^(void) {
        int sum = 0;
        for(int i = 0; i < 444445; i++)
        {
            sum += data;
            
            NSLog(@" >> Sum: %d", sum);
        }
        // 添加信号量
        dispatch_semaphore_signal(sem);
    });
    // 等待信号量
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    for(int j=0;j<5;j++)
    {
        mainData++;
        NSLog(@">> Main Data: %d",mainData);
    }
}

/// 1、原生播放动态图片(轮流播放多张静态图片)，这个最占用内存
- (void)animationImages {
    //创建UIImageView，添加到界面
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 200, 300)];
    [self.view addSubview:imageView];
    imageView.center = self.view.center;
    //创建一个数组，数组中按顺序添加要播放的图片（图片为静态的图片）
    NSMutableArray *imgArray = [NSMutableArray array];
    for (int i=0; i<24; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"bye.png",i]];
        [imgArray addObject:image];
    }
    //把存有UIImage的数组赋给动画图片数组
    imageView.animationImages = imgArray;
    //设置执行一次完整动画的时长
    imageView.animationDuration = 2;
    //动画重复次数 （0为重复播放）
    imageView.animationRepeatCount = 2;
    //开始播放动画
    [imageView startAnimating];
}
/// 2、播放动态图片(gif,UIWebView实现)，39M
- (void)animationImagesWithUIWebView {
    //创建一个webView，添加到界面
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    [self.view addSubview:web];
    
    //得到图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"pickView使用" ofType:@"gif"];
    //将图片转为NSData
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    //自动调整尺寸
    web.scalesPageToFit = YES;
    //禁止滚动
    web.scrollView.scrollEnabled = NO;
    //设置透明效果
    web.backgroundColor = [UIColor clearColor];
    web.opaque = 0;
    //加载数据
    [web loadData:gifData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
}
/// 3、播放动态图片(gif,YYKit实现)，30M
- (void)animationImagesWithYYImage {
    // YYImage
    YYImage *image = [YYImage imageNamed:@"pickView使用"];
    _imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    _imageView.autoPlayAnimatedImage = NO;
    [self.view addSubview:_imageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
