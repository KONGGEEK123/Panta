//
//  UMShareEngine.m
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/5/11.
//  Copyright © 2018年 shike. All rights reserved.
//

#import "UMShareEngine.h"
#import "UMengShareView.h"
#import "UIView+KJClick.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "WXApi.h"
#import <UMAnalytics/MobClick.h>

@implementation UMShareEngine
+ (void)UMENGKey {
    [UMConfigure initWithAppkey:UMENG_KEY channel:@"App Store"];
    [UMShareEngine QQKey];
    [UMShareEngine WXKey];
    [WXApi registerApp:WE_CHAT_KEY];
    
    [MobClick setCrashReportEnabled:YES];
}
+ (void)QQKey {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:QQ_KEY
                                       appSecret:nil
                                     redirectURL:nil];
}
+ (void)WXKey {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:WE_CHAT_KEY
                                       appSecret:WE_CHAT_SECRET
                                     redirectURL:nil];
}
+ (void)WBKey:(NSString *)key appSecret:(NSString *)appSecret {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                          appKey:key
                                       appSecret:appSecret
                                     redirectURL:nil];
}
+ (void)shareWithTitle:(NSString *)title
           description:(NSString *)description
        shareURLString:(NSString *)shareURLString {
    
    UITabBarController *tabbar = (UITabBarController *)MainWindow.rootViewController;
    UINavigationController *nav = tabbar.viewControllers [tabbar.selectedIndex];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [MainWindow addSubview:view];
    
    UMengShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"UMengShareView" owner:nil options:nil] firstObject];
    shareView.frame = RECT(0, SCREEN_HEIGHT, SCREEN_WIDTH, 180);
    [UIView animateWithDuration:0.3 animations:^{
        shareView.frame = RECT(0, SCREEN_HEIGHT - 180, SCREEN_WIDTH, 180);
    }];
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, shareView);
    @weakify(shareView)
    shareView.block = ^(NSInteger tag) {
        [RequestEngine postRequestWithURLString:UPLOAD_SHARE_METHOD_INTERFACE
                                         params:nil complited:^(RequestResponse *response) {
                                             
                                         }];
        [UMShareEngine removeViewWithShadow:view contentView:weak_shareView mainView:nil];
        UMSocialPlatformType type;
        if (tag == 1 ||
            tag == 2) {
            int scene;
            if (tag == 1) {
                scene = WXSceneSession;
            }else {
                scene = WXSceneTimeline;
            }
            [UMShareEngine wxShare:scene
                             title:title
                       description:description
                               url:shareURLString];
            return ;
        }
        if (tag == 3) {
            type = UMSocialPlatformType_QQ;
        }else if (tag == 4) {
            type = UMSocialPlatformType_Qzone;
        }else {
//            [[NSNotificationCenter defaultCenter] postNotificationName:SHARE_FINISH object:nil userInfo:nil];
            return ;
        }
        [UMShareEngine UMENGShareWithTitle:title
                               description:description
                            shareURLString:shareURLString
                        socialPlatformType:type];
    };
    [MainWindow addSubview:shareView];
    
    @weakify(view)
    view.tapClickBlock = ^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:SHARE_FINISH object:nil userInfo:nil];
        [UMShareEngine removeViewWithShadow:weak_view contentView:weak_shareView mainView:nil];
    };
}
+ (void)shareWithTitle:(NSString *)title
           description:(NSString *)description
        shareURLString:(NSString *)shareURLString
                  type:(int)type {
    [RequestEngine postRequestWithURLString:UPLOAD_SHARE_METHOD_INTERFACE
                                     params:nil complited:^(RequestResponse *response) {
                                         
                                     }];
    if (type == 1 ||
        type == 2) {
        int scene;
        if (type == 1) {
            scene = WXSceneSession;
        }else {
            scene = WXSceneTimeline;
        }
        [UMShareEngine wxShare:scene
                         title:title
                   description:description
                           url:shareURLString];
        return ;
    }
    UMSocialPlatformType socialPlatformType;
    if (type == 3) {
        socialPlatformType = UMSocialPlatformType_QQ;
    }else if (type == 4) {
        socialPlatformType = UMSocialPlatformType_Qzone;
    }else {
        //            [[NSNotificationCenter defaultCenter] postNotificationName:SHARE_FINISH object:nil userInfo:nil];
        return ;
    }
    [UMShareEngine UMENGShareWithTitle:title
                           description:description
                        shareURLString:shareURLString
                    socialPlatformType:socialPlatformType];
}
/**
 邀请好友的分享 微信 QQ 通讯录
 
 @param title 固定
 @param description 固定
 @param shareURLString shareURLString
 @param tel tel
 */
+ (void)shareWithTitle:(NSString *)title
           description:(NSString *)description
        shareURLString:(NSString *)shareURLString
                  mainview:(UIView*)mainview
                   tel:(void(^)(BOOL isTEL))tel {
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.3;
    [MainWindow addSubview:view];
    mainview.accessibilityElementsHidden = YES;
    UMengShareView *shareView = [[[NSBundle mainBundle] loadNibNamed:@"UMengShareView"
                                                               owner:nil
                                                             options:nil]
                                 lastObject];
    shareView.frame = RECT(0, SCREEN_HEIGHT, SCREEN_WIDTH, 180);
    [UIView animateWithDuration:0.3 animations:^{
        shareView.frame = RECT(0, SCREEN_HEIGHT - 180, SCREEN_WIDTH, 180);
    }];
    @weakify(shareView)
    shareView.block = ^(NSInteger tag) {
        [UMShareEngine removeViewWithShadow:view contentView:weak_shareView mainView:mainview];
        UMSocialPlatformType type;
        if (tag == 1) {
            type = UMSocialPlatformType_WechatSession;
        }else if (tag == 3) {
            type = UMSocialPlatformType_QQ;
        }else if (tag == 4) {
            if (tel) {
                tel(YES);
            }
            return ;
        }else {
            return ;
        }
        [UMShareEngine UMENGShareWithTitle:title
                               description:description
                            shareURLString:shareURLString
                        socialPlatformType:type];
    };
    [MainWindow addSubview:shareView];
    
    @weakify(view)
    view.tapClickBlock = ^{
        
        [UMShareEngine removeViewWithShadow:weak_view contentView:weak_shareView mainView:mainview];
    };
}
+ (void)removeViewWithShadow:(UIView *)shadowView contentView:(UIView *)contentView mainView:(UIView*)mainView {
    [UIView animateWithDuration:0.3 animations:^{
        contentView.frame = RECT(0, SCREEN_HEIGHT, SCREEN_WIDTH, 180);
    }  completion:^(BOOL finished) {
        if (mainView) {
            mainView.accessibilityElementsHidden = NO;
        }
        [shadowView removeFromSuperview];
        [contentView removeFromSuperview];
    }];
}
+ (void)UMENGShareWithTitle:(NSString *)title
           description:(NSString *)description
        shareURLString:(NSString *)shareURLString
         socialPlatformType:(UMSocialPlatformType)socialPlatformType {
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject
                                         shareObjectWithTitle:title
                                         descr:description
                                         thumImage:[UIImage imageNamed:@"AppIcon"]];
    shareObject.webpageUrl = shareURLString;
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:socialPlatformType
                                        messageObject:messageObject
                                currentViewController:MainWindow.rootViewController
                                           completion:^(id data, NSError *error) {
                                               NSLog(@"dd%@",error);
                                               if (error) {
                                                   UMSocialLogInfo(@"************Share fail with error %@*********",error);
                                               }else {
                                                   if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                                                       UMSocialShareResponse *resp = data;
                                                       //分享结果消息
                                                       UMSocialLogInfo(@"response message is %@",resp.message);
                                                       //第三方原始返回的数据
                                                       UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                                                   }else {
                                                       UMSocialLogInfo(@"response data is %@",data);
                                                   }
                                               }
                                               NSString *result = nil;
                                               if (!error) {
                                                   result = [NSString stringWithFormat:@"分享成功"];
                                               }else {
                                                   result = [NSString stringWithFormat:@"分享失败"];
                                               }
//                                               HUD(result);
                                               [KJCommonUI showAlertViewWithTitle:result message:nil cancelButtonTitle:nil sureButtonTitle:@"确定" inViewController:MainWindow.rootViewController cancelBlock:nil sureBlock:^{
//                                                   [[NSNotificationCenter defaultCenter] postNotificationName:SHARE_FINISH object:nil userInfo:nil];
                                               }];
    }];
}

+ (void)wxShare:(int)scene
          title:(NSString *)title
    description:(NSString *)description
            url:(NSString *)url {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    [message setThumbImage:IMAGE(@"120")];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = url;
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}
@end
