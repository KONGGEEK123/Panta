//
//  AppDelegate.m
//  Something
//
//  Created by 王亚振 on 2019/7/8.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "AppDelegate.h"
#import "KRNavigationViewController.h"
#import "HomeViewController.h"
#import "MineViewController.h"
#import "ShootViewController.h"

#import <IQKeyboardManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [RequestEngine checkNetWorkState:nil];
    [self mainViewController];
    [self iqManager];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)mainViewController {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    KRNavigationViewController *homeNav = [[KRNavigationViewController alloc] initWithRootViewController:homeVC];
    MineViewController *mineVC = [[MineViewController alloc] init];
    KRNavigationViewController *mineNav = [[KRNavigationViewController alloc] initWithRootViewController:mineVC];
    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = @[homeNav,mineNav];
    self.window.rootViewController = tabbarController;
    
    UIImage *image0 = IMAGE(@"tabbar0");
    UIImage *image1 = IMAGE(@"tabbar1");
    
    UIImage *image00 = IMAGE(@"tabbar00");
    UIImage *image11 = IMAGE(@"tabbar11");
    
    image0 = [image0 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    image1 = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    image00 = [image00 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    image11 = [image11 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    homeNav.tabBarItem.title = @"主页";
    mineNav.tabBarItem.title = @"我的";
    
    homeNav.tabBarItem.selectedImage = image0;
    mineNav.tabBarItem.selectedImage = image1;
    
    homeNav.tabBarItem.image = image00;
    mineNav.tabBarItem.image = image11;
    
    // 设置标题样式
    [UITabBar appearance].translucent = NO;
    NSDictionary *dictHome = [NSDictionary dictionaryWithObject:[UIColor colorWithHexString:COLOR_333333] forKey:NSForegroundColorAttributeName];
    [homeNav.tabBarItem setTitleTextAttributes:dictHome forState:UIControlStateSelected];
    NSDictionary *dictMine = [NSDictionary dictionaryWithObject:[UIColor colorWithHexString:COLOR_333333] forKey:NSForegroundColorAttributeName];
    [mineNav.tabBarItem setTitleTextAttributes:dictMine forState:UIControlStateSelected];
}
- (void)iqManager {
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    keyboardManager.shouldToolbarUsesTextFieldTintColor = NO; // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
    keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
}
@end
