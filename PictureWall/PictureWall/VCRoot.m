//
//  VCRoot.m
//  PictureWall
//
//  Created by 王福滨 on 2017/4/18.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "VCRoot.h"

#import "VCImageShow.h"

@interface VCRoot ()

@end

@implementation VCRoot

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Picture Wall";
    
    // 使导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    
    UIScrollView* sv = [[UIScrollView alloc] init];
    sv.frame = CGRectMake(10, 10, 300, 510);
    // 设置画布大小
    sv.contentSize = CGSizeMake(300, 480 * 1.5);
    sv.showsVerticalScrollIndicator = NO;
    
    // 打开交互事件
    sv.userInteractionEnabled = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    for(int i = 0; i < 15; ++i)
    {
        NSString* strName = [NSString stringWithFormat:@"%d.jpeg", i];
        UIImage* image = [UIImage imageNamed:strName];
        UIImageView* iView = [[UIImageView alloc] initWithImage:image];
        iView.frame = CGRectMake(3 + i % 3 * 100, i / 3 * 140 + 10, 90, 130);
        [sv addSubview:iView];
        
        // 打开交互事件
        iView.userInteractionEnabled = YES;
        // 创建点击手势
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressTap:)];
        // 单次点击
        tap.numberOfTapsRequired = 1;
        // 单个手指
        tap.numberOfTouchesRequired = 1;
        
        [iView addGestureRecognizer:tap];
        
        // 图像对象的tag值
        iView.tag = 101 + i;
    }
    
    [self.view addSubview:sv];
}


- (void)pressTap:(UITapGestureRecognizer *)tap
{
    UIImageView* imageView = (UIImageView *)tap.view;
    
    // 创建视图控制器
    VCImageShow* imageShow = [[VCImageShow alloc] init];
    // 方法1:点击图像视图赋值，有bug
    //imageShow.imageView = imageView;
    // 方法2:这里为了不让点一个少一个将image传入。可以
    //imageShow.image = imageView.image;
    // 方法3:
    imageShow.imageTag = imageView.tag;
    
    // 将控制器推出
    [self.navigationController pushViewController:imageShow animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
