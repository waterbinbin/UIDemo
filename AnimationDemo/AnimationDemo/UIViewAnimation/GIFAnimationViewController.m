//
//  GIFAnimationViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/3.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "GIFAnimationViewController.h"

@interface GIFAnimationViewController ()

@property(nonatomic, strong) UIImageView *imagesView;
@property(nonatomic, strong) NSMutableArray *imagesArr;

@end

@implementation GIFAnimationViewController

#pragma mark -- Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self p_setupNavigationController];
    [self p_setupUI];
    [self p_setupMasonry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

#pragma mark -- Public

- (void)startAnimation:(int)count name:(NSString *)name duration:(NSTimeInterval)duration repeat:(NSInteger)repeat
{
    [self p_setupImages:count name:name];
    
    // 把存有UIImage的数组赋给动画图片数组
    self.imagesView.animationImages = self.imagesArr;
    // 移除所有
    [self.imagesArr removeAllObjects];
    self.imagesArr = nil;
    // 设置执行一次完整动画的时长
    self.imagesView.animationDuration = duration;
    // 动画重复次数 （0为重复播放）
    self.imagesView.animationRepeatCount = repeat;
    // 开始播放动画
    [self.imagesView startAnimating];
    // 清除self.imagesView.animationImages
    [self.imagesView performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:self.imagesView.animationDuration + 1];
}

- (void)stopAnimation
{
    [self.imagesView stopAnimating];
}

#pragma mark -- Private

- (void)p_setupNavigationController
{
    self.title = @"GIF动画";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imagesView];
}

- (void)p_setupMasonry
{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(250);
    }];
}

- (void)p_setupImages:(int)count name:(NSString *)name
{
    for (int i = 0; i < count; ++i)
    {
        // method1:imageNamed: 有缓存机制(传入文件名)；好处是快，坏处就是占内存，并且使用了performSelector:@selector(setAnimationImages:)也不生效
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d", name, i]];
        
        // method2:imageWithContentsOfFile: 没有缓存(传入文件的全路径) 但是没法加载Assets.xcassets的图片
//        NSBundle *bundle = [NSBundle mainBundle];
//        NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"%@%d.png", name, i] ofType:nil];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        // method3:YYkit 没有内存增长问题
        UIImage *image1 = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d", name, i]];
        NSData *data = UIImagePNGRepresentation(image1);
        YYImage *image = [YYImage imageWithData:data scale:1];
        [self.imagesArr addObject:image];
    }
}

#pragma mark -- LazyLoad

- (UIImageView *)imagesView
{
    if (!_imagesView)
    {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}

- (NSMutableArray *)imagesArr
{
    if(!_imagesArr)
    {
        _imagesArr = [[NSMutableArray alloc] init];
    }
    return _imagesArr;
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(self.imagesView.isAnimating)
    {
        return;
    }
    [self startAnimation:24 name:@"bye" duration:2.0 repeat:1];
}

@end
