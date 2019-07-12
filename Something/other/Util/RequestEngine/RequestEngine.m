//
//  RequestEngine.m
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/4/9.
//  Copyright © 2018年 shike. All rights reserved.
//

#import "RequestEngine.h"

@implementation RequestEngine
/**
 GET 请求
 
 @param urlString 请求地址
 @param params 请求参数
 @param complited 请求回调
 */
+ (void)getCommonRequestWithURLString:(NSString *)urlString
                          params:(NSDictionary *)params
                            complited:(void(^)(RequestResponse *response))complited {
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [requestManager GET:urlString
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    RequestResponse *response = [[RequestResponse alloc] init];
                    response.data = responseObject;
                    if (complited) {
                        complited(response);
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    RequestResponse *response = [RequestResponse failRequest];
                    if (complited) {
                        complited(response);
                    }
                }];
}
/**
 POST 请求
 
 @param urlString 请求地址
 @param params 请求参数
 @param complited 请求回调
 */
+ (void)postRequestWithURLString:(NSString *)urlString
                          params:(NSDictionary *)params
                       complited:(void(^)(RequestResponse *response))complited {
    if ([urlString containsString:@"www.weather.com.cn"]) {
        AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
        requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
        requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        requestManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [requestManager GET:urlString
                 parameters:nil
                    success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        RequestResponse *response = [[RequestResponse alloc] init];
                        response.data = responseObject;
                        if (complited) {
                            complited(response);
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        RequestResponse *response = [RequestResponse failRequest];
                        if (complited) {
                            complited(response);
                        }
                    }];
        return;
    }
    // 请求地址非空判断
    if (urlString.length == 0) {
        if (complited) {
            complited([RequestResponse blankURLRequest]);
        }
        return;
    }
    // 创建请求类
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    requestManager.requestSerializer = [AFJSONRequestSerializer serializer];
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 参数校验
    NSMutableDictionary *requestParams = [RequestEngine paramsCompletedWithParams:params];
    // 发起请求
    NSLog(@"请求地址 %@ \n 请求参数 %@",urlString,requestParams);
    [requestManager POST:urlString
              parameters:requestParams
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSLog(@"请求结果 %@",responseObject);
                     RequestResponse *response = [RequestResponse responseWithObject:responseObject];
                     if (complited) {
                         complited(response);
                     }
                     if (response.retCode) {
                         NSLog(@"请求成功");
                     }else {
                         NSLog(@"请求错误 %@",urlString);
                     }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        RequestResponse *response = [RequestResponse failRequest];
        if (complited) {
            complited(response);
        }
        NSLog(@"地址：%@ 请求失败 状态码 ： %ld 错误信息 ：%@ ",urlString,(long)error.code,error.userInfo);
    }];
    //        }
    //    }];
}
/**
 检测网络 NetWorkStateWifi NetWorkStateWlan NetWorkStateFail
 
 @param complited NetWorkState
 */
+  (void)checkNetWorkState:(void(^)(NetWorkState state))complited {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusUnknown || status == AFNetworkReachabilityStatusNotReachable) {
            if (complited) {
                complited(NetWorkStateFail);
            }
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            if (complited) {
                complited(NetWorkStateWifi);
            }
        }else {
            if (complited) {
                complited(NetWorkStateWlan);
            }
        }
    }];
    // 监听网络
    [manager startMonitoring];
}
/**
 参数整合
 
 @param params 原始参数
 @return 请求参数
 */
+ (NSMutableDictionary *)paramsCompletedWithParams:(NSDictionary *)params {
    if (params == nil) {
        params = [NSDictionary dictionary];
    }
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:params];
//    // access Token Orgin
//    NSString *accessTokenOrgin = [KJCommonMethods valueForKey:ACCESS_TOKEN_ORGIN];
//    if (accessTokenOrgin) {
//        [dictionary setValue:accessTokenOrgin forKey:ACCESS_TOKEN_ORGIN];
//    }
    // 1、时间戳 这里工具类中时间戳转换不合理 比较麻烦
    NSString *timeformatter = @"yyyy-MM-dd HH:mm:ss";
    NSString *timestamp = [[[KJCommonMethods timestampWithTimeString:[KJCommonMethods stringWithDate:[NSDate date] formatter:timeformatter] formatter:timeformatter] componentsSeparatedByString:@"."] firstObject];
    [dictionary setValue:[NSNumber numberWithInteger:[timestamp integerValue]] forKey:TIMESTAMP_INTERFACE];
    // 2、APP版本号
    NSString *vision = [KJCommonMethods version];
    if (vision) {
        [dictionary setValue:vision forKey:VISION_INTERFACE];
    }
    // 3、手机类型
    [dictionary setValue:REQUEST_PHONE_SYSTEM_TYPE forKey:MOBILE_TYPE];
    // 4、access_token_original
    NSString *accessTokenOrgin = @"";
    if ([KJCommonMethods valueForKey:ACCESS_TOKEN_ORGIN]) {
        accessTokenOrgin = [KJCommonMethods valueForKey:ACCESS_TOKEN_ORGIN];
    }
    [dictionary setValue:accessTokenOrgin forKey:@"access_token_original"];
    // accessToken
    NSString *accessToken;
    if (timestamp.length &&
        vision.length) {
        NSString *accessTokenString = [NSString stringWithFormat:@"%@%@%@%@",
                                       accessTokenOrgin,// TOKEN
                                       vision,// VERSION
                                       timestamp,// TIME
                                       REQUEST_PHONE_SYSTEM_TYPE// MOBILE TYPE
                                       ];
        // 加密并做大写处理
        accessToken = [accessTokenString.md5String uppercaseString];
    }
    if (accessToken.length) {
        [dictionary setValue:accessToken forKey:ACCESS_TOKEN];
    }
    return dictionary;
}
@end
