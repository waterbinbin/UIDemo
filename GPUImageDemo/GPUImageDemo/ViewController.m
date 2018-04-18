//
//  ViewController.m
//  GPUImageDemo
//
//  Created by wangfubin on 2018/3/19.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

// 参考落影大神：https://www.jianshu.com/p/7a58a7a61f4c

#import "ViewController.h"

#import <GPUImage/GPUImage.h>
#import <GPUImageView.h>
#import <GPUImageVideoCamera.h>
#import <GPUImageSepiaFilter.h>
#import "GPUImageBeautifyFilter.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <GPUImagePicture.h>
#import <GPUImageTiltShiftFilter.h>

@interface ViewController ()

/*
 * 教程一：GPUImageFilter与GPUImageFramebuffer
 */
@property (nonatomic, strong) UIImageView *mImageView;

/*
 * 教程二：GPUImageVideoCamera与GPUImageView
 */
@property (nonatomic, strong) GPUImageView *mGpuImageView;
@property (nonatomic, strong) GPUImageVideoCamera *mGpuVideoCamera;

/*
 * 教程三：GPUImageFilterGroup，GPUImageTwoInputFilter，GPUImageThreeInputFilter
 */
@property (nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic, strong) GPUImageMovieWriter *movieWriter;
@property (nonatomic, strong) GPUImageView *filterView;

/*
 * 教程四：GPUImageContext，GPUImageFramebufferCache，GPUImagePicture
 */
@property (nonatomic, strong) GPUImagePicture *sourcePicture;
@property (nonatomic, strong) GPUImageTiltShiftFilter *sepiaFilter;

/*
 * 教程五：滤镜视频录制
 * 使用教程三的3个变量
 */
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;

@property (nonatomic, strong) UIButton *mButton;
@property (nonatomic , strong) UILabel  *mLabel;
@property (nonatomic , assign) long     mLabelTime;
@property (nonatomic , strong) NSTimer  *mTimer;

@property (nonatomic , strong) CADisplayLink *mDisplayLink;

/*
 * 教程六：用视频做视频水印
 * 使用教程五的mLabel， filter， 教程三的movieWriter，videoCamera
 */
@property (nonatomic , strong) GPUImageMovie *movieFile;

/*
 * 教程七：给视频添加文字水印，动态图像水印
 * 使用教程五的mLabel， filter， 教程三的movieWriter，教程六的movieFile
 */

/*
 * 教程九：图像的输入输出和滤镜通道
 * 使用教程五的mLabel,教程一的mImageView，教程三的videoCamera,教程六的movieFile
 */
@property (nonatomic, strong) GPUImageRawDataOutput *mOutput;

/*
 * 教程十：用GPUImage和指令配合合并视频，看博客
 */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     * 教程一：GPUImageFilter与GPUImageFramebuffer
     * GPUImageFilter:用来接收源图像，通过自定义的顶点，片元着色器来渲染新的图像，并在绘制完成后通知响应链的下一个对象
     * GPUImageFramebuffer:用来管理纹理缓存的格式与读写帧缓存的buffer
     */
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:imageView];
//    self.mImageView = imageView;
//    [self onCustom];
    
    /*
     * 教程二：GPUImageVideoCamera与GPUImageView
     * GPUImageVideoCamera:是GPUImageOutput的子类，提供来自摄像头的图像数据作为源数据，一般是响应链的源头
     * GPUImageView:是响应链的终点，一般用于显示GPUImage的图像
     */
//    self.mGpuVideoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
//
//    self.mGpuImageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:self.mGpuImageView];
//    self.mGpuImageView.fillMode = kGPUImageFillModePreserveAspectRatioAndFill;//kGPUImageFillModeStretch;
//
//    GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc] init];
//    [self.mGpuVideoCamera addTarget:filter];
//    [filter addTarget:self.mGpuImageView];
//
//    // 不添加滤镜
////    [self.mGpuVideoCamera addTarget:self.mGpuImageView];
//
//    [self.mGpuVideoCamera startCameraCapture];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    /*
     * 教程三：GPUImageFilterGroup，GPUImageTwoInputFilter，GPUImageThreeInputFilter
     */
//    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
//    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
//    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
//
//    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
//    self.filterView.center = self.view.center;
//    [self.view addSubview:self.filterView];
//
//    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
//    unlink([pathToMovie UTF8String]);
//    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
//    self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(640.0, 480.0)];
//
//    self.videoCamera.audioEncodingTarget = self.movieWriter;
//    self.movieWriter.encodingLiveVideo = YES;
//    [self.videoCamera startCameraCapture];
//
//    GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
//    [self.videoCamera addTarget:beautifyFilter];
//    [beautifyFilter addTarget:self.filterView];
//    [beautifyFilter addTarget:self.movieWriter];
//    [self.movieWriter startRecording];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [beautifyFilter removeTarget:self.movieWriter];
//        [self.movieWriter finishRecording];
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie))
//        {
//            [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error)
//             {
//                 dispatch_async(dispatch_get_main_queue(), ^{
//
//                     if (error) {
//                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存失败" message:nil
//                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                         [alert show];
//                     } else {
//                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存成功" message:nil
//                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                         [alert show];
//                     }
//                 });
//             }];
//        }
//        else {
//            NSLog(@"error mssg)");
//        }
//    });
    
    /*
     * 教程四：GPUImageContext，GPUImageFramebufferCache，GPUImagePicture
     */
//    GPUImageView *primaryView = [[GPUImageView alloc] initWithFrame:self.view.frame];
//    self.view = primaryView;
//    UIImage *inputImage = [UIImage imageNamed:@"2.jpeg"];
//    self.sourcePicture = [[GPUImagePicture alloc] initWithImage:inputImage];
//    self.sepiaFilter = [[GPUImageTiltShiftFilter alloc] init];
//    self.sepiaFilter.blurRadiusInPixels = 40.0;
//    [self.sepiaFilter forceProcessingAtSize:primaryView.sizeInPixels];
//    [self.sourcePicture addTarget:self.sepiaFilter];
//    [self.sepiaFilter addTarget:primaryView];
//    [self.sourcePicture processImage];
//
//    // GPUImageContext相关的数据显示
//    GLint size = [GPUImageContext maximumTextureSizeForThisDevice];
//    GLint unit = [GPUImageContext maximumTextureUnitsForThisDevice];
//    GLint vector = [GPUImageContext maximumVaryingVectorsForThisDevice];
//    NSLog(@"%d %d %d", size, unit, vector);
    
    /*
     * 教程五：滤镜视频录制
     * 使用教程三的3个变量
     */
//    _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
//    _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
//
//    _filter = [[GPUImageSepiaFilter alloc] init];
//    _filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
//    self.view = _filterView;
//
//    _mButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 80, 50, 50)];
//    [_mButton setTitle:@"录制" forState:UIControlStateNormal];
//    [_mButton sizeToFit];
//    [self.view addSubview:_mButton];
//    [_mButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
//
//    _mLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 90, 50, 100)];
//    _mLabel.hidden = YES;
//    _mLabel.textColor = [UIColor whiteColor];
//    [self.view addSubview:_mLabel];
//
//    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(10, 120, 100, 40)];
//    [slider addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:slider];
//
//    [_videoCamera addTarget:_filter];
//    [_filter addTarget:_filterView];
//    [_videoCamera startCameraCapture];
//
//    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarOrientationNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
//        _videoCamera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
//    }];
//
//    self.mDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displaylink:)];
//    [self.mDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    /*
     * 教程六：用视频做视频水印
     * 使用教程五的mLabel， filter， 教程三的movieWriter，videoCamera
     */
//    GPUImageView *filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
//    self.view = filterView;
//
//    self.mLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 100)];
//    self.mLabel.textColor = [UIColor redColor];
//    [self.view addSubview:self.mLabel];
//
//    self.filter = [[GPUImageDissolveBlendFilter alloc] init];
//    [(GPUImageDissolveBlendFilter *)self.filter setMix:0.5];
//
//    // 播放
//    // https://www.jianshu.com/p/93ee14d78456  sampleurl为nil的解决方法
//    NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:@"abc" withExtension:@"mp4"];
//    self.movieFile = [[GPUImageMovie alloc] initWithURL:sampleURL];
//    self.movieFile.runBenchmark = YES;
//    self.movieFile.playAtActualSpeed = YES;
//
//    // 摄像头
//    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
//    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
//
//    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
//    unlink([pathToMovie UTF8String]);
//    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
//
//    self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(640.0, 480.0)];
//    Boolean audioFromFile = NO;
//    [self.movieWriter setAudioProcessingCallback:^(SInt16 **samplesRef, CMItemCount numSamplesInBuffer) {
//
//    }];
//    if(audioFromFile)
//    {
//        // 响应链
//        [self.movieFile addTarget:self.filter];
//        [self.videoCamera addTarget:self.filter];
//        self.movieWriter.shouldPassthroughAudio = YES;
//        self.movieFile.audioEncodingTarget = self.movieWriter;
//        [self.movieFile enableSynchronizedEncodingUsingMovieWriter:self.movieWriter];
//    }
//    else
//    {
//        // 响应链
//        [self.videoCamera addTarget:self.filter];
//        [self.movieFile addTarget:self.filter];
//        self.movieWriter.shouldPassthroughAudio = NO;
//        self.videoCamera.audioEncodingTarget = self.movieWriter;
//        self.movieWriter.encodingLiveVideo = NO;
//    }
//
//    // 显示到界面
//    [self.filter addTarget:filterView];
//    [self.filter addTarget:self.movieWriter];
//
//    [self.videoCamera startCameraCapture];
//    [self.movieWriter startRecording];
//    [self.movieFile startProcessing];
//
//    CADisplayLink* dlink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
//    [dlink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    [dlink setPaused:NO];
//
//    __weak typeof(self) weakSelf = self;
//    [self.movieWriter setCompletionBlock:^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf->_filter removeTarget:strongSelf->_movieWriter];
//        [strongSelf->_movieWriter finishRecording];
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie))
//        {
//            [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error)
//             {
//                 dispatch_async(dispatch_get_main_queue(), ^{
//
//                     if (error) {
//                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存失败" message:nil
//                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                         [alert show];
//                     } else {
//                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存成功" message:nil
//                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                         [alert show];
//                     }
//                 });
//             }];
//        }
//        else {
//            NSLog(@"error mssg)");
//        }
//    }];
    
    /*
     * 教程七：给视频添加文字水印，动态图像水印
     * 使用教程五的mLabel， filter， 教程三的movieWriter，教程六的movieFile
     */
//    GPUImageView *filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
//    self.view = filterView;
//
//    self.mLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 100)];
//    self.mLabel.textColor = [UIColor redColor];
//    [self.view addSubview:self.mLabel];
//
//    // 滤镜
//    self.filter = [[GPUImageDissolveBlendFilter alloc] init];
//    [(GPUImageDissolveBlendFilter *)self.filter setMix:0.5];
//
//    // 播放
//    NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:@"abc" withExtension:@"mp4"];
//    AVAsset *asset = [AVAsset assetWithURL:sampleURL];
//    CGSize size = self.view.bounds.size;
//    self.movieFile = [[GPUImageMovie alloc] initWithAsset:asset];
//    self.movieFile.runBenchmark = YES;
//    self.movieFile.playAtActualSpeed = YES;
//
//    // 水印
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    label.text = @"我是水印";
//    label.font = [UIFont systemFontOfSize:30];
//    label.textColor = [UIColor redColor];
//    [label sizeToFit];
//    UIImage *image = [UIImage imageNamed:@"watermark.png"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    subView.backgroundColor = [UIColor clearColor];
//    imageView.center = CGPointMake(subView.bounds.size.width / 2, subView.bounds.size.height / 2);
//    [subView addSubview:imageView];
//    [subView addSubview:label];
//
//    GPUImageUIElement *uielement = [[GPUImageUIElement alloc] initWithView:subView];
//
//    //    GPUImageTransformFilter 动画的filter
//    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie.m4v"];
//    unlink([pathToMovie UTF8String]);
//    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
//
//    self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(640.0, 480.0)];
//
//    GPUImageFilter* progressFilter = [[GPUImageFilter alloc] init];
//    [self.movieFile addTarget:progressFilter];
//    [progressFilter addTarget:self.filter];
//    [uielement addTarget:self.filter];
//    self.movieWriter.shouldPassthroughAudio = YES;
//    self.movieFile.audioEncodingTarget = self.movieWriter;
//    [self.movieFile enableSynchronizedEncodingUsingMovieWriter:self.movieWriter];
//    // 显示到界面
//    [self.filter addTarget:filterView];
//    [self.filter addTarget:self.movieWriter];
//
//
//    [self.movieWriter startRecording];
//    [self.movieFile startProcessing];
//
//
//    CADisplayLink* dlink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress)];
//    [dlink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//    [dlink setPaused:NO];
//
//    __weak typeof(self) weakSelf = self;
//
//    [progressFilter setFrameProcessingCompletionBlock:^(GPUImageOutput *output, CMTime time) {
//        CGRect frame = imageView.frame;
//        frame.origin.x += 1;
//        frame.origin.y += 1;
//        imageView.frame = frame;
//        [uielement updateWithTimestamp:time];
//    }];
//
//    [self.movieWriter setCompletionBlock:^{
//        __strong typeof(self) strongSelf = weakSelf;
//        [strongSelf->_filter removeTarget:strongSelf->_movieWriter];
//        [strongSelf->_movieWriter finishRecording];
//        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie))
//        {
//            [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error)
//             {
//                 dispatch_async(dispatch_get_main_queue(), ^{
//
//                     if (error) {
//                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存失败" message:nil
//                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                         [alert show];
//                     } else {
//                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存成功" message:nil
//                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//                         [alert show];
//                     }
//                 });
//             }];
//        }
//        else {
//            NSLog(@"error mssg)");
//        }
//    }];
    
    /*
     * 教程九：图像的输入输出和滤镜通道
     * 使用教程五的mLabel,教程一的mImageView，教程三的videoCamera,教程六的movieFile
     */
    GPUImageView *filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.view = filterView;
    
    self.mImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mImageView];
    
    self.mLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 100)];
    self.mLabel.textColor = [UIColor redColor];
    [self.view addSubview:self.mLabel];
    
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = YES;
    
    self.mOutput = [[GPUImageRawDataOutput alloc] initWithImageSize:CGSizeMake(640, 480) resultsInBGRAFormat:YES];
    [self.videoCamera addTarget:self.mOutput];
    
    __weak typeof(self) wself = self;
    __weak typeof(self.mOutput) weakOutput = self.mOutput;
    [self.mOutput setNewFrameAvailableBlock:^{
        __strong GPUImageRawDataOutput *strongOutput = weakOutput;
        __strong typeof(wself) strongSelf = wself;
        [strongOutput lockFramebufferForReading];
        GLubyte *outputBytes = [strongOutput rawBytesForImage];
        NSInteger bytesPerRow = [strongOutput bytesPerRowInOutput];
        CVPixelBufferRef pixelBuffer = NULL;
        CVReturn ret = CVPixelBufferCreateWithBytes(kCFAllocatorDefault, 640, 480, kCVPixelFormatType_32BGRA, outputBytes, bytesPerRow, nil, nil, nil, &pixelBuffer);
        if (ret != kCVReturnSuccess) {
            NSLog(@"status %d", ret);
        }
        
        [strongOutput unlockFramebufferAfterReading];
        if(pixelBuffer == NULL) {
            return ;
        }
        CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
        CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, strongOutput.rawBytesForImage, bytesPerRow * 480, NULL);
        
        CGImageRef cgImage = CGImageCreate(640, 480, 8, 32, bytesPerRow, rgbColorSpace, kCGImageAlphaPremultipliedFirst|kCGBitmapByteOrder32Little, provider, NULL, true, kCGRenderingIntentDefault);
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        [strongSelf updateWithImage:image];
        
        CGImageRelease(cgImage);
        CFRelease(pixelBuffer);
    }];
    
    [self.videoCamera startCameraCapture];
    
    CADisplayLink* dlink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateProgress9)];
    [dlink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    [dlink setPaused:NO];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
 * 教程一：GPUImageFilter与GPUImageFramebuffer
 */
- (void)onCustom
{
    // 深褐色的滤镜
    GPUImageFilter *filter = [[GPUImageSepiaFilter alloc] init];
    UIImage *image = [UIImage imageNamed:@"2.jpeg"];
    if(image)
    {
        self.mImageView.image = [filter imageByFilteringImage:image];
    }
}

/*
 * 教程二：GPUImageVideoCamera与GPUImageView
 */
- (void)deviceOrientationDidChange:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    self.mGpuVideoCamera.outputImageOrientation = orientation;
}

/*
 * 教程四：GPUImageContext，GPUImageFramebufferCache，GPUImagePicture
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    float rate = point.y / self.view.frame.size.height;
    NSLog(@"Processing");
    [_sepiaFilter setTopFocusLevel:rate - 0.1];
    [_sepiaFilter setBottomFocusLevel:rate + 0.1];
    [_sourcePicture processImage];
}

/*
 * 教程五：滤镜视频录制
 * 使用教程三的3个变量
 */
- (void)displaylink:(CADisplayLink *)displaylink {
    NSLog(@"test");
}

- (void)onTimer:(id)sender
{
    _mLabel.text  = [NSString stringWithFormat:@"录制时间:%lds", _mLabelTime++];
    [_mLabel sizeToFit];
}

- (void)onClick:(UIButton *)sender
{
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie4.m4v"];
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    if([sender.currentTitle isEqualToString:@"录制"]) {
        [sender setTitle:@"结束" forState:UIControlStateNormal];
        NSLog(@"Start recording");
        unlink([pathToMovie UTF8String]); // 如果已经存在文件，AVAssetWriter会有异常，删除旧文件
        _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
        _movieWriter.encodingLiveVideo = YES;
        [_filter addTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = _movieWriter;
        [_movieWriter startRecording];
        
        _mLabelTime = 0;
        _mLabel.hidden = NO;
        [self onTimer:nil];
        _mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    }
    else {
        [sender setTitle:@"录制" forState:UIControlStateNormal];
        NSLog(@"End recording");
        _mLabel.hidden = YES;
        if (_mTimer) {
            [_mTimer invalidate];
        }
        [_filter removeTarget:_movieWriter];
        _videoCamera.audioEncodingTarget = nil;
        [_movieWriter finishRecording];
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathToMovie))
        {
            [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error)
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     if (error) {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存失败" message:nil
                                                                        delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alert show];
                     } else {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存成功" message:nil
                                                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alert show];
                     }
                 });
             }];
        }
        
    }
}

- (void)updateSliderValue:(id)sender
{
    [(GPUImageSepiaFilter *)_filter setIntensity:[(UISlider *)sender value]];
}

/*
 * 教程六：用视频做视频水印
 * 使用教程五的mLabel， filter， 教程三的movieWriter，videoCamera
 */
- (void)updateProgress
{
    self.mLabel.text = [NSString stringWithFormat:@"Progress:%d%%", (int)(self.movieFile.progress * 100)];
    [self.mLabel sizeToFit];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
 * 教程九：图像的输入输出和滤镜通道
 * 使用教程五的mLabel,教程一的mImageView，教程三的videoCamera,教程六的movieFile
 */

+ (void)convertBGRAtoRGBA:(unsigned char *)data withSize:(size_t)sizeOfData {
    for (unsigned char *p = data; p < data + sizeOfData; p += 4) {
        unsigned char r = *(p + 2);
        unsigned char b = *p;
        *p = r;
        *(p + 2) = b;
    }
}


- (void)updateWithImage:(UIImage *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.mImageView.image = image;
    });
}

- (void)updateProgress9
{
    self.mLabel.text = [[NSDate dateWithTimeIntervalSinceNow:0] description];
    [self.mLabel sizeToFit];
}

@end
