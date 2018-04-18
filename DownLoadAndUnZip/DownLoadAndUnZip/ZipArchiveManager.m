//
//  ZipArchiveManager.m
//  DownLoadAndUnZip
//
//  Created by wangfubin on 2017/12/15.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

#import "ZipArchiveManager.h"

#import "ZipArchive.h"
#import "DownLoadManager.h"

@implementation ZipArchiveManager

#pragma mark -- Public
+ (instancetype)sharedObject
{
    static dispatch_once_t onceToken;
    static ZipArchiveManager *shareObject;
    dispatch_once(&onceToken, ^{
        shareObject = [[[self class] alloc] init];
    });
    
    return shareObject;
}

- (void)uZipArchiveWithFile:(NSString *)file completion:(void(^)(void))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 创建解压缩对象
        ZipArchive *zip = [[ZipArchive alloc] init];
        // Caches路径
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        // 获得file的没有后缀的文件名
        //    NSString *fileName = [[file lastPathComponent] stringByDeletingPathExtension];
        // 解压目标路径
        //    NSString *savePath =[cachesPath stringByAppendingPathComponent:fileName];
        NSString *savePath = cachesPath;
        // zip压缩包的路径
        //    NSString *path = [cachesPath stringByAppendingPathComponent:@"ZipArchive.zip"];
        // 解压不带密码压缩包
        if([zip UnzipOpenFile:file])
        {
            // 解压带密码压缩包
            //[zip UnzipOpenFile:path Password:@"ZipArchive.zip"];
            // 解压
            BOOL ret = [zip UnzipFileTo:savePath overWrite:YES];
            if(NO == ret)
            {
                [zip UnzipCloseFile];
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(completion)
                    {
                        completion();
                    }
                });
            }
            
            
        }
        //关闭解压
        [zip UnzipCloseFile];
    });
    
}

- (void)zipArchiveWithFile:(NSMutableArray *)files completion:(void(^)(void))completion
{
//    //创建解压缩对象
//    ZipArchive *zip = [[ZipArchive alloc]init];
//    //Caches路径
//    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//    //zip压缩包保存路径
//    NSString *path = [cachesPath stringByAppendingPathComponent:@"ZipArchive.zip"];//创建不带密码zip压缩包
//    　　//创建zip压缩包
//    [zip CreateZipFile2:path];
//    //创建带密码zip压缩包
//    //[zip CreateZipFile2:path Password:@"ZipArchive.zip"];
//    　　 //添加到zip压缩包的文件
//    [zip addFileToZip:@"/Users/apple/Desktop/demo/LaunchImage-2-700-568h@2x.png" newname:@"1.png"];
//    [zip addFileToZip:@"/Users/apple/Desktop/demo/LaunchImage-2-700@2x.png" newname:@"2.png"];
//    [zip addFileToZip:@"/Users/apple/Desktop/demo/LaunchImage-2-800-667h@2x.png" newname:@"3.png"];
//    [zip addFileToZip:@"/Users/apple/Desktop/demo/LaunchImage-2-800-Landscape-736h@3x.png" newname:@"4.png"];
//    //关闭压缩
//    BOOL success = [zip CloseZipFile2];
}

- (void)load:(NSString *)url hasProgress:(void (^)(float progress))hasProgress completion:(void (^)(BOOL isCompletion))completion
{
    //1 下载
    NSString *zipFilePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[url lastPathComponent]];
    
    __block void(^unzip)(BOOL loadSuccess) = nil;
    
    [[DownLoadManager sharedObject] downloadWithRequest:url
                                          localFilePath:zipFilePath
                                               progress:^(float progress) {
                                                   if(hasProgress)
                                                   {
                                                       hasProgress(progress);
                                                   }
                                               } success:^(NSURLSessionDownloadTask *task, NSURL *filePath) {
                                                   unzip(YES);
                                               } failure:^(NSURLSessionDownloadTask *task, NSError *error) {
                                                   unzip(YES);
                                               }];
    
    
    //2 解压
    unzip = ^(BOOL loadSuccess) {
        
        if (loadSuccess) {
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                
                BOOL handleResult = YES;
                NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
                
                ZipArchive *zipArchive = [[ZipArchive alloc] init];
                [zipArchive UnzipOpenFile:zipFilePath];
                NSLog(@"uzip begin");
                if([zipArchive UnzipFileTo:cachesPath overWrite:YES])
                {
                    handleResult = YES;
                }
                else
                {
                    handleResult = NO;
                }
                [zipArchive UnzipCloseFile];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (completion) {
                        completion(handleResult);
                    }
                    
                });
                
            });
            
        } else {
            
            if (completion) {
                completion(NO);
            }
        }
    };
}

@end
