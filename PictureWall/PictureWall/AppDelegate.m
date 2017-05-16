//
//  AppDelegate.m
//  PictureWall
//
//  Created by 王福滨 on 2017/4/18.
//  Copyright © 2017年 YY Inc. All rights reserved.
//

#import "AppDelegate.h"

#import "VCRoot.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 创建一个UIWindow对象
    // 整个程序中只有一个UIWindow对象
    // 在程序基本上表示屏幕窗口
    // UIWindow也是继承UIView
    // UIWindow是一个特殊的UIView
    // UIScreen：表示屏幕硬件表示类
    // mainScreen获得主屏幕设备信息
    // bounds表示屏幕宽高值
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 如果系统中有XIB名字根类名VCRoot相同，init函数会自动加载VCRoot.xib
    VCRoot* root = [[VCRoot alloc] init];
    
    // 创建导航控制器
    // 导航控制器只要用来管理多个视图控制器的切换
    // 层级的方式来管理多个视图控制器
    // 创建控制器时，一定要有根视图控制器
    // P1:就是作为导航控制器的根视图控制器
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:root];
    
    // 将window的根视图设置为导航控制器
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
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
