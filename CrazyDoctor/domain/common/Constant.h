//
//  Constant.h
//  styler
//
//  Created by System Administrator on 13-5-10.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "UIImage+imagePlus.h"

#define navigation_height     44
#define status_bar_height     20
#define tabbar_height         51
#define general_margin        15
#define general_cell_height   44
#define reward_activity_banner_height   50
#define general_padding       10
#define general_space         20
#define general_space2         30
#define general_height        40
#define general_height_2      30
#define splite_line_height    0.5
#define main_vc_right_space     83
#define common_height        screen_width*1/2

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#define screen_width          [UIScreen mainScreen].bounds.size.width
#define screen_height          [UIScreen mainScreen].bounds.size.height
#define general_screen_width_320  320
#define main_content_height   [UIScreen mainScreen].bounds.size.height - self.header.frame.size.height
#define bottomY(view)         view.frame.size.height + view.frame.origin.y
#define leftX(view)           view.frame.size.width + view.frame.origin.x
#define IOS6                  ([[[UIDevice currentDevice] systemVersion] floatValue] < 7)?YES:NO
#define IOS7                  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)?YES:NO
#define IOS8                  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)?YES:NO
#define loading_frame         CGRectMake(0, 100, screen_width, 40)
#define red_dot_width          7



//字体大小
#define smallest_font_size  10
#define smaller_font_size   11
#define small_font_size     12
#define default_2_font_size 13
#define default_font_size   14
#define default_1_font_size 15
#define big_font_size       16
#define bigger_1_font_size  17
#define bigger_font_size    18
#define bigger_2_font_size  20
#define biggest_font_size   24
#define default_txt_height  16
//色值
#define black_text_color          @"#333333"
#define gray_text_color           @"#666666"
#define gray_place_holder_color   @"#dcdcdc"
#define orange_text_color         @"#ff532b"
#define white_text_color          @"#ffffff"
#define light_gray_text_color     @"#999999"
#define lighter_gray_text_color   @"#cccccc"
#define lighter_2_gray_color      @"#f0f0f0"
#define backgroud_color           @"#f6f6f6"
#define common_bg_color           @"#f4f4f4"
#define head_backgroud_color      @"#e7523e"
#define searchBar_textField_background_color    @"#F67365"
#define splite_line_color         @"#dddddd"
#define lighter_3_gray_color      @"#cdcdcd"
#define red_color                 @"#cc0000"
#define blue_color                @"#3399ff"
#define red_default_color         @"#ea0000"
#define red_select_color          @"#cc3300"
#define green_background_color    @"#7cc576"
#define light_gray_color          @"#f2f2f2"
#define light_gray_2_color        @"#e5e5e5"
#define green_order_status_backgroud_color  @"#7cc576"
#define gray_order_status_backgroud_color   @"#cccccc"
#define blue_order_status_backgroud_color   @"#90c4f5"
#define orange_order_status_backgroud_color @"#ff9933"
#define common_btn_bg_color       @"#fc9a35"
//#7cbb73
#define common_splite_line_color  @"#eeeeee"
#define green_common_color        @"#49c28d"
#define black_common_color        @"#000000"
#define orange_common_color       @"#ff9900"
#define gray_common_color         @"#f2f2f2"
#define gray_line_color           @"#434343"
#define orange_notifi_color       @"#eb6100"
#define gray_placeholder_color    @"#f5f5f5"
#define common_content_color      @"#333333"
#define gray_color                @"#888888"
#define green_light_color         @"#49c28d"
#define green_dark_color          @"#32946b"
#define service_green_color       @"#7CCC2B"
#define service_blue_color        @"#2B96FA"
#define light_blue_color          @"#cae9dd"

#define deep_green_color          @"#00736d" //墨绿色
#define coffee_color              @"#ac6a00" //咖啡出色
#define header_color              @"#55000000"

#define game_type_green_color     @"#107271"
#define game_type_coffee_color    @"#ab6a1a"
#define game_type_purple_color    @"#666699"
#define unselect_title_color  @"#454545"

#define common_app_text_color     @"#774c22"
#define brown_common_color        @"#603d21"
#define login_select_color        @"#774c22"
#define lighter_brown_color       @"#fdfff5"
#define lighter_2_brown_color     @"#ca7e5c"
#define light_line_colr           @"#9e826b"
#define placeholer_color          @"#bbbbbb"


//绿色＃7cbb73
//黑色＃000000
//橙色＃ff9900

#define account_session_from_index                1
#define account_session_from_court_detail         2
#define account_session_from_my_order_confirm     3
#define account_session_from_club_detail          4
#define account_session_from_commodity_detail     5
#define account_session_from_user_home            6
#define account_session_from_commodity_list       7
#define account_session_from_user_games_list      8
#define account_session_from_user_games_code_list      9
#define account_session_from_user_chati      10
#define account_session_from_user_center      11
#define account_session_from_xuewei_detail      12
#define account_session_from_OrderPhysiotherapy      13
#define account_session_from_user_center_login      14
#define account_session_from_user_tongueDiagnosisTest      15
#define account_session_from_user_diagnosisOnRightEyes      16
#define account_session_from_user_articleDetail      17
#define account_session_from_discover      18



//ArticleDetailController



#define brand_cell_height   100
#define network_timeout     10
#define network_retry_count 1
//网络状态
#define network_unconnect_note      @"网络不通，请检查网络"
#define network_request_fail        @"网络不通，请联网后点击刷新"
#define network_status_loading      @"正在加载..."
#define network_status_cancel       @"正在取消..."
#define network_status_no_more      @"没有更多"
#define network_status_retry        @"网络不通，请重试"
#define network_status_refresh      @"下拉刷新..."
#define network_status_refreshing   @"正在刷新..."

#define common_page_size     20

#define user_common_styler_type  3
#define my_fav_styler_type       2
#define common_styler_type       1

#define tabbar_item_index_jinnang       0
#define tabbar_item_index_check          1
#define tabbar_item_index_discover       2
#define tabbar_item_index_me            3


//通知
#define notification_name_update_user_name                  @"updateNameNotification"
#define notification_name_update_user_avatar                @"updateAvatar"
#define notification_name_update_user_gender                @"updateGenderNotification"
#define notification_name_user_login                        @"userLogin"
#define notification_name_user_order_stylist                @"userOrder"
#define notification_name_session_update                    @"sessionUpdate"
#define notification_name_pn_account_session_from           @"accountSessionFrom"
#define notification_name_log_out                           @"log_out"
#define notification_name_chuandi_club_name                 @"传递球场name"
#define notification_name_refresh_mainVC_city_name                 @"渲染首页城市位置"
#define notification_name_load_mainVC_recommend_club        @"刷新首页推荐球场数据"
#define notification_name_refresh_order_clubvc_city        @"刷新球场预定页城市"
#define notification_name_from_city_list_refresh_mainVC_city_name   @"城市列表返回首页刷新位置"
#define notification_name_user_logout_session             @"logout"



#define account_session_from_project_order_vc      @"预约理疗"
#define account_session_from_doctor_order_vc      @"预约医生"

#define log_event_search_clubs              @"搜索"

#define log_event_gaode_map                 @"查看高德导航"
#define log_event_immediate_order           @"立即预订"
#define log_event_confirm_order             @"确认订单"
#define log_event_cancel_order              @"取消订单"
#define log_event_immediate_pay             @"立即支付"


#define log_event_name_submit_new_name      @"设置新的用户名"
#define log_event_name_submit_new_psw       @"设置新密码"
#define log_event_name_submit_new_gender    @"设置性别"
#define log_event_user_info                 @"修改个人信息"
#define log_event_user_pwd                  @"修改密码"
#define log_event_share_us                  @"分享我们"
#define log_event_service_hot_line          @"在线客服"

#define log_event_user_register             @"用户注册"
#define log_event_user_login                @"用户登录"
#define log_event_user_forget_pwd           @"忘记密码"
#define log_event_user_log_out              @"退出登录"

#define log_event_user_cart                 @"购物车"
#define log_event_setting                   @"设置"


//页面访问

#define page_name_jinnang            @"锦囊"
#define page_name_chati            @"查体"
#define page_name_discover            @"发现"
#define page_name_city_list       @"城市列表"
#define page_name_province_list   @"省份列表"
#define page_name_left_user_vc    @"用户数据"
#define page_name_user_regist     @"注册"
#define page_name_user_login      @"登录"
#define page_name_user_first_login      @"用户首次登录"
#define page_name_user_forget_pwd      @"找回密码"
#define page_name_user_cart       @"用户购物车"
#define page_name_setting         @"设置"

#define page_name_user_center      @"我的"

#define page_name_select_payment    @"选择支付方式"

//在线客服及投诉电话
#define service_hotline       @"4001092080"
#define complaints_hotline    @"13263321017"

#define service_phone_1       @"01085636888"
#define service_phone_2       @"13810255010"

//高德地图key
#define gaode_map_key        @"5e4d085bd6a61776e806db38725d39ae"
#define gaode_static_map_key        @"d8a9533bfa747977704abf6b8ac84a76"
//友盟
#define umeng_app_key        @"570f389367e58e74cd000339"
#define umeng_push_app_key  @"570f389367e58e74cd000339"

#define weixin_developer_id  @"wx8216675fb452a3d6"

//支付
#define weixin_app_id        @"wx15c8b624548493ae"
#define mch_secret_key       @"lkjdsfJKK324JJKsdfk6920HHLdfff33"

//SMSSDK官网公共key  11f231ada2a54
#define share_sms_key     @"11f231ada2a54"
#define share_sms_secret   @"1489fdcd9d3b701f9cc6e89a2bca38fd"

//
#define share_app_key @"11f1e4cc0f254"
#define share_app_secrect @"e53f6db806c8619c4dedae23a51aa220"
//分享文字
#define share_app_title              @"疯狂太医"


#define um_share_app_icon [UIImage loadImageWithImageName:@"logo_1024"]

#define share_to_sina_weibo_key     @"share_to_sina_weibo"
#define binding_sina_weibo_key      @"binding_sina_weibo"
#define binding_wechat_key          @"binding_wechat"
#define binding_qq_key              @"binding_qq"
#define binding_tencent_weibo_key   @"binding_tencent_weibo"

#define APP_ID 1103686449

#define crazy_doctor_app_url @"https://itunes.apple.com/cn/app/feng-kuang-tai-yi/id1103686449?mt=8"


#define kEveryDay @"http://baobab.wandoujia.com/api/v1/feed?num=10&date=%@&vc=67&u=011f2924aa2cf27aa5dc8066c041fe08116a9a0c&v=1.8.0&f=iphone"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kSelfWidth self.frame.size.width
#define kSelfHeight self.frame.size.height

#import <Foundation/Foundation.h>

//订单的几种状态
#define unpay_status          @"unpay"
#define canceled_status       @"canceled"
#define payed_status          @"payed"
#define waitingRefund_status  @"waitingRefund"
#define refunded_status       @"refunded"
#define confirmed_status      @"confirmed"
#define sendGoodsed_status    @"sendGoodsed"
#define completed_status       @"completed"
#define waitingConfirm_status  @"waitingConfirm"

//支付类型
#define TEN_PAYMENT  @"微信支付"
#define ALI_APP_PAYMENT    @"支付宝"
#define ALI_WEB_PAYMENT    @"支付宝网页版"
#define UNION_PAYMENT   @"储蓄卡支付"
#define CREDIT_CARD_PAYMENT  @"信用卡支付"
#define WALLET_PAYMENT @"钱包支付"

//支付type
#define type_recharge @"recharge"//充值
#define type_project  @"project"//理疗项目
#define type_doctor  @"doctor"//预约医生


#define project_order_detail  @"projectOrderDetail"
#define doctor_order_detail  @"doctorOrderDetail"


#define SUB_UNION_PAYMENT_NAME  @"支持各大行储蓄卡，无需开通网银"
#define SUB_WXPAY_PAYMENT_NAME  @"推荐安装微信5.0及以上版本使用"
#define SUB_CREDIT_CARD_PAYMENT_NAME  @"支持多种信用卡，无需开通网银"


#define base_usable_game_coin   1000

//状态机刷新
#define table_view_status_waiting 1 //等待加载状态
#define table_view_status_loading 2 //正在加载状态
#define table_view_status_load_over 3 //加载完成完成
#define table_view_status_load_fail 4 //加载失败

#define event_init_load 0 //初始加载事件
#define event_pull_up 1 //上拉事件
#define event_click_load    2 //点击加载事件
#define event_load_complete_succes 3 //加载成功事件
#define event_load_complete_fail   4 //加载失败事件
#define event_load_complete_over   5 //加载完成事件
#define event_load_data_pull_down  6//下拉事件


typedef enum : NSUInteger {
    from_search_detail = 3,
    from_pay_order = 4,
} CourtFromType;

typedef enum : NSUInteger {
    from_transitiion_vc = 9,
    from_user_club_order_vc = 10,
} PayOrdeType;

typedef enum : NSUInteger {
    from_order = 1,
    from_set_user_info = 5,
    from_pay_order_vc  = 6,
    from_user_club_order_detail = 7,
    from_user_club_order_list = 8,
    from_user_shopping_cart  = 11,
    from_user_commodity_order_detail = 12,
    from_user_commodity_order_list = 15,
    from_commoditys_list = 17,
    from_commodity_detail_vc = 18,
    from_user_game_detail_vc = 19,
    from_user_creat_game_vc = 20,
    from_user_join_game_vc = 21,
    from_user_game_list_vc = 22,
    from_guess_game_vc = 23,
    from_game_code_search_vc = 24,
    from_user_game_record_vc = 25,
} popType;

typedef enum : NSUInteger {
    from_main_vc  = 13,
    from_city_list_vc   = 14,
    from_private_vc = 16
} ProvinceListType;

@interface Constant : NSObject

@property (nonatomic, retain) NSArray *bgColors;

+(Constant *) sharedInstance;
-(UIColor *) getWaterfallBgColor;

+(NSString *)getPriceString:(float)minPrice;

@end
