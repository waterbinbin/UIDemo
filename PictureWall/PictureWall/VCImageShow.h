//
//  VCImageShow.h
//  PictureWall
//
//  Created by 王福滨 on 2017/4/18.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCImageShow : UIViewController

// 图像视图的tag
@property(nonatomic, assign) NSUInteger imageTag;
// 图像对象
@property(nonatomic, retain) UIImage* image;
// 图像视图对象
@property(nonatomic, retain) UIImageView* imageView;

@end
