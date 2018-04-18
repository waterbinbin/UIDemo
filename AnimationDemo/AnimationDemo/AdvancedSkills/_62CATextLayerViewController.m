//
//  _62CATextLayerViewController.m
//  AnimationDemo
//
//  Created by wangfubin on 2018/1/8.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "_62CATextLayerViewController.h"
#import "LayerLabel.h"

@interface _62CATextLayerViewController ()

@property(nonatomic, strong) UIView *layerView;
@property(nonatomic, strong) LayerLabel *textLabel;

@end

@implementation _62CATextLayerViewController

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
    self.title = @"6.2 CATextLayer";
}

- (void)p_setupUI
{
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.layerView];
    [self.layerView addSubview:self.textLabel];
}

- (void)p_layerText
{
    //create a text layer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.layerView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;  // 不加这句会模糊
    [self.layerView.layer addSublayer:textLayer];
    
    //uncomment the line below to fix pixelation on Retina screens
    //textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //set text attributes
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;  // 不是UIFont类型，根据需要采用CGFontRef还是CTFontRef
    textLayer.fontSize = font.pointSize;
    
    CGFontRelease(fontRef);
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \
    elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
    leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc \
    elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
    fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
    lobortis";
    
    //set layer text
    textLayer.string = text;  //string属性不是NSString，而是id类型
}

// 富文本
- (void)p_layerText1
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.layerView.bounds;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layerView.layer addSublayer:textLayer];
    
    //set text attributes
    textLayer.alignmentMode = kCAAlignmentJustified;
    textLayer.wrapped = YES;
    
    //choose a font
    UIFont *font = [UIFont systemFontOfSize:15];
    
    //choose some text
    NSString *text = @"Lorem ipsum dolor sit amet, consectetur adipiscing \
    elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
    leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc \
    elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
    fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
    lobortis";
    
    //create attributed string
    NSMutableAttributedString *string = nil;
    string = [[NSMutableAttributedString alloc] initWithString:text];
    
    //convert UIFont to a CTFont
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    //set text attributes
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:
                                  (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                              };
    [string setAttributes:attribs range:NSMakeRange(0, [text length])];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName:
                    (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName:
                    @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    
    //release the CTFont we created earlier
    CFRelease(fontRef);
    
    //set layer text
    textLayer.string = string;
}

#pragma mark -- Event Response

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // Method1
//    [self p_layerText];
    // Method2
    [self p_layerText1];
}

#pragma mark -- LazyLoading

- (UIView *)layerView
{
    if(!_layerView)
    {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.size.width, self.view.size.height - 64)];
    }
    return _layerView;
}

- (UILabel *)textLabel
{
    if(!_textLabel)
    {
        _textLabel = [[LayerLabel alloc] initWithFrame:self.layerView.frame];
        _textLabel.numberOfLines = 0;
        [_textLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_textLabel setText:@"Lorem ipsum dolor sit amet, consectetur adipiscing \
                              elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar \
                              leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc \
                              elementum, libero ut porttitor dictum, diam odio congue lacus, vel \
                              fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet \
                              lobortis"];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _textLabel;
}

@end
