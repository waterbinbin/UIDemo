//
//  Contacts.h
//  UISearchBar&AddressBookUI
//
//  Created by 王福滨 on 2017/4/24.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contacts : NSObject

// 姓名
@property(nonatomic, copy) NSString *name;
// 姓名索引
@property(nonatomic, strong) NSString *nameIndex;

// 带参数的构造函数，实例方法
- (Contacts *)initWithName:(NSString *)name;
// 带参数的静态对象初始化方法，类方法
+ (Contacts *)initWithName:(NSString *)name;
// 根据数组初始化
+ (instancetype)contactsWithArr:(NSArray *)arr;
- (instancetype)initWithArr:(NSArray *)arr;

@end
