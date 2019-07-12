//
//  UIButton+KJClick.m
//  KJButtonClick
//
//  Created by 王亚振 on 2017/9/15.
//  Copyright © 2017年 空级科技. All rights reserved.
//

#import "UIButton+KJClick.h"
#import <objc/runtime.h>

static char KTouchUpInsideClickBlock;

@implementation UIButton (KJClick)

- (void)setTouchUpInsideClickBlock:(KJClickTouchUpInsideBlock)touchUpInsideClickBlock {
    objc_setAssociatedObject(self, &KTouchUpInsideClickBlock, touchUpInsideClickBlock, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action:@selector(touchUpInside) forControlEvents:UIControlEventTouchUpInside];
}
- (KJClickTouchUpInsideBlock)touchUpInsideClickBlock {
    return objc_getAssociatedObject(self, &KTouchUpInsideClickBlock);
}

#pragma mark -
#pragma mark - INTERFACE

- (void)touchUpInside {
    if (self.touchUpInsideClickBlock) {
        self.touchUpInsideClickBlock();
    }
}

@end
