//
//  ViewController.m
//  Sqlite
//
//  Created by wangfubin on 2017/5/13.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

// 创建数据库
// 1. 终端：sqlite3 myDB01  // 创建数据库名
// 2. .database            // 列出数据库所有数据
// 3. .tables              // 列出所有数据表
// 4. create table person(id integer primary key, name varcher(20), age samllint); // 创建表
// 5. create table stu(id integer primary key autoincrement, name varchar(20), age smallint);
// 6. create table class(id integer primary key autoincrement, name varchar(20), stuNum smallint);
// 7. insert into stu values(1,'Michael',19);
//    insert into stu values(2,'Tom',20);
//    insert into stu values(5,'Jack',22);
//    insert into stu values(6,'Jonh',25);
// 8. select * from stu;
//    select name,age from stu;
//    select * from stu where age < 22;
// 9. update stu set name = 'Will' where id = 1;
// 10. delete from stu where id = 6;

// FMDB 第三方库下载：https://github.com/ccgus/fmdb
// Build Phases:添加：libsqlite3.tbd

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()
{
    FMDatabase *_mDB;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arrTitle = [NSArray arrayWithObjects:@"创建数据库", @"插入数据", @"删除数据", @"查找显示",nil];
    for(int i = 0; i < 4; ++i)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(100, 100 + 80 * i, 100, 40);
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [btn setTitle:arrTitle[i] forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
    }
}

- (void)pressBtn:(UIButton *)btn
{
    if(btn.tag == 100)
    {
        // 获取数据库的创建路径
        // NSHomeDirectory():获取手机APP的沙盒路径，自己的app访问自己的沙盒，其他应用不可以访问
        NSString *strPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/db01.db"];
        // 创建并且打开数据库
        // 如果路径下边没有数据库，就创建数据库
        // 如果路径下边已经存在数据库，就加载数据库到内存
        _mDB = [FMDatabase databaseWithPath:strPath];
        if(_mDB != nil)
        {
            NSLog(@"数据库创建成功");
        }
        
        BOOL isOpen = [_mDB open];
        if(isOpen)
        {
            NSLog(@"数据库打开成功");
        }
        
        NSString *strCreateTable = @"create table if not exists stu(id integer primary key, age ingeger, name varchar(20))";
        // 执行SQL，如果执行成功则返回一个YES
        BOOL isCreate = [_mDB executeUpdate:strCreateTable];
        if(isCreate)
        {
            NSLog(@"数据库创建数据表成功");
        }
        
//        BOOL isClose = [_mDB close];
//        if(isClose)
//        {
//            NSLog(@"数据库关闭成功");
//        }
    }
    else if(btn.tag == 101)
    {
        if(_mDB != nil)
        {
            if([_mDB open])
            {
                NSString *strInsert = @"insert into stu values(2,20,'Tom')";
                BOOL isInsert = [_mDB executeUpdate:strInsert];
                if(isInsert)
                {
                    NSLog(@"数据库插入数据成功");
                }

            }
        }
    }
    if(btn.tag == 102)
    {
        NSString *strDelete = @"delete from stu where id = 2;";
        BOOL isOpen = [_mDB open];
        if(isOpen)
        {
            [_mDB executeUpdate:strDelete];
        }

    }
    if(btn.tag == 103)
    {
        NSString *strQuery = @"select * from stu;";
        BOOL isOpen = [_mDB open];
        if(isOpen)
        {
            // 执行查找sql语句
            // 将查找结果用FMResultSet返回
            FMResultSet *result = [_mDB executeQuery:strQuery];
            
            // 遍历所有结果
            while ([result next])
            {
                // 方法1:根据字段名获取
                // 获取id字段内容
//                NSInteger stuID = [result intForColumn:@"id"];
//                // 获取名字
//                NSString *strName = [result stringForColumn:@"name"];
//                // 年龄
//                NSInteger stuAge = [result intForColumn:@"age"];
                
                // 方法2:通过索引
                NSInteger stuID = [result intForColumnIndex:0];
                // 获取名字
                NSString *strName = [result stringForColumnIndex:1];
                // 年龄
                NSInteger stuAge = [result intForColumnIndex:2];
                NSLog(@"stu id = %ld, name = %@, age = %ld", stuID, strName, stuAge);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
