//
//  ViewController.m
//  DownLoadAndUnZip
//
//  Created by wangfubin on 2017/12/8.
//  Copyright © 2017年 wangfubin. All rights reserved.
//


#import "ViewController.h"

#import "DownLoadManager.h"
#import "UpLoadCircleView.h"
#import "NextViewController.h"
#import "ZipArchiveManager.h"

#define PICTURE_URLSTRING @"http://120.25.226.186:32812/resources/images/minion_08.png"
#define MP4_URLSTRING @"http://120.25.226.186:32812/resources/videos/minion_02.mp4"
#define ZIP_URLSTRING @"http://172.28.26.8/freestyle.zip"
#define ZIPMOV_URLSTRING @"http://172.28.26.8/minion_02.zip"

@interface ViewController () <NSURLSessionDownloadDelegate>

@property(nonatomic, strong) UIButton *downloadLittleButton;
@property(nonatomic, strong) UIImageView *littleImageView;

@property(nonatomic, strong) UIButton *downloadBigButton;
@property(nonatomic, strong) UpLoadCircleView *upLoadCircleView;

@property(nonatomic, strong) UIButton *beginButton;
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic, strong) UIButton *resumeButton;

@end

@implementation ViewController

#pragma mark -- Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self p_setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"ViewController dealloc");
}

#pragma mark -- Private
- (void)p_setupUI
{
    self.title = @"下载页面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem* next = [[UIBarButtonItem alloc] initWithTitle:@"第二级" style:UIBarButtonItemStylePlain target:self action:@selector(pressRight)];
    self.navigationItem.rightBarButtonItem = next;
    
    self.downloadLittleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.downloadLittleButton.frame = CGRectMake(100, 100, 100, 40);
    [self.downloadLittleButton setTitle:@"下载图片" forState:UIControlStateNormal];
    [self.downloadLittleButton addTarget:self action:@selector(downloadImageView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadLittleButton];
    
    self.littleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 100, 100)];
    [self.view addSubview:self.littleImageView];
    
    self.downloadBigButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.downloadBigButton.frame = CGRectMake(100, 260, 100, 40);
    [self.downloadBigButton setTitle:@"下载大文件" forState:UIControlStateNormal];
    [self.downloadBigButton addTarget:self action:@selector(onDownloadBigFileClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadBigButton];
    
    self.beginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.beginButton.frame = CGRectMake(50, 550, 100, 40);
    [self.beginButton setTitle:@"开始下载" forState:UIControlStateNormal];
    [self.beginButton addTarget:self action:@selector(onBeginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.beginButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancelButton.frame = CGRectMake(160, 550, 100, 40);
    [self.cancelButton setTitle:@"取消下载" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(onCancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cancelButton];
    
    self.resumeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.resumeButton.frame = CGRectMake(270, 550, 100, 40);
    [self.resumeButton setTitle:@"继续下载" forState:UIControlStateNormal];
    [self.resumeButton addTarget:self action:@selector(onResumeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resumeButton];
    
    self.upLoadCircleView = [[UpLoadCircleView alloc] initWithFrame:CGRectMake(100, 320, 200, 200)];
    [self.view addSubview:self.upLoadCircleView];
    
}

- (void)p_uZipfile:(NSString *)file
{
    [[ZipArchiveManager sharedObject] uZipArchiveWithFile:file completion:^{
        // 获得file的没有后缀的文件名
        NSString *fileName = [NSString stringWithFormat:@"%@.mp4",[[file lastPathComponent] stringByDeletingPathExtension]];
        NSLog(@"uzip %@", fileName);
        if([[NSFileManager defaultManager] fileExistsAtPath:fileName])
        {
            NSLog(@"uzip finish %@", fileName);
        }
    }];
}

#pragma mark -- Action
- (void)pressRight
{
    // 创建新的视图控制器
    NextViewController* nextViewController = [[NextViewController alloc] init];
    
    // 使用当前视图控制器的导航控制器对象
    [self.navigationController pushViewController:nextViewController animated:YES];
}

- (void)downloadImageView
{
    NSURL *url = [NSURL URLWithString:PICTURE_URLSTRING];
    
    __weak typeof (self) weakSelf = self;
    [[DownLoadManager sharedObject] downloadLittleFileWithURL:url completion:^(BOOL isComplete, NSString *filePath) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        if(isComplete)
        {
            [strongSelf.littleImageView setImage:[UIImage imageNamed:filePath]];
        }
    }];
}

- (void)onDownloadBigFileClick
{
//    NSURL *url = [NSURL URLWithString:ZIPMOV_URLSTRING];
    
//    NSString *fullPath = [[DownLoadManager sharedObject] downloadBigFileWithURL:url object:self];
//    if(fullPath)
//    {
//        [self p_uZipfile:fullPath];
//    }
    __weak typeof (self) weakSelf = self;
    [[ZipArchiveManager sharedObject] load:ZIPMOV_URLSTRING hasProgress:^(float progress) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.upLoadCircleView.label.text = [NSString stringWithFormat:@"%d%%", (int)(progress * 100)];
            [strongSelf.upLoadCircleView drawProgress:progress];
        });
        
    } completion:^(BOOL isCompletion) {
//        __strong typeof (weakSelf) strongSelf = weakSelf;
        NSLog(@"uzip finish");
        NSString *path = [NSString stringWithFormat:@"%@/minion_02/5.mp4",  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            NSLog(@"uzip finish has");
        }
    }];
}

- (void)onBeginButtonClick
{
    NSURL *url = [NSURL URLWithString:MP4_URLSTRING];
    
    [[DownLoadManager sharedObject] downloadBigFileWithURL:url object:self];
}

- (void)onCancelButtonClick
{
    [[DownLoadManager sharedObject] cancelDownload];
}

- (void)onResumeButtonClick
{
    [[DownLoadManager sharedObject] resumeDownload];
}

#pragma mark -- NSURLSessionDataDelegate
// 下载了数据的过程中会调用的代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    self.upLoadCircleView.label.text = [NSString stringWithFormat:@"%d%%", (int)(round(1.0 * totalBytesWritten / totalBytesExpectedToWrite * 100))];
    [self.upLoadCircleView drawProgress:1.0 * totalBytesWritten / totalBytesExpectedToWrite];
}

// 重新恢复下载的代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    
}

// 写入数据到本地的时候会调用的方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSString* fullPath =
    [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
     stringByAppendingPathComponent:downloadTask.response.suggestedFilename];;
    [[NSFileManager defaultManager] moveItemAtURL:location
                                            toURL:[NSURL fileURLWithPath:fullPath]
                                            error:nil];
    
    if(fullPath)
    {
        [self p_uZipfile:fullPath];
    }
}

// 请求完成，错误调用的代理方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if(error)
    {
        NSLog(@"didCompleteWithError %@", error);
    }
}

@end
