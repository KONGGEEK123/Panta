 //
//  RequestEngine.h
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/4/9.
//  Copyright © 2018年 shike. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "RequestResponse.h"

typedef enum : NSUInteger {
    NetWorkStateWifi,
    NetWorkStateWlan,
    NetWorkStateFail
} NetWorkState;

@interface RequestEngine : NSObject

/**
 POST 请求

 @param urlString 请求地址
 @param params 请求参数
 @param complited 请求回调
 */
+ (void)postRequestWithURLString:(NSString *)urlString
                          params:(NSDictionary *)params
                       complited:(void(^)(RequestResponse *response))complited;

/**
 检测网络 NetWorkStateWifi NetWorkStateWlan NetWorkStateFail

 @param complited NetWorkState
 */
+  (void)checkNetWorkState:(void(^)(NetWorkState state))complited;
/**
 GET 请求
 
 @param urlString 请求地址
 @param params 请求参数
 @param complited 请求回调
 */
+ (void)getCommonRequestWithURLString:(NSString *)urlString
                               params:(NSDictionary *)params
                            complited:(void(^)(RequestResponse *response))complited;
@end
