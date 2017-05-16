//
//  BookModel.h
//  AFNetWork
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject

@property(retain, nonatomic) NSString *mBookName;
@property(retain, nonatomic) NSString *mBookPrice;
@property(retain, nonatomic) NSString *mBookPublisher;
@property(retain, nonatomic) NSMutableArray *mAuthor;
@property(retain, nonatomic) NSString *mScore;

@end
