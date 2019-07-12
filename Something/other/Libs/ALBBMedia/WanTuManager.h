//
//  WanTuManager.h
//  Krnavigationn
//
//  Created by 王亚振 on 2018/6/21.
//  Copyright © 2018年 KrVision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ALBBMediaService/ALBBWantu.h>
#import <UIKit/UIKit.h>
@interface WanTuManager : NSObject

/**
 *  顽兔实例
 */
@property (nonatomic, retain) ALBBWantu *albbWantu;

+ (WanTuManager *)shareAudioRecord;

/**
 *  上传到顽兔
 */
-(void)getWantuToken:(NSData*)data ;

/**
 文件 名称 dir

 @param data <#data description#>
 @param fileName <#fileName description#>
 @param dir <#dir description#>
 */
- (void)uploadData:(NSData *)data
          fileName:(NSString *)fileName
               dir:(NSString *)dir
         completed:(void(^)(NSString *URLString))completed;
@end
