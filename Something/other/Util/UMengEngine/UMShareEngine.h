//
//  UMShareEngine.h
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/5/11.
//  Copyright © 2018年 shike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>
@interface UMShareEngine : NSObject

#define UMENG_KEY                       @"5ae416eaf43e4803ed0000bb"
#define AMAP_KEY                        @"9bf1f2ef86400be931f038f6ab012a76"
#define QQ_KEY                          @"1106136855"
#define WE_CHAT_KEY                     @"wxc5cffcd929280839"
#define WE_CHAT_SECRET                  @"b5673bf341bf722f52273fa62a9fc308"

+ (void)UMENGKey;
+ (void)QQKey;
+ (void)WXKey;
+ (void)WBKey:(NSString *)key appSecret:(NSString *)appSecret;
+ (void)shareWithTitle:(NSString *)title
           description:(NSString *)description
        shareURLString:(NSString *)shareURLString;

/**
 1、微信 2、朋友圈 3、QQ 4、控件

 @param title title
 @param description description
 @param shareURLString shareURLString
 @param type type
 */
+ (void)shareWithTitle:(NSString *)title
           description:(NSString *)description
        shareURLString:(NSString *)shareURLString
                  type:(int)type;

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
                   tel:(void(^)(BOOL isTEL))tel;
@end
