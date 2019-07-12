//
//  InterfaceHeader.h
//  KrvisionHelper
//
//  Created by 视氪  on 2018/4/8.
//  Copyright © 2018年 shike. All rights reserved.
//

#ifndef InterfaceHeader_h
#define InterfaceHeader_h
/// 分页页面大小
#define COMMON_PAGE_SIZE                @5
/// 分页页面大小
#define ONEQUEST_PAGE_SIZE              @0
/// 短信验证码 type 2
#define CODE_TYPE_INTERFACE             2
/// 当前手机版本号
#define USER_MOBILE_SYSTEM_INTERFACE    @"user_mobile_system"
/// 设备号 device token
#define USER_MOBILE_TOKEN_INTERFACE     @"user_mobile_token"
#define MOBILE_TYPE                     @"mobile_type"
/// APP的版本号
#define VISION_INTERFACE                @"version"
/// 时间戳
#define TIMESTAMP_INTERFACE             @"timestamp"
/// 手机类型
#define REQUEST_PHONE_SYSTEM_TYPE       @"iOS"
/// 域 测试服
//#define ROOT_URL                        @"http://testforkrcircle.hz.taeapp.com"
/// 正式服
#define ROOT_URL                        @"http://krcircle6.hz.taeapp.com/"
// 登录
#define LOGIN_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleLogin/"]
// 顽兔
#define WANTU_TOKEN_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadWantuToken/"]
// 获取验证码
#define SEND_CODE_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleSendMessage/"]
// 注册
#define REGISTER_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleRegister/"]
// 上传token
#define UPDATE_DEVICE_TOKEN_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUpdateMobileToken/"]
// 退出登录
#define LOGOUT_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleLogout/"]
// 发布需求
#define SEND_NEED_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadUserDemand/"]

// 项目分类
#define PROJECT_CLASS_LIST_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadProjectClassList/"]
// 最新版本
#define APP_VERSION_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadAppVersion/"]
// 首页列表
#define HOME_LIST_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadProjectOrDemandList/"]
// 项目支持
#define PROJECT_THUMBUP_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadThumbupProject/"]
// 需求点赞
#define DEMAND_THUMBUP_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadThumbupDemand/"]
//
#define PROJECT_DETAIL_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadProjectDetail/"]
//
#define PROJECT_ACCESS_LIST_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadProjectComment/"]
// 功能详情查询
#define FUNCTION_DETAIL_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadProjectFunctionDetail/"]
// 发表项目评论
#define PROJECT_ACCESS_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadProjectSecondComment/"]
// 项目详情（评论）
#define NEED_DETAIL_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadDemandComment/"]
// 评论一个需求
#define NEED_ACCESS_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadDemandSecondComment/"]
// 品质专区
#define GOODS_LIST_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadGoodsList/"]
// 品质详情
#define GOODS_DETAIL_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadGoodsDetail/"]
// 品质专区功能详情
#define FUNCTION_GOODS_DETAIL_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadGoodsFunctionDetail/"]
// 品质专区评价列表
#define GOODS_ACCESS_LISG_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadGoodsComment/"]
// 阿里支付
#define PAY_ALI_ORDER_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleSignAliPay/"]
// 微信第一次签名
#define PAY_WX_ORDER_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleSignWechatPay/"]
// 微信第二次签名
#define PAY_WX_ORDER_SECOND_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleSignPrepayidWechatPay/"]
// 支付结果查询
#define PAY_ORDER_CHECK_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleQueryPayOrder/"]
// 查询我的需求 支持项目
#define MY_PROJECT_NEEDS_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadUserProjectOrDemand/"]
// 帮助列表
#define HELP_LIST_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadHelpList/"]
// 帮助反馈
#define HELP_FEEDBACK_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadUserFeedback/"]
// 帮助详情
#define HELP_DETAIL_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadHelpDetail/"]
// 订单列表
#define ORDER_LIST_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadUserOrder/"]
// 订单评价
#define ORDER_ACCESS_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadOrderComment/"]
// 订单评价
#define GOODS_ACCESS_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadGoodsSecondComment/"]
// 确认收货
#define ORDER_SURE_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadReceiveOrder/"]
// 我的消息
#define SYSTEM_NEWS_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadSystemMessage/"]
// 项目需求搜索
#define PROJECT_SEARCH_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadProjectOrDemandKeyword/"]
// 商品搜索
#define GOODS_SEARCH_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadGoodsKeyword/"]
// 商品下单信息
#define GOODS_ORDER_BUY_INFO_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadGoodsOrderInformation/"]
// 商品下单信息
#define PROJECT_PROGRESS_DETAIL_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadProjectProgressDetail/"]
// 阅读消息
#define READ_NEWS_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleUploadSystemMessageReadStatus/"]


// ***************************************6.0.0*************************************//

// 用户信息
#define USER_INFO_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleDownloadUserData/"]
/// 无障碍资讯列表
#define DOWNLOAD_NEWS_LIST_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadNewsList/"]
/// 无障碍资讯详情
#define DOWNLOAD_NEWS_DETAIL_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadNewsDetail/"]
/// 无障碍资讯详情评论
#define DOWNLOAD_NEWS_DETAIL_COMMENT_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadNewsComment/"]
/// 上传无障碍资讯详情评论
#define UPLOAD_NEWS__COMMENT_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleUploadNewsComment/"]
/// 上传无障碍资讯详情评论
#define UPLOAD_ZAN_NEWS_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleUploadNewsThumbup/"]
/// 视氪听听版块
#define DOWNLOAD_TUTORIA_BLOCk_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadTutorialBlockList/"]
/// 视氪听听版块-普通
#define DOWNLOAD_COURSE_LIST_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadOrdinaryTutorialCourseList/"]
/// 视氪听听版块-推荐
#define DOWNLOAD_COURSE_LIST_RECOMMENT_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadRecommendTutorialCourseList/"]
/// 视氪听听-课程详情
#define DOWNLOAD_COURSE_DETAIL_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadTutorialCourseDetail/"]
/// 视氪听听-课程详情列表
#define DOWNLOAD_COURSE_DETAIL_LIST_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadTutorialCourseHour/"]
/// 视氪听听-课程订阅
#define COURSE_BOOK_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleUploadTutorialCourseSubscribe/"]
/// 视氪听听-课程打赏
#define COURSE_EXCEPTIONAL_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleUploadTutorialCourseReward/"]
/// 视氪听听-课程播放
#define COURSE_PLAY_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleUploadTutorialCoursePlay/"]
/// 我的点赞
#define DOWNLOAD_MY_ZAN_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadUserThumbupNewsList/"]
/// 我的订阅
#define DOWNLOAD_MY_BOOK_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadUserSubscribeCourseList/"]
/// 我的创作
#define DOWNLOAD_MY_CREATE_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleDownloadUserCreateCourseList/"]
// 更新头像
#define UPDATE_IMAGE_HEAD_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUpdateUserImageUrl/"]
// 更新昵称
#define UPDATE_NICKNAME_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUpdateUserNickname/"]
// 更新性别
#define UPDATE_SEX_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUpdateUserSex/"]
// 更新性别
#define UPLOAD_SIGN_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUploadUserSignIn/"]
// 更新位置
#define UPLOAD_LOCATION_INTERFACE                            [ROOT_URL stringByAppendingString:@"/KrcircleUpdateUserRegion/"]
// 分享
#define UPLOAD_SHARE_METHOD_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleUploadUserShare/"]
// 资讯搜索
#define NEWS_KEYWORD_INTERFACE [ROOT_URL stringByAppendingString:@"/KrcircleSearchNewsKeyword/"]
#endif /* InterfaceHeader_h */
