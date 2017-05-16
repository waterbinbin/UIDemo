//
//  VCImageShow.m
//  PictureWall
//
//  Created by 王福滨 on 2017/4/18.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "VCImageShow.h"

@interface VCImageShow ()

@end

@implementation VCImageShow

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Show Image";
    
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(0, 0, 320, 480);
    
    // 方法2：
    //_imageView.image = _image;
    
    // 方法3:
    _imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu.jpeg",_imageTag - 101]];
    
    // 一个视图对象只能有一个根视图
    // 当我们把视图添加到新的父亲上时就会从原理的父亲视图给删除所以就点一个没一个
    [self.view addSubview:_imageView];
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
