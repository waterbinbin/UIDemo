//
//  UIViewAnimationViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/3.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

// UIView动画参考：https://www.jianshu.com/p/67919eb42ad1

#import "UIViewAnimationViewController.h"

@interface UIViewAnimationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *viewControllers;

@end

@implementation UIViewAnimationViewController

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
    self.title = @"UIViewAnimations动画";
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
        _data = [@[@"ChangeFrame动画", @"Flip转场动画（curUp等更换参数类似", @"ChangeFrame Block动画", @"弹簧Block动画", @"Keyframes Block动画", @"转场动画Block", @"GIF动画"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [@[@"ChangeFrameViewController", @"FlipAnimationViewController", @"ChangeFrameBlockViewController", @"SpringAnimationViewController", @"KeyFramesAnimationViewController", @"TransitionAnimationViewController", @"GIFAnimationViewController"] copy];
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
