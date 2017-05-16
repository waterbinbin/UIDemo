//
//  Contacts.m
//  UISearchBar&AddressBookUI
//
//  Created by 王福滨 on 2017/4/24.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "Contacts.h"

@implementation Contacts

// 带参数的构造函数，实例方法
- (Contacts *)initWithName:(NSString *)name
{
    if(self = [super init])
    {
        self.name = name;
        self.nameIndex = [self pinyinFirstLetter:name];
    }
    
    return self;
}

// 带参数的静态对象初始化方法，类方法
+ (Contacts *)initWithName:(NSString *)name
{
    Contacts *contacts = [[Contacts alloc] initWithName:name];
    return contacts;
}

// 根据数组初始化
- (instancetype)initWithArr:(NSArray *)arr
{
    if(self = [super init])
    {
        self.name = [arr objectAtIndex:0];
        self.nameIndex = [self pinyinFirstLetter:[arr objectAtIndex:0]];
    }
    return self;
}

+ (instancetype)contactsWithArr:(NSArray *)arr
{
    return [[self alloc] initWithArr:arr];
}

// 获取字符串首字母
- (NSString *)pinyinFirstLetter:(NSString *)chineseCharacter
{
    NSString *result = @"";
    if(!chineseCharacter)
    {
        chineseCharacter = @"无名字";
    }
    NSMutableString *ms = [[NSMutableString alloc] initWithString:chineseCharacter];
    
    if(CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformToLatin, NO)) // 普通话
    {
        //NSLog(@"pinyin1:%@",ms);
    }
    if(CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) // 剥离符号
    {
        //NSLog(@"pinyin2:%@",ms);
    }
    if(ms.length > 0)
    {
        result = [ms substringToIndex:1];
    }
    
    return [result uppercaseString];
}

@end
