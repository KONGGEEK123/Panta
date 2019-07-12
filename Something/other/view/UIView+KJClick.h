//
//  UIView+KJClick.h
//  KJButtonClick
//
//  Created by 王亚振 on 2017/9/15.
//  Copyright © 2017年 空级科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KJTapClickBlock)(void);

@interface UIView (KJClick)

@property (copy, nonatomic) KJTapClickBlock tapClickBlock;

@end
