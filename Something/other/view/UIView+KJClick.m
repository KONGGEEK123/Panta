//
//  UIView+KJClick.m
//  KJButtonClick
//
//  Created by 王亚振 on 2017/9/15.
//  Copyright © 2017年 空级科技. All rights reserved.
//

#import "UIView+KJClick.h"
#import <objc/runtime.h>
static char KTapClickBlock;

@implementation UIView (KJClick)

- (void)setTapClickBlock:(KJTapClickBlock)tapClickBlock {
    objc_setAssociatedObject(self, &KTapClickBlock, tapClickBlock, OBJC_ASSOCIATION_COPY);
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchUpInside)];
    [self addGestureRecognizer:tap];
}
- (KJTapClickBlock)tapClickBlock {
    return objc_getAssociatedObject(self, &KTapClickBlock);
}

#pragma mark -
#pragma mark - INTERFACE

- (void)touchUpInside {
    if (self.tapClickBlock) {
        self.tapClickBlock();
    }
}

@end
