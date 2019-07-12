//
//  VoiceManager.m
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/4/24.
//  Copyright © 2018年 shike. All rights reserved.
//

#import "VoiceManager.h"
#import <AVFoundation/AVFoundation.h>
@interface VoiceManager ()<AVSpeechSynthesizerDelegate>
@property (nonatomic, strong, readwrite) AVSpeechSynthesizer *speechSynthesizer;
@property (nonatomic, assign) NSInteger nowPriority;
@end

@implementation VoiceManager
{
    BOOL    _switchOn;
}
#pragma mark -
#pragma mark - PRIVITE 初始化方法

+ (VoiceManager *)shareManager {
    static VoiceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VoiceManager alloc] init];
    });
    return manager;
}
- (void)initialize {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        return;
    }
    // 简单配置一个AVAudioSession以便可以在后台播放声音，更多细节参考AVFoundation官方文档
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:NULL];
    self.speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self.speechSynthesizer setDelegate:self];
    _switchOn = YES;
}

/**
 文字转语音
 
 @param string 文字
 */
- (void)speakString:(NSString *)string {
    NSLog(@"speakString:%@",string);
    if (self.speechSynthesizer) {
        CGFloat valueRate = 6;
        CGFloat valueVolume = 9;
        CGFloat valueTone = 6;
        NSString  *areaString;
        areaString = @"zh-CN";
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:areaString];
        AVSpeechUtterance *aUtterance = [AVSpeechUtterance speechUtteranceWithString:string];
        aUtterance.rate = valueRate / 10.0 * 1;
        aUtterance.pitchMultiplier = valueTone / 10.0 * 1.5 + 0.5; /* 0.5 - 2 */
        aUtterance.volume = valueVolume / 10.0 * 1;
        aUtterance.voice = voice;
        
        //iOS语音合成在iOS8及以下版本系统上语速异常
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
            // iOS7设置为0.25
            aUtterance.rate = 0.25;
        }else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0) {
            // iOS8设置为0.15
            aUtterance.rate = 0.15;
        }
        if ([self.speechSynthesizer isSpeaking]) {
            [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        }
        [self.speechSynthesizer speakUtterance:aUtterance];
    }
}

/**
 停止语音
 */
- (void)stopSpeak {
    if (self.speechSynthesizer) {
        [self.speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}
/**
 是否正在播报
 */
- (BOOL)isSpeak {
    if ([self.speechSynthesizer isSpeaking]) {
        return YES;
    }
    return NO;
}

/**
 文字转语音 优先级
 
 @param string 文字
 @param priority 优先级
 */
- (void)speak:(NSString *)string priority:(int)priority {
    if (!_switchOn) {
        return;
    }
    if(string.length <= 0) {
        return;
    }
    if([VoiceManager shareManager].isSpeak) {
        if((string.length <= 0) || (priority > _nowPriority)) {
            return;
        }
    }
    // 本地文字转语音
    [[VoiceManager shareManager] stopSpeak];
    _nowPriority = priority;
    // 本地文字转语音
    [[VoiceManager shareManager] speakString:string];
}
/**
 是否打开语音功能
 
 @param on YES||NO
 */
- (void)openSwitch:(BOOL)on {
    _switchOn = on;
}

/**
 是否正在语音
 
 @return YES||NO
 */
- (void)isSpeaking:(VoiceOverBlock)complex {
    if([VoiceManager shareManager].isSpeak) {
        self.voiceFinishBlock = complex;
    }
}

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance {
}

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance*)utterance{
    
//    NSLog(@"---开始播放");
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    if (self.voiceFinishBlock) {
        self.voiceFinishBlock(YES);
    }
//    NSLog(@"---完成播放");
}
@end
