//
//  MineViewController.m
//  Something
//
//  Created by 王亚振 on 2019/7/10.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark --
#pragma mark -- PRIVATE SUPPER

- (void)refreshUI {
    self.navigationItem.title = @"个人中心";
    self.navigationItem.leftBarButtonItem = nil;
}
@end
