//
//  DownLoadManager.h
//  DownLoadAndUnZip
//
//  Created by wangfubin on 2017/12/8.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

// 参考：http://www.cnblogs.com/goodboy-heyang/p/5195806.html

// app的后台模式开启downloads

#import <Foundation/Foundation.h>

@interface DownLoadManager : NSObject

+ (instancetype)sharedObject;

/*
 * 小文件，图片下载
 */
- (void)downloadLittleFileWithURL:(NSURL *)url completion:(void (^)(BOOL isComplete, NSString *filePath))completion;

/*
 * 大文件，zip下载
 * 需要实现NSURLSessionDataDelegate相关方法
 */
- (NSString *)downloadBigFileWithURL:(NSURL *)url object:(id<NSURLSessionDownloadDelegate>)object;

/*
 * 取消下载
 */
- (void)cancelDownload;

/*
 * 继续下载
 */
- (void)resumeDownload;

/*
 * 采用AFNetWorking下载大文件
 */
- (void)downloadWithRequest:(NSString *)url
              localFilePath:(NSString *)localFilePath
                   progress:(void (^)(float progress))progress
                    success:(void (^)(NSURLSessionDownloadTask *task, NSURL *filePath))success
                    failure:(void (^)(NSURLSessionDownloadTask *task, NSError *error))failure;

@end
