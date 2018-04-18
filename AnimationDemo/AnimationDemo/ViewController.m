//
//  ViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/3.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

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
    self.title = @"动画";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    UIButton *btnImage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btnImage setTitle:@"test" forState:UIControlStateNormal];
    [btnImage setFrame:CGRectMake(0, 0, 40, 40)];
    [btnImage setTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* addBtn = [[UIBarButtonItem alloc] initWithCustomView:btnImage];
    
    self.navigationItem.rightBarButtonItem = addBtn;
}

- (void)test
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"test" message:@"test" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
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
        _data = [@[@"UIViewAnimations动画", @"CoreAnimation核心动画", @"IOS核心动画高级技巧书"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [@[@"UIViewAnimationViewController", @"CoreAnimationViewController", @"AnvancedSkillsViewController"] copy];
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
