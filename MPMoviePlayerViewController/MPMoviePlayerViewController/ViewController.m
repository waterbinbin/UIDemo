//
//  ViewController.m
//  MPMoviePlayerViewController
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()
{
    // 新的使用AVPlayerViewController
    
    // 定义一个播放器对象
    MPMoviePlayerController *_playerController;
    
    // 定义一个播放器视图控制器
    MPMoviePlayerViewController *_playerView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *strURL = @"http://v.cctv.com/flash/mp4video6/TMS/2011/01/05/cf752b1c12ce452b3040cab2f90bc265_h264818000nero_aac32-1.mp4";
    
    NSURL *url = [NSURL URLWithString:strURL];
    
    // 旧的方法1
    // 创建一个视图播放器对象
    // P1:通过一个有效的网络视频地址作为参数
//    _playerController = [[MPMoviePlayerController alloc] initWithContentURL:url];
//    _playerController.view.frame = self.view.bounds;
//    // 视频下载后的处理编解码的过程
//    [_playerController prepareToPlay];
//    [self.view addSubview:_playerController.view];
    
    // 旧的方法2
    _playerView = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    _playerView.view.frame = self.view.bounds;
    [self.view addSubview:_playerView.view];
}

@end
