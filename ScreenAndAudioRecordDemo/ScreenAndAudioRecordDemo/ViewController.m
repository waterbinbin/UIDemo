//
//  ViewController.m
//  ScreenAndAudioRecordDemo
//
//  Created by wangfubin on 2017/9/19.
//  Copyright © 2017年 Huya.Inc. All rights reserved.
//

#import "ViewController.h"

#import "HooyaAudioRecorder.h"
#import "HooyaScreenRecorder.h"
#import "HooyaMergeVideoAndAudio.h"

#define VEDIOPATH @"vedioPath"

@interface ViewController ()<HooyaScreenRecorderDelegate, AVAudioRecorderDelegate, HooyaAudioRecorderDelegate>

@property(nonatomic, strong) UIImageView *imageView;

@property(nonatomic, strong) HooyaScreenRecorder *screenRecorder;
@property(nonatomic, strong) HooyaAudioRecorder *audioRecord;
@property(nonatomic, strong) NSString* opPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(100, 100, 80, 80);
    _imageView.image = [UIImage imageNamed:@"0.jpeg"];
    [self.view addSubview:_imageView];
    
    UIButton *btnMove = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnMove.frame = CGRectMake(120, 360, 80, 40);
    [btnMove setTitle:@"移动" forState:UIControlStateNormal];
    [btnMove addTarget:self action:@selector(pressMove) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnMove];
    
    UIButton *btnScale = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnScale.frame = CGRectMake(120, 410, 80, 40);
    [btnScale setTitle:@"缩放" forState:UIControlStateNormal];
    [btnScale addTarget:self action:@selector(pressScale) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnScale];
    
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnStart.frame = CGRectMake(120, 460, 80, 40);
    [btnStart setTitle:@"开始" forState:UIControlStateNormal];
    [btnStart addTarget:self action:@selector(pressStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStart];
    
    UIButton *btnEnd = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnEnd.frame = CGRectMake(120, 510, 80, 40);
    [btnEnd setTitle:@"结束" forState:UIControlStateNormal];
    [btnEnd addTarget:self action:@selector(pressEnd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnd];
    
    _screenRecorder = [HooyaScreenRecorder sharedInstance];
    _screenRecorder.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Action

- (void)pressMove
{
    // 开始动画函数，准备动画的开始工作
    [UIView beginAnimations:nil context:nil];
    
    // 动画的实际的目标结果
    // 设置动画时间函数，参数时间长度，以秒为单位
    [UIView setAnimationDuration:2];
    // 设置动画开始的延时时间,进行延时动画的处理
    [UIView setAnimationCurve:0];
    // 设置动画的代理对象
    [UIView setAnimationDelegate:self];
    // 设置动画运轨迹的方式
    // UIViewAnimationCurveLinear匀速
    // EASEIN加速
    // EASEOUT减速
    // EASEINOUT开始加速后边减速
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // 设置动画结束调用的函数
    [UIView setAnimationDidStopSelector:@selector(stopAnim)];
    // 目标位置
    _imageView.frame = CGRectMake(220, 100, 80, 80);
    _imageView.alpha = 0.3;
    
    // 提交运动动画
    [UIView commitAnimations];
}

- (void)stopAnim
{
    NSLog(@"动画结束");
}

- (void)pressScale
{
    // 开始动画函数，准备动画的开始工作
    [UIView beginAnimations:nil context:nil];
    
    // 动画的实际的目标结果
    // 设置动画时间函数，参数时间长度，以秒为单位
    [UIView setAnimationDuration:2];
    // 设置动画开始的延时时间,进行延时动画的处理
    [UIView setAnimationCurve:0];
    // 设置动画的代理对象
    [UIView setAnimationDelegate:self];
    // 设置动画运轨迹的方式
    // UIViewAnimationCurveLinear匀速
    // EASEIN加速
    // EASEOUT减速
    // EASEINOUT开始加速后边减速
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    // 设置动画结束调用的函数
    [UIView setAnimationDidStopSelector:@selector(stopAnim)];
    // 目标位置
    _imageView.frame = CGRectMake(100, 100, 160, 160);
    _imageView.alpha = 0.3;
}

- (void)pressStart
{
    [_screenRecorder startRecording];
    NSLog(@"Start recording");
    if (!_audioRecord) {
        _audioRecord = [[HooyaAudioRecorder alloc]init];
        _audioRecord.recorder.delegate=self;
        _audioRecord.delegate=self;
    }
    
    NSString* path=[self getPathByFileName:VEDIOPATH ofType:@"wav"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]){
        [fileManager removeItemAtPath:path error:nil];
    }
    [self performSelector:@selector(toStartAudioRecord) withObject:nil afterDelay:0.1];
}

- (void)pressEnd
{
    [_screenRecorder stopRecordingWithCompletion:^{
        NSLog(@"Finished recording");
    }];
}

#pragma mark -- Private

- (void)video: (NSString *)videoPath didFinishSavingWithError:(NSError *) error contextInfo: (void *)contextInfo{
    if (error) {
        NSLog(@"---%@",[error localizedDescription]);
    }
}

- (void)mergedidFinish:(NSString *)videoPath WithError:(NSError *)error
{
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    NSString* currentDateStr=[dateFormatter stringFromDate:[NSDate date]];
    
    NSString* fileName=[NSString stringWithFormat:@"screenandaudiorecord%@.mov",currentDateStr];
    
    NSString* path=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@",fileName]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:videoPath])
    {
        NSError *err=nil;
        [[NSFileManager defaultManager] moveItemAtPath:videoPath toPath:path error:&err];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"allVideoInfo"]) {
        NSMutableArray* allFileArr=[[NSMutableArray alloc] init];
        [allFileArr addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"allVideoInfo"]];
        [allFileArr insertObject:fileName atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:allFileArr forKey:@"allVideoInfo"];
    }
    else{
        NSMutableArray* allFileArr=[[NSMutableArray alloc] init];
        [allFileArr addObject:fileName];
        [[NSUserDefaults standardUserDefaults] setObject:allFileArr forKey:@"allVideoInfo"];
    }
    
    //音频与视频合并结束，存入相册中
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
        UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (NSString*)getPathByFileName:(NSString *)_fileName ofType:(NSString *)_type
{
    NSString* fileDirectory = [[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:_fileName]stringByAppendingPathExtension:_type];
    return fileDirectory;
}

#pragma mark -- HooyaAudioRecorderDelegate
/**
 *  开始录音
 */
-(void)toStartAudioRecord
{
    [_audioRecord beginRecordByFileName:VEDIOPATH];
}
/**
 *  音频录制结束合成视频音频
 */
-(void)wavComplete
{
    //视频录制结束,为视频加上音乐
    if (_audioRecord)
    {
        NSString* path=[self getPathByFileName:VEDIOPATH ofType:@"wav"];
        [HooyaMergeVideoAndAudio mergeVideo:_opPath andAudio:path andTarget:self andAction:@selector(mergedidFinish:WithError:)];
    }
}

#pragma mark -- HooyaScreenRecorderDelegate
- (void)recordingFinished:(NSString*)outputPath
{
    _opPath=outputPath;
    if (_audioRecord) {
        [_audioRecord endRecord];
    }
    //[self mergedidFinish:outputPath WithError:nil];
}


@end
