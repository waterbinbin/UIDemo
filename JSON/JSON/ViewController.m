//
//  ViewController.m
//  JSON
//
//  Created by 王福滨 on 2017/5/8.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

// 数组字典
static NSDictionary *dic;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self parseData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"dataJson = %@", dic);
}

- (void)parseData
{
    // 获取json文件在手机中的路径
    // mainBundle获取主资源包
    // pathForResource:获得json文件的全路径
    // P1:文件的名字
    // P2:文件扩展名
    NSString *path = [[NSBundle mainBundle] pathForResource:@"airlineData" ofType:@"json"];
    // 将文件读取出来，作为二进制存储到内存中
    // P：文件路径
    // 放回值为二进制文件格式
    NSData *dataJson = [NSData dataWithContentsOfFile:path];
    
    // NSJSONSerialization：将数据解析类
    // P1:二进制的数据对象
    // P2:解析方式，默认解析方式
    // P3:错误信息对象
    // 返回值：将解析后的数据保存在字典中放回
    NSDictionary *dicRoot = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingMutableLeaves error:nil];
    
    // 判断是否为字典
    if([dicRoot isKindOfClass:[NSDictionary class]])
    {
        // 开始解释
        _arrayAirline = [[NSMutableArray alloc] init];
        // 解释根数据
        NSArray *arrayAirlines = [dicRoot objectForKey:@"airlines"];
        
        // 遍历数组
        for(int i = 0; i < arrayAirlines.count; ++i)
        {
            NSDictionary *dicAirline = [arrayAirlines objectAtIndex:i];
            
            NSString *airLineID = [dicAirline objectForKey:@"Airline ID"];
            NSString *name = [dicAirline objectForKey:@"Name"];
            NSString *alias = [dicAirline objectForKey:@"Alias"];
            
            Model *model = [[Model alloc] init];
            model.mAirLineID = airLineID;
            model.mName = name;
            model.mAlias = alias;
            
            // 添加到数组
            [_arrayAirline addObject:model];
        }
    }
    
    // 刷新
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return _arrayAirline.count;
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
    
    Model *model = [_arrayAirline objectAtIndex:indexPath.row];
    cell.textLabel.text = model.mName;
    cell.detailTextLabel.text = model.mAirLineID;
    return cell;
}


@end
