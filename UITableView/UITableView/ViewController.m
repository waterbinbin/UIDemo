//
//  ViewController.m
//  UItableView
//
//  Created by 王福滨 on 2017/4/22.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

// 定一个一个数据视图
// 数据视图用来显示大量相同格式的大量信息的视图
// 例如：电话通信录，QQ好友，朋友圈
@property(nonatomic, strong) UITableView *tableView;
// 声明一个数据源
@property(nonatomic, strong) NSMutableArray *arrayData;

@property(nonatomic, strong) UIBarButtonItem *btnEdit;
@property(nonatomic, strong) UIBarButtonItem *btnFinish;
@property(nonatomic, strong) UIBarButtonItem *btnDelete;
@property(nonatomic) BOOL isEdit;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 创建
    // P1:数据视图的位置
    // P2:数据视图的风格
    // UITableViewStylePlain:普通风格
    // UITableViewStyleGrouped:分组风格
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    // 自动调整子视图的大小
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // 设置数据视图的代理对象
    _tableView.delegate = self;
    // 设置数据视图的数据源对象
    _tableView.dataSource = self;
    
    // 数据视图的头部视图和尾部视图的设定
    _tableView.tableHeaderView = nil;
    _tableView.tableFooterView = nil;
    
    [self.view addSubview:_tableView];
    
    // 创建一个可变数组
    _arrayData = [[NSMutableArray alloc] init];
    
    for(int i = 'A'; i <= 'Z'; ++i)
    {
        // 定义小数组
        NSMutableArray *arraySmall = [[NSMutableArray alloc] init];
        
        for(int j = 1; j <= 5; ++j)
        {
            NSString *str = [NSString stringWithFormat:@"%c%d", i, j];
            [arraySmall addObject:str];
        }
        
        // 生成一个二位数组
        [_arrayData addObject:arraySmall];
    }
    
    // 当数据的数据源发生变化时，更新数据视图，重新加载数据
    [_tableView reloadData];
    
    [self createBtn];
}

- (void)createBtn
{
    _isEdit = NO;
    _btnEdit = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(pressEdit)];
    _btnFinish = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(pressFinish)];
    _btnDelete = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(pressDelete)];
    
    self.navigationItem.rightBarButtonItem = _btnEdit;
    
}

- (void)pressEdit
{
    _isEdit = YES;
    self.navigationItem.rightBarButtonItem = _btnFinish;
    self.navigationItem.leftBarButtonItem = _btnDelete;
    [_tableView setEditing:YES];
}

- (void)pressFinish
{
    _isEdit = NO;
    self.navigationItem.rightBarButtonItem = _btnEdit;
    self.navigationItem.leftBarButtonItem = nil;
    [_tableView setEditing:NO];
}

- (void) pressDelete
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableViewDataSource
// 获取每组元素的个数（行数）
// 必须要实现的协议函数
// 程序在显示数据视图会调用
// 返回值：表示每组元素的个数
// P1:数据视图对象本身
// P2:那一组需要的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numRow = [[_arrayData objectAtIndex:section] count];
    return numRow;
}

// 设置数据视图的组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _arrayData.count;
}

// 创建单元格对象函数
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellStr = @"Cell";
    
    // 尝试获取可以服用的单元格
    // 如果得不到，返回nil
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellStr];
    if(cell == nil)
    {
        // 创建一个单元格对象
        // P1:单元格样式
        // P2:单元格复用标记
        // 默认：UITableViewCellStyleDefault
        // 有子标题：UITableViewCellStyleSubtitle
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStr];
    }
    //NSString *str = [NSString stringWithFormat:@"第%ld组，第%ld行", indexPath.section, indexPath.row];
    cell.textLabel.text = _arrayData[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = @"子标题";
    
    // 设置默认图标信息
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg", indexPath.row % 7 + 1]];
    cell.imageView.image = image;
    return cell;
}

#pragma mark -- UITableViewDelegate
// 返回单元格的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

// 获取头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"头部标题";
}

// 获取尾部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"尾部标题";
}

// 获取尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

// 高级协议
// 单元格显示效果协议
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 默认为删除UITableViewCellEditingStyleDelete
    // UITableViewCellEditingStyleInsert
    // UITableViewCellEditingStyleNone
    // 多选状态UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert
    return UITableViewCellEditingStyleDelete;
}

// 可以显示编辑状态，当手指在单元格左移动时
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 删除数据源对应的数据
    [_arrayData[indexPath.section] removeObjectAtIndex:indexPath.row];
    [_tableView reloadData];
    NSLog(@"delete");
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中单元格：%ld, %ld", indexPath.section, indexPath.row);
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"取消单元格：%ld, %ld", indexPath.section, indexPath.row);
}
@end
