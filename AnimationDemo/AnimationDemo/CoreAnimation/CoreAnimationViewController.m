//
//  CoreAnimationViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/3.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

// 核心动画参考：https://www.jianshu.com/p/9ef4212c719e
// 如果显示的UI需要跟用户进行交互的话，就用UIView;如果不需要跟用户进行交互，两个都可以，但CALayer性能更高
// anchorPoint（x, y）和position(a, b)的关系就是以position(a, b)点为中心，沿着左边扩展redLayer的宽度 乘以 x；沿着右边扩展redLayer的宽度 乘以 （1 - x），沿着上边扩展redLayer的高度 乘以 y，沿着下边扩展redLayer的高度 乘以 (1 - y)

// 核心动画类中可以直接使用的类有:
// CABasicAnimation
// CAKeyframeAnimation  可以设定keyPath起点、中间关键点（不止一个）、终点的值，每一帧所对应的时间，动画会沿着设定点进行移动。
// CATransition
// CAAnimationGroup
// CASpringAnimation

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *viewControllers;

@end

@implementation CoreAnimationViewController

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
    self.title = @"CoreAnimation核心动画";
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
        _data = [@[@"CABasicAnimationPosition相关动画", @"CABasicAnimationRotation相关动画", @"CABasicAnimationScale相关动画", @"CABasicAnimationBound相关动画", @"CABasicAnimationSize相关动画", @"CABasicAnimationOpacity相关动画", @"CABasicAnimationBackgroundColor相关动画", @"CABasicAnimationCornerRadius和Border相关动画", @"CABasicAnimationContents相关动画", @"CABasicAnimationShadow相关动画", @"CAKeyframeAnimationPosition相关动画", @"CAKeyframeAnimationRotation相关动画", @"CAKeyframeAnimationPath相关动画", @"CAKeyframeAnimationTransform相关动画", @"CATransition转场相关动画", @"CASpringAnimation弹簧动画", @"CAAnimationGroup动画组"] copy];
    }
    return _data;
}

- (NSArray *)viewControllers
{
    if (!_viewControllers) {
        _viewControllers = [@[@"CABasicAnimationPositionViewController", @"CABasicAnimationRotationViewController", @"CABasicAnimationScaleViewController", @"CABasicAnimationBoundViewController", @"CABasicAnimationSizeViewController", @"CABasicAnimationOpacityViewController", @"CABasicAnimationBackgroundColorViewController", @"CABasicAnimationCornerRadiusAndBorderViewController", @"CABasicAnimationContentsViewController", @"CABasicAnimationShadowViewController", @"CAKeyframeAnimationPositionViewController", @"CAKeyframeAnimationRotationViewController", @"CAKeyframeAnimationPathViewController", @"CAKeyframeAnimationTransformViewController", @"CATransitionViewController", @"CASpringAnimationViewController", @"CAAnimationGroupViewController"] copy];
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
