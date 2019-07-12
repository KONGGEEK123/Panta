//
//  BaseViewController.m
//  Something
//
//  Created by 王亚振 on 2019/7/10.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BaseViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    //  防止根视图侧滑出现卡顿
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInSelf)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self refreshUI];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor colorWithHexString:COLOR_333333]}];
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonBack.bounds = RECT(0, 0, 40, 40);
        [buttonBack addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonBack setImage:IMAGE(@"fanhui") forState:UIControlStateNormal];
        if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 11.0) {
            [buttonBack setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        }
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:buttonBack];
        item.title = @"返回";
        self.navigationItem.leftBarButtonItem = item;
    }
}

#pragma mark --
#pragma mark -- INTERFACE

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView" ]) {
        [self.view endEditing:YES];
        return NO;
    }
    if ([touch.view isKindOfClass:[UISlider class]]) {
        return NO;
    }
    if ([NSStringFromClass([touch.view.superview class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    if ([NSStringFromClass([touch.view
                            class]) isEqualToString:@"UICollectionViewCell"]) {
        return NO;
    }
    return YES;
}

#pragma mark --
#pragma mark -- DELEGATE <UIAccessibilityAction>

- (BOOL)accessibilityPerformEscape {
    if (self.navigationController.viewControllers.count) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    return YES;
}

#pragma mark -
#pragma mark - PRIVITE 自定义方法 交互

- (void)tapInSelf {
    [self.view endEditing:YES];
}

#pragma mark --
#pragma mark -- PRIVATE SUPPER

- (void)refreshUI{};
- (void)backButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
};
@end
