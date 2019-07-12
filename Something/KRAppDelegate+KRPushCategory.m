//
//  KRAppDelegate+KRPushCategory.m
//  KrHelper
//
//  Created by 王亚振 on 2018/9/19.
//  Copyright © 2018年 DemoKing. All rights reserved.
//

#import "KRAppDelegate+KRPushCategory.h"
@implementation AppDelegate (KRPushCategory)

- (void)initUMengWithOptions:(NSDictionary *)launchOptions {
    [[UMSocialManager defaultManager] openLog:YES];
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    } else {
        // Fallback on earlier versions
    }
    // 推送相关
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    // type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标等
    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert|UMessageAuthorizationOptionSound;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions
                                                       Entity:entity
                                            completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                                if (granted) {
                                                    NSLog(@"注册成功");
                                                }else {
                                                    // 未打开
                                                }
                                            }];
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *deviceTokenString2 = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""]
                                     stringByReplacingOccurrencesOfString:@">" withString:@""]
                                    stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (!deviceTokenString2) {
        return;
    }
    [KJCommonMethods saveValue:deviceTokenString2 key:DEVICE_TOKEN];
    NSLog(@"deviceToken%@",deviceTokenString2);
    if ([KJCommonMethods valueForKey:ACCESS_TOKEN_ORGIN]) {
        NSString *version = [[UIDevice currentDevice] systemVersion];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
        [params setValue:version forKey:@"mobile_system"];
        [params setValue:deviceTokenString2 forKey:@"mobile_token"];
        [RequestEngine postRequestWithURLString:UPDATE_DEVICE_TOKEN_INTERFACE
                                         params:params
                                      complited:^(RequestResponse *response) {
                                        
                                      }];
    }
}
- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"推送消息注册失败");
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self nitificationWithInfo:userInfo];
}
//iOS10以下使用这两个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        NSLog(@"userInfo%@",userInfo);
        [UMessage didReceiveRemoteNotification:userInfo];
        completionHandler(UIBackgroundFetchResultNewData);
    }
    [self nitificationWithInfo:userInfo];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)) {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:NO];
        NSLog(@"不处理 userInfo%@",userInfo);
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"userInfo%@",userInfo);
        [UMessage didReceiveRemoteNotification:userInfo];
    }else {
        //应用处于后台时的本地推送接受
    }
    [self nitificationWithInfo:userInfo];
}

#pragma mark -
#pragma mark - PRIVITE 自定义方法 收到推送

- (void)nitificationWithInfo:(NSDictionary *)userInfo {
    /*
     aps =     {
     alert = "\U60a8\U53d1\U5e03\U7684\U9700\U6c42\U53c8\U6709\U4eba\U8bc4\U8bba\U5566\Uff0c\U5feb\U53bb\U770b\U770b\U5427";
     badge = 1;
     sound = default;
     };
     d = uu5m8k9154347489316600;
     p = 0;
     type = "system_message";
     value = "{\"message_type\": 1, \"system_id\": 12, \"message_id\": 15}";
     */
    if (![userInfo [@"type"] isEqualToString:@"system_message"]) {
        ALERT_VIEW(userInfo [@"aps"] [@"alert"]);
        return;
    }
    UITabBarController *tabbar = (UITabBarController *)MainWindow.rootViewController;
    UINavigationController *nav = tabbar.viewControllers [tabbar.selectedIndex];
    NSDictionary *info = [KJCommonMethods toDictionary:userInfo [@"value"]];
    [KJCommonUI showAlertViewWithTitle:@"推送消息"
                               message:userInfo [@"aps"] [@"alert"]
                     cancelButtonTitle:@"取消"
                       sureButtonTitle:@"立即查看"
                      inViewController:MainWindow.rootViewController
                           cancelBlock:nil sureBlock:^{
                               if ([info [@"message_type"] intValue] == 1) {
                               }
                           }];
}
@end
