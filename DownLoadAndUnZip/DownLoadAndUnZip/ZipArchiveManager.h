//
//  ZipArchiveManager.h
//  DownLoadAndUnZip
//
//  Created by wangfubin on 2017/12/15.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZipArchiveManager : NSObject

+ (instancetype)sharedObject;

/*
 * 解压文件
 */
- (void)uZipArchiveWithFile:(NSString *)file completion:(void(^)(void))completion;

/*
 * 压缩文件
 */
- (void)zipArchiveWithFile:(NSMutableArray *)files completion:(void(^)(void))completion;

/*
 * 下载加解压
 */
- (void)load:(NSString *)url hasProgress:(void (^)(float progress))hasProgress completion:(void (^)(BOOL isCompletion))completion;

@end
