//
//  RequestResponse.m
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/4/9.
//  Copyright © 2018年 shike. All rights reserved.
//

#import "RequestResponse.h"

@implementation RequestResponse
/**
 错误请求地址
 
 @return 请求地址为空
 */
+ (RequestResponse *)blankURLRequest {
    RequestResponse *response  = [[RequestResponse alloc] init];
    response.retCode = NO;
    response.errorMessage = @"网络异常";
    return response;
}
/**
 网络错误
 
 @return 网络错误
 */
+ (RequestResponse *)badNetworkRequest {
    RequestResponse *response  = [[RequestResponse alloc] init];
    response.retCode = NO;
    response.errorMessage = @"网络异常";
    return response;
}
/**
 请求错误 AFNetWorking请求返回错误
 
 @return 请求错误
 */
+ (RequestResponse *)failRequest {
    RequestResponse *response  = [[RequestResponse alloc] init];
    response.retCode = NO;
    response.errorMessage = @"网络异常";
    return response;
}
+ (RequestResponse *)responseWithObject:(id)responseObject {
    RequestResponse *response  = [[RequestResponse alloc] init];
    response.responseObject = responseObject;
    response.data = responseObject [@"data"];
    response.pageSize = [responseObject [@"page_size"] integerValue];
    response.pageTotal = [responseObject [@"page_total"] integerValue];
    response.pageIndex = [responseObject [@"page_index"] integerValue];
    response.retCode = ![responseObject [@"status"] boolValue];
    NSString *errorMessage = responseObject [@"msg"];
    response.errorMessage = @"网络异常";
    if ([errorMessage isEqualToString:@"exceed page"]) {
        response.retCode = YES;
    }
    if ([errorMessage isEqualToString:@"no user"]) {
        response.errorMessage = @"用户不存在";
    }else if ([errorMessage isEqualToString:@"system error"]) {
        response.errorMessage = @"网络异常";
    }else if ([errorMessage isEqualToString:@"access forbidden"]) {
        response.errorMessage = @"网络异常";
    }else if ([errorMessage isEqualToString:@"no password"]) {
        response.errorMessage = @"请先设置密码";
    }else if ([errorMessage isEqualToString:@"exceed page"]) {
        response.errorMessage = @"已经是最后一页了";
    }else if ([errorMessage isEqualToString:@"already upload daily"]) {
        response.errorMessage = @"你今天已评价过了";
    }else if ([errorMessage isEqualToString:@"already upload"]) {
        response.errorMessage = @"你已评价过了";
    }else if ([errorMessage isEqualToString:@"no problem"]) {
        response.errorMessage = @"该问题不存在";
    }else if ([errorMessage isEqualToString:@"already enrolled"]) {
        response.errorMessage = @"你已经报名了";
    }else if ([errorMessage isEqualToString:@"error password"]) {
        response.errorMessage = @"请输入正确的密码";
    }else if ([errorMessage isEqualToString:@"no password"]) {
        response.errorMessage = @"密码未设置";
    }else if ([errorMessage isEqualToString:@"already saved"]) {
        response.errorMessage = @"already saved";
    }else if ([errorMessage isEqualToString:@"no help"]) {
        response.errorMessage = @"no help";
    }
    return response;
}

@end
