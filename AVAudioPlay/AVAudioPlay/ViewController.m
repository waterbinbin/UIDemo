//
//  ViewController.m
//  AVAudioPlay
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _btnPlay = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPlay.frame = CGRectMake(100, 100, 100, 40);
    [_btnPlay setTitle:@"播放" forState:UIControlStateNormal];
    [_btnPlay addTarget:self action:@selector(pressPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnPlay];
    
    _btnPause = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnPause.frame = CGRectMake(100, 160, 100, 40);
    [_btnPause setTitle:@"暂停" forState:UIControlStateNormal];
    [_btnPause addTarget:self action:@selector(pressPause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnPause];
    
    _btnStop = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _btnStop.frame = CGRectMake(100, 220, 100, 40);
    [_btnStop setTitle:@"停止" forState:UIControlStateNormal];
    [_btnStop addTarget:self action:@selector(pressStop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btnStop];
    
    _musicProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 300, 300, 20)];
    _musicProgress.progress = 0;
    [self.view addSubview:_musicProgress];
    
    _volunmSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 380, 300, 20)];
    _volunmSlider.maximumValue = 100;
    _volunmSlider.minimumValue = 0;
    [_volunmSlider addTarget:self action:@selector(volumeChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_volunmSlider];
    
    [self createAVPlayer];
}

- (void)createAVPlayer
{
    NSString *str = [[NSBundle mainBundle] pathForResource:@"Wonderful Tonight" ofType:@"mp3"];
    NSURL *urlMusic = [NSURL fileURLWithPath:str];
    // 创建音频播放器对象
    // P1:音频播放器地址文件
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:urlMusic error:nil];
    
    // 准备播放，解码工作
    [_player prepareToPlay];
    // 循环播放次数，-1是无限循环
    _player.numberOfLoops = 1;
    // 设置音量大小
    _player.volume = 0.5;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(updateT)
                                            userInfo:nil
                                             repeats:YES];
}

- (void)updateT
{
    _musicProgress.progress = _player.currentTime / _player.duration;
}

- (void)pressPlay
{
    [_player play];
}

- (void)pressPause
{
    [_player pause];
}

- (void)pressStop
{
    [_player stop];
    // 当前播放时间清0
    _player.currentTime = 0;
}

- (void)volumeChange:(UISlider *)volunmSlider
{
    // 设置音量大小
    _player.volume = volunmSlider.value / 100;
}

// 当音乐播放完成时
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    // 停止定时器
    [_timer invalidate];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
