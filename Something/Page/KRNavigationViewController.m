//
//  KRNavigationViewController.m
//  VisionCircle
//
//  Created by 王亚振 on 2018/11/24.
//  Copyright © 2018 DemoKing. All rights reserved.
//

#import "KRNavigationViewController.h"

@interface KRNavigationViewController ()

@end

@implementation KRNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark --
#pragma mark -- super

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
