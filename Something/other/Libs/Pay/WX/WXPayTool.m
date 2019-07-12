//
//  WXPayTool.m
//  litekrnavi
//
//  Created by 王亚振 on 2018/8/23.
//  Copyright © 2018年 KrVision. All rights reserved.
//

#import "WXPayTool.h"
#import "WXApi.h"
@implementation WXPayTool
+ (void)wxPayWithOrderString:(NSDictionary *)data {
//    if (![WXApi isWXAppInstalled]) {
//        SPEAK(@"未安装微信", 0);
//        return;
//    }
//    PayReq *req   = [[PayReq alloc] init];
//    //由用户微信号和AppID组成的唯一标识，用于校验微信用户
//    req.openID = @"wx6e41969f23d5e725";
//    // 商家id，在注册的时候给的
//    req.partnerId = (NSString*)[data objectForKey:@"partnerid"];
//    // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
//    req.prepayId  = (NSString*)[data objectForKey:@"prepayid"];
//    // 根据财付通文档填写的数据和签名
//    req.package  = @"Sign=WXPay";
//    // 随机编码，为了防止重复的，在后台生成
//    req.nonceStr  = (NSString*)[data objectForKey:@"noncestr"];
//    // 这个是时间戳，也是在后台生成的，为了验证支付的
//    NSString * stamp = (NSString*)[data objectForKey:@"timestamp"];
//    req.timeStamp = stamp.intValue;
//    // 这个签名也是后台做的
//    req.sign = (NSString*)[data objectForKey:@"sign"];;
//    //发送请求到微信，等待微信返回onResp
//    [WXApi sendReq:req];
}
@end
