//
//  ViewController.m
//  UIScrollView
//
//  Created by 王福滨 on 2017/4/13.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property(nonatomic, strong) UIScrollView* sv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _sv = [[UIScrollView alloc] init];
    // 设置滚动视图的位置，使用矩形来定位视图位置,原来576
    _sv.frame = CGRectMake(0, 0, 320, 500);
    
    // 是否按照整页来滚动视图
    _sv.pagingEnabled = YES;
    
    // 是否可以开启滚动效果
    _sv.scrollEnabled = YES;
    
    // 设置画布的大小，画布显示在滚动视图内部贸易版大于Frame的大小
    _sv.contentSize = CGSizeMake(320 * 3, 500);
    
    // 是否可以边缘弹动效果
    _sv.bounces = YES;
    
    // 开启横向弹动效果
    _sv.alwaysBounceHorizontal = YES;
    
    // 开启纵向弹动效果
    _sv.alwaysBounceVertical = YES;
    
    // 是否显示横向滚动条
    _sv.showsHorizontalScrollIndicator = YES;
    
    // 是否显示纵向滚动条
    _sv.showsHorizontalScrollIndicator = YES;
    
    // 设置背景颜色
    _sv.backgroundColor = [UIColor yellowColor];
    
    // 是否允许通过点击屏幕让滚动视图响应事件
    // YES:滚动视图可以接受触碰事件
    // NO：不接受触屏事件
    _sv.userInteractionEnabled = YES;
    
    // 使用循环创建3张图,横向滑动
    // 纵向的话修改contentSize，以及循环创建图片的方法即可
    for(int i = 0; i < 3; ++i)
    {
        NSString* strName = [NSString stringWithFormat:@"%d.jpeg", i];
        UIImage* image = [UIImage imageNamed:strName];
        UIImageView* iView = [[UIImageView alloc] initWithImage:image];
        iView.frame = CGRectMake(320 * i, 0, 320, 500);
        
        [_sv addSubview:iView];
    }
    
    // 滚动视图画布的移动位置，偏移位置
    // 功能：决定画布显示的最总图像结果
    _sv.contentOffset = CGPointMake(0, 0);
    
    // 设置代理
    _sv.delegate = self;
    
    [self.view addSubview:_sv];
}

#pragma mark 协议
// 当滚动视图结束拖动时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    NSLog(@"scrollViewDidEndDragging");
}

// 滚动视图即将开始被拖动时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDragging");
}

// 视图即将结束拖动
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"scrollViewWillEndDragging");
}

// 视图即将减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewWillBeginDecelerating");
}

// 视图已经结束减速时调用，视图停止的瞬间
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
}

// 不设定屏幕那么大，点击空白处，返回原点或者动画
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //让滚动视图移动到指定位置，动画移动
    [_sv scrollRectToVisible:CGRectMake(0, 0, 320, 500) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
