//
//  BlockDemo.m
//  BlockDemo
//
//  Created by 王福滨 on 2017/10/19.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

#import "BlockDemo.h"

@interface BlockDemo ()

@property (nonatomic, strong, readwrite) NSString *url;
@property (nonatomic, copy) BlockDemoCompletionHandler completionHandler;
@property (nonatomic, strong) NSString *loadString;

@end

@implementation BlockDemo

- (id)initWithURL:(NSString *)url
{
    if(self = [super init])
    {
        _url = url;
    }
    return self;
}

- (void)startWithCompletionHandler:(BlockDemoCompletionHandler)completion
{
    self.completionHandler = completion;
    NSLog(@"startWithCompletionHandler");
    
    _loadString = @"loadString";
    [self p_requestCompleted];
}

- (void)p_requestCompleted
{
    if(_completionHandler)
    {
        _completionHandler(_loadString);
    }
    self.completionHandler = nil;
}

@end
