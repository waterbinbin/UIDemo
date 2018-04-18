//
//  Demo2ViewController.m
//  CATransition
//
//  Created by wangfubin on 2018/1/2.
//  Copyright © 2018年 wangfubin. All rights reserved.
//

#import "Demo2ViewController.h"

@interface Demo2ViewController ()<CAAnimationDelegate>

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImageView *beginView;

@end

@implementation Demo2ViewController

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
    self.title = @"弹性present";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)p_setupUI
{
    self.imageView = [[UIImageView alloc] init];
    [self.imageView setImage:[UIImage imageNamed:@"2.jpeg"]];
    [self.view addSubview:self.imageView];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];
    
    self.imageView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:pan];
}

- (void)p_imageViewAnimation:(UIImageView *)beginView persent:(CGFloat)persent newCenter:(CGPoint)newCenter
{
    //画两个圆路径
    CGFloat radius = sqrtf(beginView.frame.size.height * beginView.frame.size.height + beginView.frame.size.width * beginView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:beginView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIImageView *endView = beginView;
    if(persent < 0)
    {
        persent = -persent;
    }
    endView.frame = CGRectMake(newCenter.x, newCenter.y , radius * (1 - 3 * persent), radius * (1 - 3 * persent));
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:endView.frame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    beginView.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = 0.5;
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:endView forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    UIImageView *imageView = [anim valueForKey:@"transitionContext"];
    self.beginView = imageView;
}

#pragma mark -- Action
- (void)pan:(UIPanGestureRecognizer *)panGesture
{
    //手势百分比
    CGFloat persent = 0;
    CGFloat transitionY = [panGesture translationInView:panGesture.view].y;
    persent = transitionY / panGesture.view.frame.size.width;
    
    UIView *imageView = panGesture.view;
    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + self.imageView.center.x - [UIScreen mainScreen].bounds.size.width / 2, [panGesture translationInView:panGesture.view].y + self.imageView.center.y - [UIScreen mainScreen].bounds.size.height / 2);;
    
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            //手势开始的时候标记手势状态，并开始相应的事件
            if(!self.beginView)
            {
                self.beginView = self.imageView;
            }
            NSLog(@"x:%f, y:%f persent:%f", newCenter.x, newCenter.y, persent);
            [self p_imageViewAnimation:self.beginView persent:persent newCenter:newCenter];
            break;
        case UIGestureRecognizerStateChanged:{
            //手势过程中，通过updateInteractiveTransition设置pop过程进行的百分比
            
            break;
        }
        case UIGestureRecognizerStateEnded:{
            //手势完成后结束标记并且判断移动距离是否过半，过则finishInteractiveTransition完成转场操作，否者取消转场操作

            if (persent > 0.5) {

            }else{

            }
            break;
        }
        default:
            break;
    }
    
    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(newCenter).priorityLow();
    }];
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

@end
