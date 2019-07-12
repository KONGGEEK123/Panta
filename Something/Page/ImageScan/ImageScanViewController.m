//
//  ImageScanViewController.m
//  Something
//
//  Created by 王亚振 on 2019/7/10.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "ImageScanViewController.h"

@interface ImageScanViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@end

@implementation ImageScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.pageScrollView.backgroundColor = [UIColor whiteColor];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.view addGestureRecognizer:longPress];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipe];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [KJCommonMethods hiddenStatus:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [KJCommonMethods hiddenStatus:NO];
}

#pragma mark --
#pragma mark -- PRIVATE SUPPER

- (void)refreshUI {
    for (int i = 0; i < self.imagesURLArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = RECT(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, [self.pageScrollView getHeight]);
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesURLArray [i]]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.pageScrollView addSubview:imageView];
    }
    self.pageScrollView.contentSize = SIZE(SCREEN_WIDTH * self.imagesURLArray.count, [self.pageScrollView getHeight]);
}

+ (void)showImageWithImageURLArray:(NSArray *)array {
    ImageScanViewController *vc = [[ImageScanViewController alloc] init];
    vc.imagesURLArray = array;
    [MainWindow.rootViewController presentViewController:vc animated:YES completion:nil];
}

#pragma mark --
#pragma mark -- INTERFACE

- (void)longPress:(UIGestureRecognizer *)press {
    if (press.state == UIGestureRecognizerStateBegan) {
        [KJCommonUI showSheetViewWithTitle:@"保存"
                                   message:nil
                         cancelButtonTitle:@"取消"
                                titleArray:@[@"保存到相册"]
                          inViewController:self
                               cancelBlock:nil
                                 sureBlock:^(UIAlertAction *action) {
                                     if ([action.title isEqualToString:@"保存到相册"]) {
                                         
                                     }
        }];
    }
}
- (void)swipe:(UIGestureRecognizer *)press {
    if (press.state == UIGestureRecognizerStateEnded) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)tapInSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
