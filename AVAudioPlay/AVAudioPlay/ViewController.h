//
//  ViewController.h
//  AVAudioPlay
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
// 导入视频音频播放系统库文件
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>
{
    // 播放按钮
    UIButton *_btnPlay;
    // 暂停按钮
    UIButton *_btnPause;
    // 停止按钮
    UIButton *_btnStop;
    // 音乐播放进度条
    UIProgressView *_musicProgress;
    // 音乐声音大小调整滑动条
    UISlider *_volunmSlider;
    // 静音开关
    UISwitch *_volumeOn;
    // 音频播放器对象
    AVAudioPlayer *_player;
    // 定时器
    NSTimer *_timer;
}


@end

