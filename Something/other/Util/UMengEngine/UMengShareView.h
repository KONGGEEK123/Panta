//
//  UMengShareView.h
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/5/11.
//  Copyright © 2018年 shike. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UMengShareViewBlock)(NSInteger tag);
@interface UMengShareView : UIView
@property (weak, nonatomic) IBOutlet UIButton *titleLabel;
@property (copy, nonatomic) UMengShareViewBlock block;
@end
