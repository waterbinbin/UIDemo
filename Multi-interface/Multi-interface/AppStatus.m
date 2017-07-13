//
//  AppStatus.m
//  Multi-interface
//
//  Created by wangfubin on 2017/7/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "AppStatus.h"

@implementation AppStatus

static AppStatus *_instance = nil;

+ (AppStatus *)shareInstance
{
    if(_instance == nil)
    {
        _instance = [[super alloc] init];
    }
    return _instance;
}

- (id)init
{
    if(self = [super init])
    {
        
    }
    return self;
}

@end
