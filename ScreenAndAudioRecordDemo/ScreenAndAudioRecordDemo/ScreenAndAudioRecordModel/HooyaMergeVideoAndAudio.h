//
//  THCaptureUtilities.h
//  ScreenCaptureViewTest
//
//  Created by wayne li on 11-9-8.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HooyaMergeVideoAndAudio : NSObject

// 音频与视频的合并. action的形式如下:
// - (void)mergedidFinish:(NSString *)videoPath WithError:(NSError *)error;
+ (void)mergeVideo:(NSString *)videoPath andAudio:(NSString *)audioPath andTarget:(id)target andAction:(SEL)action;

@end
