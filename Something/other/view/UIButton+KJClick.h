//
//  UIButton+KJClick.h
//  KJButtonClick
//
//  Created by 王亚振 on 2017/9/15.
//  Copyright © 2017年 空级科技. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KJClickTouchUpInsideBlock)(void);

typedef void (^KJButtonTapBlock)(NSInteger index1,NSInteger index2);

@interface UIButton (KJClick)

@property (copy, nonatomic) KJClickTouchUpInsideBlock touchUpInsideClickBlock;

- (void)partOneTitle:(NSString *)partOneTitle
        partOneColor:(UIColor *)partOneColor
        partTwoTitle:(NSString *)partTwoTitle
        partTwoColor:(UIColor *)partTwoColor
       darkImageName:(NSString *)darkImageName
      lightImageName:(NSString *)lightImageName;
@end
