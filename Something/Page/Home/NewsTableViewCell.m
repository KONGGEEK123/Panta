//
//  NewsTableViewCell.m
//  Something
//
//  Created by 王亚振 on 2019/7/10.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.headImageView borderWithRadius:25
                             borderWidth:1
                             borderColor:@"999999"];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)showCellWithImageCount:(int)count {
    self.imageView1.hidden = self.imageView2.hidden = self.imageView3.hidden = self.imageView4.hidden = YES;
    if (count == 0) {
        self.imageViewBackgroundH.constant = 0;
    }else if (count == 1) {
        self.imageView1.hidden = NO;
        
        self.imageViewW.constant = 150;
        self.imageViewBackgroundH.constant = 150;
    }else if (count == 2) {
        self.imageView1.hidden = NO;
        self.imageView2.hidden = NO;
        
        CGFloat width = (SCREEN_WIDTH - 25 * 2 - 5 * (count - 1)) / (float)(count * 1.0);
        self.imageViewW.constant = width;
        self.imageViewBackgroundH.constant = width;
    }else if (count == 3) {
        self.imageView1.hidden = NO;
        self.imageView2.hidden = NO;
        self.imageView3.hidden = NO;
        
        CGFloat width = (SCREEN_WIDTH - 25 * 2 - 5 * (count - 1)) / (float)(count * 1.0);
        self.imageViewW.constant = width;
        self.imageViewBackgroundH.constant = width;
    }else if (count == 4) {
        self.imageView1.hidden = NO;
        self.imageView2.hidden = NO;
        self.imageView3.hidden = NO;
        self.imageView4.hidden = NO;
        
        CGFloat width = (SCREEN_WIDTH - 25 * 2 - 5 * (count - 1)) / (float)(count * 1.0);
        self.imageViewW.constant = width;
        self.imageViewBackgroundH.constant = width;
    }
}

/**
 cell高度
 
 @param text 文本
 @param count 图片数量
 @return 高度
 */
+ (CGFloat)heightWithContentText:(NSString *)text imageViewCount:(int)count {
    CGFloat imageHeight = 0;
    if (count == 0) {
        imageHeight = 0;
    }else if (count == 1) {
        imageHeight = 150;
    }else {
        CGFloat width = (SCREEN_WIDTH - 25 * 2 - 5 * (count - 1)) / (float)(count * 1.0);
        imageHeight = width;
    }
    CGFloat textHeight = 0.0;
    textHeight = [NewsTableViewCell heightLabelToFit:[NewsTableViewCell contentText:text]];
    CGFloat totalHeight = 10/*个人区域居上高度*/ +
    50/*个人消息区域高度*/ +
    8/*文字居上高度*/ +
    textHeight +
    10/*图片区域居上高度*/ +
    imageHeight +
    10/*分割线居上高度*/ +
    0.5/*分割线高度*/ +
    50/*底部操作总高度*/;
    return totalHeight;
//    else if (count == 2) {
//        CGFloat width = (SCREEN_WIDTH - 25 * 2 - 5 * (count - 1)) / (float)(count * 1.0);
//        imageHeight = width;
//    }else if (count == 3) {
//        CGFloat width = (SCREEN_WIDTH - 25 * 2 - 5 * (count - 1)) / (float)(count * 1.0);
//        imageHeight = width;
//    }else if (count == 4) {
//        CGFloat width = (SCREEN_WIDTH - 25 * 2 - 5 * (count - 1)) / (float)(count * 1.0);
//        imageHeight = width;
//    }
}

+ (CGFloat)heightLabelToFit:(NSAttributedString *)aString {
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 40, 0)];
    tempLabel.font = FONT(15);
    tempLabel.attributedText = aString;
    tempLabel.numberOfLines = 0;
    [tempLabel sizeToFit];
    CGSize size = tempLabel.frame.size;
    return ceilf(size.height);
}
+ (NSMutableAttributedString *)contentText:(NSString *)text {
    NSMutableAttributedString *mString = [text mutableAttributedString];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 8;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    [mString setAttributes:attributes];
    return mString;
}
@end
