//
//  AppDelegate.m
//  UITabBarController
//
//  Created by 王福滨 on 2017/4/17.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "VCFirst.h"
#import "VCSecond.h"
#import "VCThird.h"
#import "VCFour.h"
#import "VCFive.h"
#import "VCSix.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 创建一个UIWindow对象
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 显示window
    [self.window makeKeyAndVisible];
    
    // 创建控制器1
    VCFirst* vcFirst = [[VCFirst alloc] init];
    
    
    // 创建控制器2
    VCSecond* vcSeconde = [[VCSecond alloc] init];
    vcSeconde.view.backgroundColor = [UIColor yellowColor];
    
    // 创建控制器3
    VCThird* vcThird = [[VCThird alloc] init];
    vcThird.view.backgroundColor = [UIColor orangeColor];
    
    // 创建控制器4
    VCFour* vcFour = [[VCFour alloc] init];
    vcFour.view.backgroundColor = [UIColor purpleColor];
    
    // 创建控制器5
    VCFive* vcFive = [[VCFive alloc] init];
    vcFive.view.backgroundColor = [UIColor grayColor];
    
    // 创建控制器6
    VCSix* vcSix = [[VCSix alloc] init];
    vcSix.view.backgroundColor = [UIColor greenColor];
    
    vcFirst.title = @"视图1";
    vcSeconde.title = @"视图2";
    vcThird.title = @"视图3";
    vcFour.title = @"视图4";
    vcFive.title = @"视图5";
    vcSix.title = @"视图6";
    
    // 放在这里在VCFirst中的标题就不会被覆盖
    vcFirst.view.backgroundColor = [UIColor blueColor];
    
    // 创建分栏控制器对象
    UITabBarController* tbController = [[UITabBarController alloc] init];
    
    // 创建一个控制器数组对象
    // 将所有要被分栏控制器管理的对象添加到数组中
    NSArray* arrayVC = [NSArray arrayWithObjects:vcFirst,
                                                 vcSeconde,
                                                 vcThird,
                                                 vcFour,
                                                 vcFive,
                                                 vcSix,
                                                 nil];
    
    // 将分栏视图控制区管理数组赋值
    tbController.viewControllers = arrayVC;
    
    // 设置选中的视图控制器的索引
    // 通过索引来确定显示哪一个控制器
    tbController.selectedIndex = 2;
    
    // 当前选中的控制器对象
    if(tbController.selectedViewController == vcThird)
    {
        NSLog(@"显示视图3");
    }
    
    // 设置分栏控制器的工具栏的透明度
    tbController.tabBar.translucent = NO;
    
    // 改变工具栏颜色
    tbController.tabBar.barTintColor = [UIColor redColor];
    // 更改按钮风格
    tbController.tabBar.tintColor = [UIColor blackColor];
    
    // 将分栏控制器作为根视图的控制器
    self.window.rootViewController = tbController;
    
    tbController.delegate = self;
    
    return YES;
}

#pragma mark 协议
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers
{
    NSLog(@"编辑器前");
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed
{
    NSLog(@"即将结束前");
}

- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(nonnull NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed
{
    NSLog(@"vcs = %@", viewControllers);
    if(changed == YES)
    {
        NSLog(@"顺序发生改变");
    }
    NSLog(@"已经结束编辑");
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(tabBarController.viewControllers[tabBarController.selectedIndex] == viewController)
    {
        NSLog(@"OK1");
    }
    NSLog(@"选中控制器对象");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
