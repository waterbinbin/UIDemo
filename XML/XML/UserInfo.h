//
//  UserInfo.h
//  XML
//
//  Created by wangfubin on 2017/5/12.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(retain, nonatomic) NSString *mUserName;
@property(retain, nonatomic) NSString *mUserID;
@property(retain, nonatomic) NSString *mUserCredit;
@property(assign, nonatomic) NSInteger mUserExp;
@property(retain, nonatomic) NSString *mUserNickName;
@property(retain, nonatomic) NSString *mHeaderPath;
@property(assign, nonatomic) NSInteger mGroupID;
@property(assign, nonatomic) NSInteger mFriendNum;

@end
