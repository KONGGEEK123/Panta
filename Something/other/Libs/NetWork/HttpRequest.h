//
//  HttpRequest.h
//  Krnavigation
//
//  Created by KrVision on 2017/12/14.
//  Copyright © 2017年 KrVision. All rights reserved.
//



typedef void (^FinishBlock)(NSString *dataString);

@interface HttpRequest : NSObject<NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSMutableData *resultData;
@property (strong, nonatomic) FinishBlock finishBlock;

+ (void)postRequestWithURL:(NSString *)urlStr
                 paramters:(NSString *)paramters
              finshedBlock:(FinishBlock)block;

@end
