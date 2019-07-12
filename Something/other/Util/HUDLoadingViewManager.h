//
//  HUDLoadingViewManager.h
//  Krnavigationn
//
//  Created by 王亚振 on 2018/7/3.
//  Copyright © 2018年 KrVision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDLoadingViewManager : NSObject
+ (instancetype)shareManager;
- (void)showLoading;
- (void)hiddenLoading;
- (void)changeText:(NSString *)text;
@end
