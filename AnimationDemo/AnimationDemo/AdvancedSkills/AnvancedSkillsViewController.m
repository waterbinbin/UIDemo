//
//  AnvancedSkillsViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/6.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "AnvancedSkillsViewController.h"

@interface AnvancedSkillsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *viewControllers;

@end

@implementation AnvancedSkillsViewController

#pragma mark -- Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    self.title = @"IOS核心动画高级技巧书";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark -- LazyLoading

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

- (NSArray *)data
{
    if (!_data) {
        _data = [@[@"5.1仿射变换", @"5.2 3D变换", @"6.1 CAShaperLayer", @"6.2 CATextLayer", @"6.3 CATransformLayer", @"6.4 CAGradientLayer", @"6.5 CAReplicatorLayer"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [@[@"_51CGAffineTransformViewController", @"_52Transform3DViewController", @"_61CAShaperLayerViewController", @"_62CATextLayerViewController", @"_63CATransformLayerViewController", @"_64CAGradientLayerViewController", @"_65CAReplicatorLayerViewController"] copy];
    }
    return _viewControllers;
}

#pragma mark -- UITableViewDataSource

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

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[NSClassFromString(self.viewControllers[indexPath.row]) alloc] init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

@end
