//
//  HomeViewController.m
//  Something
//
//  Created by 王亚振 on 2019/7/10.
//  Copyright © 2019 cn.krvision. All rights reserved.
//

#import "HomeViewController.h"
#import "MineViewController.h"
#import "NewsDetailViewController.h"
#import "ImageScanViewController.h"

#import "NewsTableViewCell.h"
@interface HomeViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (strong, nonatomic) UISegmentedControl *segment;
@property (strong, nonatomic) UITableView *tableView1;
@property (strong, nonatomic) UITableView *tableView2;

@property (assign, nonatomic) int pageIdnex;
@end

@implementation HomeViewController
{
    NSArray *_textArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _textArray = @[@"2016年4月1日公安部公布了最新修订的《机动车驾驶证申领和使用规定》，新交通规则严格了对驾驶员的管理。最新交通法规扣分细则也更为严格，闯红灯交通违法记分将由3分提高到6分，不挂号牌或遮挡号牌的一次就将扣光12分。",
                   @"《公安部关于修改<机动车驾驶证申领和使用规定>的决定》已经公安部部长办公会议通过，自2016年4月1日起施行。其中道路交通安全违法行为记分分值规定如下（附件四）：",
                   @"县级公安机关交通管理部门车辆管理所可以办理本行政辖区内低速载货汽车、三轮汽车、摩托车驾驶证业务，以及其他机动车驾驶证换发、补发、审验、提交身体条件证明等业务。条件具备的，可以办理小型汽车、小型自动挡汽车、残疾人专用小型自动挡载客汽车驾驶证业务，以及其他机动车驾驶证的道路交通安全法律、法规和相关知识考试业务。具体业务范围和办理条件由省级公安机关交通管理部门确定。",
                   @"车辆管理所办理机动车驾驶证业务，应当依法受理申请人的申请，审核申请人提交的材料。对符合条件的，按照规定的标准、程序和期限办理机动车驾驶证。对申请材料不齐全或者不符合法定形式的，应当一次书面告知申请人需要补正的全部内容。对不符合条件的，应当书面告知理由。"];
}

#pragma mark --
#pragma mark -- PRIVATE SUPPER

- (void)refreshUI {
    self.navigationItem.leftBarButtonItem = nil;
    self.view.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.segment = [[UISegmentedControl alloc] initWithItems:@[@"盘 他",@"盘 了"]];
    [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:COLOR_333333],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16],NSFontAttributeName ,nil];
    self.segment.tintColor = [UIColor colorWithHexString:@"666666"];
    [self.segment setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.segment.bounds = RECT(0, 0, 100, 30);
    [self.segment setWidth:50 forSegmentAtIndex:0];
    [self.segment setWidth:50 forSegmentAtIndex:1];
    self.segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segment;
    
    [self.pageScrollView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    self.pageScrollView.contentSize = SIZE(SCREEN_WIDTH * 2, [self.pageScrollView getHeight]);
    self.pageScrollView.showsVerticalScrollIndicator = NO;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.delegate = self;
    self.pageScrollView.scrollEnabled = NO;
    self.pageScrollView.backgroundColor = [UIColor clearColor];
    
    CGFloat navHeight = 0;
    if (KiPhoneX) {
        navHeight = 68 + 49;
    }else {
        navHeight = 44 + 49;
    }
    for (int i = 0; i < 2; i ++) {
        CGRect rect = RECT(
                                   [self.pageScrollView getWidth] * i,
                                   0,
                                   [self.pageScrollView getWidth],
                                   [self.pageScrollView getHeight] - navHeight);
        UITableView *tableView = [[UITableView alloc] initWithFrame:rect];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [self.pageScrollView addSubview:tableView];
        
        if (i == 0) {
            self.tableView1 = tableView;
        }else {
            self.tableView2 = tableView;
        }
    }
    
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe1.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe1];
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe2.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipe2];
}

#pragma mark --
#pragma mark -- DELEGATE <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell showCellWithImageCount:(int)indexPath.row + 1];
    cell.contentLabel.attributedText = [NewsTableViewCell contentText:_textArray [indexPath.row]];
    cell.imageView1.tapClickBlock = ^{
        [ImageScanViewController showImageWithImageURLArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562757676610&di=fb269f6e3f3338e922e0fe69eb75d515&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ffb63c8cc57bf977754b2c891badf0676358fc53e74af-BnyBi9_fw658",
                                                              @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562757676610&di=fb269f6e3f3338e922e0fe69eb75d515&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ffb63c8cc57bf977754b2c891badf0676358fc53e74af-BnyBi9_fw658",
                                                              @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562757676610&di=fb269f6e3f3338e922e0fe69eb75d515&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ffb63c8cc57bf977754b2c891badf0676358fc53e74af-BnyBi9_fw658",
                                                              @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1562757676610&di=fb269f6e3f3338e922e0fe69eb75d515&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Ffb63c8cc57bf977754b2c891badf0676358fc53e74af-BnyBi9_fw658"]];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [NewsTableViewCell heightWithContentText:_textArray [indexPath.row] imageViewCount:(int)indexPath.row + 1];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailViewController *vc = [[NewsDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --
#pragma mark -- INTERFACE

- (void)segmentAction:(UISegmentedControl *)segment {
    if (segment.selectedSegmentIndex == 0) {
        
    }else {
        
    }
    [self.pageScrollView setContentOffset:POINT([self.pageScrollView getWidth] * segment.selectedSegmentIndex, 0) animated:YES];
    self.pageIdnex = (int)segment.selectedSegmentIndex;
}

- (void)swipe:(UISwipeGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (gesture.direction == UISwipeGestureRecognizerDirectionLeft) {
            if (self.pageIdnex == 0) {
                self.pageIdnex = 1;
                self.segment.selectedSegmentIndex = 1;
                [self.pageScrollView setContentOffset:POINT([self.pageScrollView getWidth] * self.pageIdnex, 0) animated:YES];
            }
        }else if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
            if (self.pageIdnex == 1) {
                self.pageIdnex = 0;
                self.segment.selectedSegmentIndex = 0;
                [self.pageScrollView setContentOffset:POINT([self.pageScrollView getWidth] * self.pageIdnex, 0) animated:YES];
            }
        }
    }
}

@end
