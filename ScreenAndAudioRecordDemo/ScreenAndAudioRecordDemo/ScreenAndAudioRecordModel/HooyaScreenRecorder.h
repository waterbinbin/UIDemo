//
//  ASScreenRecorder.h
//  ScreenRecorder
//
//  Created by Alan Skipp on 23/04/2014.
//  Copyright (c) 2014 Alan Skipp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGContext.h>

typedef void (^VideoCompletionBlock)(void);

// If your view contains an AVCaptureVideoPreviewLayer or an openGL view
// you'll need to write that data into the CGContextRef yourself.
// In the viewcontroller responsible for the AVCaptureVideoPreviewLayer / openGL view
// set yourself as the delegate for ASScreenRecorder.
// [ASScreenRecorder sharedInstance].delegate = self
// Then implement 'writeBackgroundFrameInContext:(CGContextRef*)contextRef'
// use 'CGContextDrawImage' to draw your view into the provided CGContextRef
@protocol HooyaScreenRecorderDelegate <NSObject>
@optional
- (void)writeBackgroundFrameInContext:(CGContextRef*)contextRef;
- (void)recordingFinished:(NSString*)outputPath;
@end


@interface HooyaScreenRecorder : NSObject

@property (nonatomic, readonly) BOOL isRecording;

// delegate is only required when implementing ASScreenRecorderDelegate - see below
@property (nonatomic, weak) id <HooyaScreenRecorderDelegate> delegate;

// if saveURL is nil, video will be saved into camera roll
// this property can not be changed whilst recording is in progress
@property (strong, nonatomic) NSURL *videoURL;

+ (instancetype)sharedInstance;
- (BOOL)startRecording;
- (void)stopRecordingWithCompletion:(VideoCompletionBlock)completionBlock;

@end
