//
//  UMengShareView.m
//  KrvisionNavigation
//
//  Created by 视氪  on 2018/5/11.
//  Copyright © 2018年 shike. All rights reserved.
//

#import "UMengShareView.h"
@interface UMengShareView ()
@property (weak, nonatomic) IBOutlet UIButton *inviteWXFriend;
@property (weak, nonatomic) IBOutlet UIButton *inviteQQFriend;
@property (weak, nonatomic) IBOutlet UIButton *inviteTELFriend;
@property (weak, nonatomic) IBOutlet UILabel *inviteWXLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteQQLabel;
@property (weak, nonatomic) IBOutlet UILabel *inviteTELLabel;
@property (weak, nonatomic) IBOutlet UILabel *wechatShareLabel;
@property (weak, nonatomic) IBOutlet UILabel *QQShareLable;
@property (weak, nonatomic) IBOutlet UILabel *QQZoonLabel;
@property (weak, nonatomic) IBOutlet UILabel *FriendShareLable;
@property (weak, nonatomic) IBOutlet UIButton *WeChatShareButton;
@property (weak, nonatomic) IBOutlet UIButton *QQShareButton;
@property (weak, nonatomic) IBOutlet UIButton *QQZoneShareButton;
@property (weak, nonatomic) IBOutlet UIButton *FriendShareButton;
@end
@implementation UMengShareView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.inviteWXLabel.isAccessibilityElement = NO;
    self.inviteQQLabel.isAccessibilityElement = NO;
    self.inviteTELLabel.isAccessibilityElement = NO;
    self.inviteWXFriend.accessibilityLabel = @"添加微信好友";
    self.inviteQQFriend.accessibilityLabel = @"添加QQ好友";
    self.inviteTELFriend.accessibilityLabel = @"通讯录";
    self.WeChatShareButton.accessibilityLabel = @"微信好友";
    self.QQShareButton.accessibilityLabel = @"QQ好友";
    self.QQZoneShareButton.accessibilityLabel = @"QQ空间";
    self.FriendShareButton.accessibilityLabel = @"朋友圈";
    self.wechatShareLabel.isAccessibilityElement = NO;
    self.QQShareLable.isAccessibilityElement = NO;
    self.QQZoonLabel.isAccessibilityElement = NO;
    self.FriendShareLable.isAccessibilityElement = NO;
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (self.block) {
        self.block([sender tag]);
    }
}

@end
