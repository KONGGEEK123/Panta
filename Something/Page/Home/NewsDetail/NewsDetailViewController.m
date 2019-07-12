//
//  NewsDetailViewController.m
//  Something
//
//  Created by 王亚振 on 2019/7/10.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsTableViewCell.h"
#import "ImageScanViewController.h"

@interface NewsDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NewsDetailViewController
{
    NSString *_text;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _text = @"县级公安机关交通管理部门车辆管理所可以办理本行政辖区内低速载货汽车、三轮汽车、摩托车驾驶证业务，以及其他机动车驾驶证换发、补发、审验、提交身体条件证明等业务。条件具备的，可以办理小型汽车、小型自动挡汽车、残疾人专用小型自动挡载客汽车驾驶证业务，以及其他机动车驾驶证的道路交通安全法律、法规和相关知识考试业务。具体业务范围和办理条件由省级公安机关交通管理部门确定。";
}

#pragma mark --
#pragma mark -- PRIVATE SUPPER

- (void)refreshUI {
    self.navigationItem.title = @"正文详情";
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark --
#pragma mark -- DELEGATE <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell showCellWithImageCount:4];
        cell.contentLabel.attributedText = [NewsTableViewCell contentText:_text];
        cell.bottomLineView.hidden = YES;
        cell.imageView1.tapClickBlock = ^{
            [ImageScanViewController showImageWithImageURLArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562757676610&di=fb269f6e3f3338e922e0fe69eb75d515&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ffb63c8cc57bf977754b2c891badf0676358fc53e74af-BnyBi9_fw658",
                                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562757676610&di=fb269f6e3f3338e922e0fe69eb75d515&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ffb63c8cc57bf977754b2c891badf0676358fc53e74af-BnyBi9_fw658",
                                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562757676610&di=fb269f6e3f3338e922e0fe69eb75d515&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ffb63c8cc57bf977754b2c891badf0676358fc53e74af-BnyBi9_fw658",
                                                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562757676610&di=fb269f6e3f3338e922e0fe69eb75d515&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ffb63c8cc57bf977754b2c891badf0676358fc53e74af-BnyBi9_fw658"]];
        };
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [NewsTableViewCell heightWithContentText:_text imageViewCount:4];;
    }
    return 0;
}
@end
