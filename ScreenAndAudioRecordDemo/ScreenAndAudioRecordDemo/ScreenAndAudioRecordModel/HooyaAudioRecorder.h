//
//  BlazeiceAudioRecordAndTransCoding.h
//  BlazeiceRecordAloudTeacher
//
//  Created by 白冰 on 13-8-27.
//  Copyright (c) 2013年 闫素芳. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol HooyaAudioRecorderDelegate<NSObject>

-(void)wavComplete;

@end

@interface HooyaAudioRecorder : NSObject
@property(strong, nonatomic) AVAudioRecorder *recorder;
@property(copy, nonatomic) NSString *recordFileName;//录音文件名
@property(copy, nonatomic) NSString *recordFilePath;//录音文件路径
@property(assign,nonatomic) BOOL nowPause;
@property(nonatomic, weak) id<HooyaAudioRecorderDelegate>delegate;

- (void)beginRecordByFileName:(NSString*)_fileName;
- (void)endRecord;

@end
