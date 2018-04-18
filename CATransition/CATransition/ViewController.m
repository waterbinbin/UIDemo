//
//  ViewController.m
//  CATransition
//
//  Created by wangfubin on 2017/12/29.
//  Copyright © 2017年 wangfubin. All rights reserved.
//

// demo1 参考：https://onevcat.com/2013/10/vc-transition-in-ios7/
// demo2 - demo5 参考：https://www.jianshu.com/p/45434f73019e

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *viewControllers;

@end

@implementation ViewController

#pragma mark -- Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self p_setupNavigationController];
    [self p_setupUI];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Private

- (void)p_setupNavigationController
{
    self.title = @"转场动画";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)p_setupUI
{
    [self.view addSubview:self.tableView];
}

#pragma mark -- Getting & Setting
- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   self.view.bounds.size.width,
                                                                   self.view.bounds.size.height)
                                                  style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        
        // ios11新增
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
    }
    return _tableView;
}

#pragma mark -- LazyLoading

- (NSArray *)data
{
    if (!_data) {
        _data = [@[@"简单自定义present", @"弹性present", @"神奇移动", @"翻页效果", @"小圆点扩散", @"上下左右拖动view出来"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [@[@"Demo1ViewController", @"Demo2ViewController", @"CentreViewController", @"XWPageCoverController", @"XWCircleSpreadController", @"Demo4ViewController"] copy];
    }
    return _viewControllers;
}

#pragma mark -- UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

@end
