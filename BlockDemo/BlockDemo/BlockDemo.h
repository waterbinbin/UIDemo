//
//  BlockDemo.h
//  BlockDemo
//
//  Created by 王福滨 on 2017/10/19.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BlockDemoCompletionHandler)(NSString *sMsg);

@interface BlockDemo : NSObject

@property (nonatomic, strong, readonly) NSString *url;

- (id)initWithURL:(NSString *)url;
- (void)startWithCompletionHandler:(BlockDemoCompletionHandler)completion;

@end
