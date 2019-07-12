//
//  KRAppDelegate+KRPushCategory.h
//  KrHelper
//
//  Created by 王亚振 on 2018/9/19.
//  Copyright © 2018年 DemoKing. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>
#import <UMPush/UMessage.h>
#import <UMShare/UMShare.h>
#import <UMAnalytics/MobClick.h>

@interface AppDelegate (KRPushCategory)<UNUserNotificationCenterDelegate>
- (void)initUMengWithOptions:(NSDictionary *)launchOptions;
@end
