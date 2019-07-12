//
//  ImageScanViewController.h
//  Something
//
//  Created by 王亚振 on 2019/7/10.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageScanViewController : BaseViewController

@property (strong, nonatomic) NSArray *imagesURLArray;

+ (void)showImageWithImageURLArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
