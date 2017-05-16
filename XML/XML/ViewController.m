//
//  ViewController.m
//  XML
//
//  Created by wangfubin on 2017/5/9.
//  Copyright © 2017年 YY.Inc. All rights reserved.
//

// GDataXMLNode 下载链接：https://github.com/google/gdata-objectivec-client
// 配置方法：Build setting
//         header search paths:添加/usr/include/libxml2
//         User header search paths:添加/usr/lib/lxml2
//         Other Linker Flags:添加-lxml2
//         Objective-C Automatic Reference Counting:NO

//         Bulid Phases
//         添加库：libxml.tbd
#import "ViewController.h"
#import "GDataXMLNode.h"
#import "UserInfo.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_arrayData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _arrayData = [[NSMutableArray alloc] init];
    [self parseXML];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
- (void)parseXML
{
    // 获取全路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"xmlfile" ofType:@"txt"];
    // 将XML文件读入到内存，并以二进制存
    NSData *dataXML = [NSData dataWithContentsOfFile:path];
    // 创建XML文档对象
    // P1:XML格式的二进制对象
    // P2:选择性参数：默认0
    // P3:错误对象
    NSError *error = nil;
    GDataXMLDocument *docXML = [[GDataXMLDocument alloc] initWithData:dataXML options:0 error:&error];
    NSLog(@"error = %@", error);
    
    // 获得根节点元素对象
    GDataXMLElement *elemRoot = [docXML rootElement];
    // 搜索节点下面的所有的count元素对象
    // 将所有根节点所有的count对象添加到数组中返回这个数组
    NSArray *arrCount = [elemRoot elementsForName:@"count"];
    // 获得数组的第一个元素
    GDataXMLElement *elemCount = [arrCount objectAtIndex:0];
    // 获得元素的具体值
    NSString *strCount = [elemCount stringValue];
    NSLog(@"count = %@", strCount);
    
    NSArray *arrTotal = [elemRoot elementsForName:@"totalcount"];
    GDataXMLElement *elemTotal = [arrTotal objectAtIndex:0];
    NSString *strTotal = [elemTotal stringValue];
    NSLog(@"count = %@", strTotal);
    
    NSArray *arrUList = [elemRoot elementsForName:@"user_list"];
    // 获取最后一个元素
    GDataXMLElement *elemUList = [arrUList lastObject];
    NSArray *arrUsers = [elemUList elementsForName:@"user"];
    for(int i = 0; i < arrUsers.count; ++i)
    {
        GDataXMLElement *elemUser = arrUsers[i];
        NSArray *arrUName= [elemUser elementsForName:@"username"];
        
        GDataXMLElement *elemUName = [arrUName lastObject];
        NSString *uName = [elemUName stringValue];
        NSArray *arrUID = [elemUser elementsForName:@"uid"];
        
        
        GDataXMLElement *elemUID = [arrUID lastObject];
        NSString *uID = [elemUID stringValue];
        NSLog(@"uName = %@", uName);
        NSLog(@"uID = %@", uID);
        
        UserInfo *uInfo = [[UserInfo alloc] init];
        uInfo.mUserName = uName;
        uInfo.mUserID = uID;
        [_arrayData addObject:uInfo];
    }
}

#pragma mark -- UITableViewDataSource

// 设置数据视图的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 获取每组元素的个数（行数）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayData.count;
}

// 创建单元格对象函数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strID = @"ID";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:strID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strID];
    }
    
    UserInfo *uInfo = [_arrayData objectAtIndex:indexPath.row];
    cell.textLabel.text = uInfo.mUserName;
    cell.detailTextLabel.text = uInfo.mUserID;
    return cell;
}
@end
