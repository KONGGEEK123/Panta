//
//  WanTuManager.m
//  Krnavigationn
//
//  Created by 王亚振 on 2018/6/21.
//  Copyright © 2018年 KrVision. All rights reserved.
//

#import "WanTuManager.h"

@implementation WanTuManager

+ (WanTuManager *)shareAudioRecord {
    static WanTuManager *sharedManagerInstance = nil;
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //获取默认顽兔多媒体实例
        self.albbWantu = [ALBBWantu defaultWantu];
    }
    return self;
}

-(void)uploadRecordToWantu:(NSString *)token data:(NSData *)data {
    ALBBWTUploadDataRequest  *request = [ALBBWTUploadDataRequest new];
    request.content = data;
    request.token = token; //上传必需的凭证token
    request.fileName = @"shaojiawennadddd.aac"; //可选，保存到服务端的文件名
    request.dir = @"/collectPointVideo"; //可选，服务端的路径，以 '/' 开头
    request.customParms = @{@"customFormat": @"aac"}; //开发者可以自定义一些参数
    [self.albbWantu upload:request
      completeHandler:^(ALBBWTUploadResponse *response, NSError *error) {
          NSLog(@"error: %@", error); //如果上传失败，在这里获取错误信息
          NSLog(@"reuestId: %@", response.requestId); //每一次请求的requestId
          NSLog(@"url: %@", response.url); //上传成功后返回的文件url
      }];
}

-(void)getWantuToken:(NSData *)data {
    @weakify(self);
    [RequestEngine postRequestWithURLString:WANTU_TOKEN_INTERFACE
                                     params:nil
                                  complited:^(RequestResponse *response) {
                                      if (response.retCode) {
                                          [weak_self uploadRecordToWantu:(NSString*)[response.data objectForKey:@"token"] data:data];
                                      }
                                  }];
}
/**
 文件 名称 dir
 
 @param data data
 @param fileName fileName
 @param dir dir
 */
- (void)uploadData:(NSData *)data fileName:(NSString *)fileName dir:(NSString *)dir completed:(void(^)(NSString *URLString))completed {
    @weakify(self);
    [RequestEngine postRequestWithURLString:WANTU_TOKEN_INTERFACE params:nil complited:^(RequestResponse *response) {
        if (response.retCode) {
            NSString *token = (NSString*)[response.data objectForKey:@"token"];
            if (!token) {
                return ;
            }
            ALBBWTUploadDataRequest  *request = [ALBBWTUploadDataRequest new];
            request.content = data;
            request.token =  token;
            request.fileName = fileName;
            request.dir = dir;
            [weak_self.albbWantu upload:request
                   completeHandler:^(ALBBWTUploadResponse *response, NSError *error) {
                       NSLog(@"error: %@", error);
                       NSLog(@"reuestId: %@", response.requestId);
                       NSLog(@"url: %@", response.url);
                       NSString *urlstring = response.url;
                       if (completed) {
                           completed(urlstring);
                       }
                   }];
        }
    }];
}
@end
