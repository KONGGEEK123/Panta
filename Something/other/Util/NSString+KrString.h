//
//  NSString+KrString.h
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/4/26.
//  Copyright © 2018年 shike. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KrString)
/**
 是否含有表情
 @return YES||NO
 */
- (BOOL)emoticons;
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
@end
