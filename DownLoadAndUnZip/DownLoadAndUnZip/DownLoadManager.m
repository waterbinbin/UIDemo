//
//  DownLoadManager.m
//  DownLoadAndUnZip
//
//  Created by wangfubin on 2017/12/8.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

#import "DownLoadManager.h"

#import "AFHTTPSessionManager.h"

@interface DownLoadManager ()

/** 下载任务 */
@property (nonatomic,strong)NSURLSessionDownloadTask *downloadTask;
/** 下载的数据信息 */
@property (nonatomic,strong)NSData *resumeData;
/** 下载的会话 */
@property (nonatomic,strong)NSURLSession *urlSession;

// AFHTTPSessionManager
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation DownLoadManager

#pragma mark -- Public
+ (instancetype)sharedObject
{
    static dispatch_once_t onceToken;
    static DownLoadManager *shareObject;
    dispatch_once(&onceToken, ^{
        shareObject = [[[self class] alloc] init];
    });
    
    return shareObject;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        
        AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
        self.sessionManager.responseSerializer = serializer;
    }
    return self;
}

- (void)downloadLittleFileWithURL:(NSURL *)url completion:(void (^)(BOOL isComplete, NSString *filePath))completion
{
    // 0. 判断文件是否存在
    __block NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])
    {
        if(completion)
        {
            completion(YES, fullPath);
        }
        return;
    }
    
    // 1. 创建会话对象
    self.urlSession = [NSURLSession sharedSession];
    
    // 2. 创建task， 接受到数据之后内部直接写进沙盒
    self.downloadTask = [self.urlSession downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error)
        {
            // 4. 接受数据
            // 4.1 确定文件的全路径
//            NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
            NSLog(@"DownLoadManager fullPath %@", fullPath);
            
            // 4.2 剪切文件
            /*
             *@parameter1 要剪切的文件
             *@parameter2 目标地址
             *@parameter3 错误信息
             */
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
            
            // 4.3 回到主线程操作
            dispatch_async(dispatch_get_main_queue(), ^{
                if(completion)
                {
                    completion(YES, fullPath);
                }
            });
            
        }
        else
        {
            NSLog(@"DownLoadManager error %@", error);
            if(completion)
            {
                completion(NO, nil);
            }
        }
    }];
    
    // 3. 启动task
    [self.downloadTask resume];
}

- (NSString *)downloadBigFileWithURL:(NSURL *)url object:(id<NSURLSessionDownloadDelegate>)object
{
    // 0. 判断文件是否存在
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:fullPath])
    {
        return fullPath;
    }
    
    // 1. 创建会话
    self.urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:object delegateQueue:[NSOperationQueue mainQueue]];
    
    // 2. 通过会话在确定的URL上创建下载任务
    self.downloadTask = [self.urlSession downloadTaskWithURL:url];
    
    // 3. 启动task
    [self.downloadTask resume];
    
    return nil;
}

- (void)cancelDownload
{
    //    [self.downloadTask suspend];suspend暂停下载|可恢复的
    //cancelByProducingResumeData取消下载，同时可以获取已经下载的数据相关信息
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
    }];
}

- (void)resumeDownload
{
    NSURLSessionDownloadTask* downloadTask = [self.urlSession downloadTaskWithResumeData:self.resumeData];
    [downloadTask resume];
    self.downloadTask = downloadTask;
}

- (void)downloadWithRequest:(NSString *)url
              localFilePath:(NSString *)localFilePath
                   progress:(void (^)(float progress))progress
                    success:(void (^)(NSURLSessionDownloadTask *task, NSURL *filePath))success
                    failure:(void (^)(NSURLSessionDownloadTask *task, NSError *error))failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    __weak NSURLSessionDownloadTask *task = nil;
    task = [self.sessionManager downloadTaskWithRequest:request
                                               progress:^(NSProgress * _Nonnull downloadProgress) {
                                                   if(progress != nil && downloadProgress != nil)
                                                   {
                                                       progress((float)downloadProgress.completedUnitCount/ (float)downloadProgress.totalUnitCount);
                                                   }
                                               }
                                            destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                return [NSURL fileURLWithPath:localFilePath];
                                            }
                                      completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                          if (error == nil){
                                              if (success){
                                                  success(task, filePath);
                                              }
                                          }
                                          else{
                                              if (failure){
                                                  failure(task, error);
                                              }
                                          }
                                          
                                      }];
    [task resume];
}

#pragma mark - 懒加载
-(NSData *)resumeData{
    if (!_resumeData) {
        _resumeData = [NSData data];
    }
    return _resumeData;
}

@end
