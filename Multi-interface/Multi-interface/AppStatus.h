//
//  AppStatus.h
//  Multi-interface
//
//  Created by wangfubin on 2017/7/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStatus : NSObject
{
    NSString *_contextStr;
}

@property(nonatomic, strong)NSString *contextStr;

+(AppStatus *)shareInstance;

@end
