//
//  RequestResponse.h
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/4/9.
//  Copyright © 2018年 shike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestResponse : NSObject

/**
 错误请求地址

 @return 请求地址为空
 */
+ (RequestResponse *)blankURLRequest;
/**
 网络错误
 
 @return 网络错误
 */
+ (RequestResponse *)badNetworkRequest;
/**
 请求错误 AFNetWorking请求返回错误
 
 @return 请求错误
 */
+ (RequestResponse *)failRequest;

/**
 处理正确接口

 @param responseObject 返回值
 @return model
 */
+ (RequestResponse *)responseWithObject:(id)responseObject;

/**
 返回响应码 系统返回 ：- 1错误 0 正确  这里直接处理成YES 成功 NO 错误
 */
@property (assign, nonatomic) BOOL retCode;
/**
 当前页的容量
 */
@property (assign, nonatomic) NSInteger pageSize;
/**
 所有页数
 */
@property (assign, nonatomic) NSInteger pageTotal;
/**
 当前页码 从 1 开始
 */
@property (assign, nonatomic) NSInteger pageIndex;
/**
 data有效信息层
 */
@property (strong, nonatomic) NSDictionary *data;

/**
 AFNetWorking返回的 responseObject
 */
@property (strong, nonatomic) id responseObject;

/**
 AFNetWorking返回的 responsString
 */
@property (copy, nonatomic) id responsString;

/**
 错误信息
 */
@property (copy, nonatomic) NSString *errorMessage;

@end

