//
//  VoiceManager.h
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/4/24.
//  Copyright © 2018年 shike. All rights reserved.
//

#import <Foundation/Foundation.h>
/// 当前经纬度回调
typedef void (^VoiceOverBlock)(BOOL isFinish);

@interface VoiceManager : NSObject
@property (strong, nonatomic) VoiceOverBlock voiceFinishBlock;
#pragma mark -
#pragma mark - PRIVITE 初始化方法

+ (VoiceManager *)shareManager;
- (void)initialize;

/**
 文字转语音

 @param string 文字
 */
- (void)speakString:(NSString *)string;

/**
 停止语音
 */
- (void)stopSpeak;

/**
 文字转语音 优先级

 @param string 文字
 @param priority 优先级
 */
- (void)speak:(NSString *)string priority:(int)priority;

/**
 是否打开语音功能

 @param on YES||NO
 */
- (void)openSwitch:(BOOL)on;
/**
 是否正在播报
 */
- (BOOL)isSpeak;
/**
 语音结束回调
 
 @return YES||NO
 */
- (void)isSpeaking:(VoiceOverBlock)complex;
@end
