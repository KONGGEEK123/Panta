//
//  HUDLoadingViewManager.m
//  Krnavigationn
//
//  Created by 王亚振 on 2018/7/3.
//  Copyright © 2018年 KrVision. All rights reserved.
//

#import "HUDLoadingViewManager.h"

@interface HUDLoadingViewManager ()

@property (strong, nonatomic) UIView *shadowView;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (nonatomic, strong) dispatch_source_t waitingTimer;
@end

@implementation HUDLoadingViewManager

+ (instancetype)shareManager {
    static HUDLoadingViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HUDLoadingViewManager alloc] init];
    });
    return manager;
}

- (void)showLoading {
    // 移除上一次
    [self hiddenLoading];
    
    // 蒙版
    self.shadowView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.alpha = 0.5;
    [MainWindow addSubview:self.shadowView];
    
    // 菊花
    self.activityView = [[UIActivityIndicatorView alloc] init];
    self.activityView.center = POINT(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0);
    self.activityView.bounds = RECT(0, 0, 30, 30);
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    self.activityView.accessibilityElementsHidden = YES;
    [self.activityView startAnimating];
    [MainWindow addSubview:self.activityView];
    
    // 文字
    self.contentLabel = [[UILabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.contentLabel.frame = RECT(0, SCREEN_HEIGHT / 2.0 + 30, SCREEN_WIDTH, 20);
    self.contentLabel.textAlignment = NSTextAlignmentCenter;
    self.contentLabel.text = @"请稍等";
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.font = FONT(15);
    [MainWindow addSubview:self.contentLabel];
}

- (void)changeText:(NSString *)text {
    self.contentLabel.text = text;
}

- (void)hiddenLoading {
    [self.activityView stopAnimating];
    [self.shadowView removeFromSuperview];
    [self.activityView removeFromSuperview];
    [self.contentLabel removeFromSuperview];
}

#pragma mark -
#pragma mark - 定时器

- (void)startTime {
    @weakify(self);
    __block NSInteger time = 0;
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.waitingTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(0.25 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.waitingTimer, start, interval, 0);
    dispatch_source_set_event_handler(self.waitingTimer, ^{
        // do something
        time ++;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (time % 4 == 0) {
                weak_self.contentLabel.text = @"加载中";
            }else if (time % 3 == 1) {
                weak_self.contentLabel.text = @"加载中.";
            }else if (time % 3 == 2) {
                weak_self.contentLabel.text = @"加载中..";
            }else {
                weak_self.contentLabel.text = @"加载中...";
            }
        });
    });
    dispatch_resume(self.waitingTimer);
}
- (void)stopTimer {
    if (_waitingTimer) {
        dispatch_cancel(_waitingTimer);
        _waitingTimer = nil;
    }
}

@end
