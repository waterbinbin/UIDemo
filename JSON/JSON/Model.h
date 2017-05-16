//
//  Model.h
//  JSON
//
//  Created by 王福滨 on 2017/5/8.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject
{
    NSString *_airLineID;
    NSString *_name;
    NSString *_alias;
}

// 属性对象
@property(retain, nonatomic) NSString *mAirLineID;
@property(retain, nonatomic) NSString *mName;
@property(retain, nonatomic) NSString *mAlias;

@end
