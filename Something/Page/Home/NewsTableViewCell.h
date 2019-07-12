//
//  NewsTableViewCell.h
//  Something
//
//  Created by 王亚振 on 2019/7/10.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewBackgroundH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewW;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
- (void)showCellWithImageCount:(int)count;

/**
 cell高度

 @param text 文本
 @param count 图片数量
 @return 高度
 */
+ (CGFloat)heightWithContentText:(NSString *)text imageViewCount:(int)count;

/**
 动态字符串

 @param text text
 @return 动态
 */
+ (NSMutableAttributedString *)contentText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
