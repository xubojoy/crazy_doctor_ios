//
//  UserCenterViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/3/31.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserSettingController.h"
#import "MyCollectionController.h"
#import "MyOrdersController.h"
#import "MyInformationController.h"
#import "MyWalletController.h"
#import "UserStore.h"
#import "AboutUsViewController.h"
#import "SettingUserInfoController.h"
#import "ServiceProtocolController.h"
#import "UserCommonWebController.h"
#import "CrazyDoctorTabbar.h"
#import "AppDelegate.h"
#import "MyArchivesViewController.h"
#import "AppClientStore.h"
#import "SharkeyDetailController.h"
#import "MyCouponViewController.h"
#define isShow   1

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    debugMethod();
    [(AppDelegate*)[UIApplication sharedApplication].delegate tabbar].tabBarController.statusBarStyle = UIStatusBarStyleDefault;
    [UIView setAnimationsEnabled:YES];
    if ([AppStatus sharedInstance].logined) {
//        [self loadSystemInfoData];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSocialView) name:notification_name_user_login object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSocialView) name:notification_name_update_user_name object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSocialView) name:notification_name_update_user_avatar object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadSocialView) name:notification_name_session_update object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    debugMethod();
    [self initUI];
}

- (void)loadSystemInfoData{
    [UserStore getSystemInfo:^(NSDictionary *systemInfoDict, NSError *err) {
        NSLog(@"------%@",systemInfoDict);
        if (systemInfoDict != nil) {
            NSDictionary *dicInfo = [[NSBundle mainBundle] infoDictionary];
            NSString *version = [dicInfo objectForKey:@"CFBundleShortVersionString"];
            NSLog(@"----version--%@",version);
            NSString *infoStr = [NSString stringWithFormat:@"myInfo_%@",version];
            BOOL myInfo = [systemInfoDict[infoStr] boolValue];
            NSLog(@"----self.isShowMyInfo--%d",self.isShowMyInfo);
            self.isShowMyInfo = myInfo;
        }else{
            ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
            [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
        }

    }];
}


#pragma mark - 初始化自定义View
- (void)initUI{
    [self initHeadView];
    [self initUserInfoView];
    [self initTableView];
}

//初始化自定义导航
-(void)initHeadView{
    self.headerView = [[HeaderView alloc] initWithTitle:@"我的" navigationController:self.navigationController];
    self.headerView.backBut.hidden = YES;
    self.headerView.userInteractionEnabled = YES;
    [self.view addSubview:self.headerView];
}

- (void)initRightBtn{
    UILabel *settingLabel = [[UILabel alloc] init];
    settingLabel.text = @"设置";
    settingLabel.font = [UIFont systemFontOfSize:default_font_size];
    settingLabel.frame = CGRectMake(screen_width-settingLabel.realWidth-general_margin, 20, settingLabel.realWidth, 44);
    [self.view addSubview:settingLabel];
    
    self.rightSettingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightSettingBtn.titleLabel.font = [UIFont systemFontOfSize:default_font_size];
    self.rightSettingBtn.frame = CGRectMake(screen_width-150, 20, 150, 44);
    self.rightSettingBtn.backgroundColor = [UIColor clearColor];
    [self.rightSettingBtn addTarget:self action:@selector(rightSettingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rightSettingBtn];
}

- (void)initUserInfoView{
    
    self.userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height+splite_line_height, screen_width, 95)];
    self.userInfoView.backgroundColor = [ColorUtils colorWithHexString:white_text_color];
    self.userInfoView.delegate = self;
    [self.userInfoView renderUserInfoViewWithUser:[AppStatus sharedInstance].user];
    [self.view addSubview:self.userInfoView];

}

- (void)loadSocialView{
    AppStatus *as = [AppStatus sharedInstance];
    NSLog(@">>>>>>>>>>>>>%@",as.user.avatarUrl);
    if (as.logined) {
        [self.userInfoView.userIconImgView sd_setImageWithURL:[NSURL URLWithString:as.user.avatarUrl] placeholderImage:[UIImage imageNamed:@"icon_head_nor"]];
        self.userInfoView.userNameLabel.text = as.user.name;
    }else{
        self.userInfoView.userNameLabel.text = @"登录/注册";
        self.userInfoView.userIconImgView.image = [UIImage imageNamed:@"icon_head_nor"];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
}

//初始化tableview
-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.userInfoView.frame.origin.y+self.userInfoView.frame.size.height, screen_width,screen_height-tabbar_height-self.headerView.frame.size.height-self.userInfoView.frame.size.height) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableViewDelegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 4;
    }else if (section == 2){
        return 2;
    }
    else if (section == 3){
        return 5;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *userCenterCommonCellIdentifier = @"MyUserCenterCommonCell";
    UINib *nib = [UINib nibWithNibName:@"UserCenterCommonCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:userCenterCommonCellIdentifier];
    UserCenterCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:userCenterCommonCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        [cell renderUserCenterCommonCellWithIcon:@"icon_my_order" withTitle:@"我的订单" showLine:NO showRightArrow:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            [cell renderUserCenterCommonCellWithIcon:@"icon_my_collect" withTitle:@"我的收藏" showLine:YES showRightArrow:YES];
        }else if (indexPath.row == 1){
            [cell renderUserCenterCommonCellWithIcon:@"iconfont-mudanganliebiao42" withTitle:@"我的档案" showLine:YES showRightArrow:YES];
            
        }else if(indexPath.row == 2){
            [cell renderUserCenterCommonCellWithIcon:@"icon_my_data" withTitle:@"我的资料" showLine:NO showRightArrow:YES];
        }else{
            [cell renderUserCenterCommonCellWithIcon:@"" withTitle:@"" showLine:NO showRightArrow:NO];
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            [cell renderUserCenterCommonCellWithIcon:@"icon_my_belt" withTitle:@"我的钱包" showLine:YES showRightArrow:YES];
        }else{
            [cell renderUserCenterCommonCellWithIcon:@"icon_my_favorable_privilege" withTitle:@"我的优惠券" showLine:NO showRightArrow:YES];
        }
        
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            [cell renderUserCenterCommonCellWithIcon:@"icon_jguanyu42" withTitle:@"关于英特莱特" showLine:YES showRightArrow:YES];
        }else if (indexPath.row == 1){
            [cell renderUserCenterCommonCellWithIcon:@"iconfont-yonghuxieyi42" withTitle:@"服务协议" showLine:YES showRightArrow:YES];
        }else if(indexPath.row == 2){
            [cell renderUserCenterCommonCellWithIcon:@"icon_changjainwenti42" withTitle:@"常见问题" showLine:YES showRightArrow:YES];
        }else if (indexPath.row == 3){
            [cell renderUserCenterCommonCellWithIcon:@"icon_my_question_feedback" withTitle:@"问题反馈" showLine:YES showRightArrow:YES];
        }else{
            [cell renderUserCenterCommonCellWithIcon:@"icon_my_clear_cache_buffer_memory" withTitle:@"清除缓存" showLine:NO showRightArrow:YES];
        }
    }else{
        if ([AppStatus sharedInstance].logined) {
            [cell renderUserCenterCommonCellWithIcon:@"icon_tiuchu42" withTitle:@"退出登录" showLine:NO showRightArrow:YES];
        }else{
            [cell renderUserCenterCommonCellWithIcon:@"" withTitle:@"" showLine:NO showRightArrow:NO];
        }
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 3) {
            return 0;
        }else if (indexPath.row == 2){
//            if (self.isShowMyInfo == isShow) {
                return 50;
//            }else{
//                return 0;
//            }
        }
        else{
            return 50;
        }
    }else if (indexPath.section == 2) {
        return 50;
    }else if (indexPath.section == 4){
        if ([AppStatus sharedInstance].logined) {
           return 50;
        }else{
            return 0;
        }
    }
    else{
        return 50;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if (section != 2) {
        UIView *headerView = [[UIView alloc] init];
        headerView.frame = CGRectMake(0, 0, screen_width, general_padding);
        headerView.backgroundColor = [ColorUtils colorWithHexString:common_bg_color];
        return headerView;
//    }else{
//        return nil;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section != 2) {
      return 10;
//    }else{
//        return 0;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (![[AppStatus sharedInstance] logined]) {
            UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_center_login];
            [self.navigationController pushViewController:ulc animated:YES];
            return ;
        }else{
            NSString *url = [NSString stringWithFormat:@"%@/myOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0&orderType=projects",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
            
            MyOrdersController *mcvc = [[MyOrdersController alloc] initWithUrl:url];
            [self.navigationController pushViewController:mcvc animated:YES];
        }
       
    }else if (indexPath.section == 1) {
        if (![[AppStatus sharedInstance] logined]) {
            UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_center_login];
            [self.navigationController pushViewController:ulc animated:YES];
            return ;
        }else{
            if (indexPath.row == 0) {
                MyCollectionController *mcvc = [[MyCollectionController alloc] init];
                [self.navigationController pushViewController:mcvc animated:YES];
            }else if (indexPath.row == 1){
                MyArchivesViewController *macv = [[MyArchivesViewController alloc] init];
                [self.navigationController pushViewController:macv animated:YES];
                
            }else if (indexPath.row == 2){
                NSString *url = [NSString stringWithFormat:@"%@/myInfo?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
                UserCommonWebController *ucwvc = [[UserCommonWebController alloc] initWithUrl:url];
                [self.navigationController pushViewController:ucwvc animated:YES];
            }
            else if (indexPath.row == 3){
                NSString *url = [NSString stringWithFormat:@"%@/mySpecialOrders?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
                UserCommonWebController *ucwvc = [[UserCommonWebController alloc] initWithUrl:url];
                [self.navigationController pushViewController:ucwvc animated:YES];
            }else{
                MyInformationController *mcvc = [[MyInformationController alloc] init];
                [self.navigationController pushViewController:mcvc animated:YES];
            }
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
             NSString *url = [NSString stringWithFormat:@"%@/about?noHeaderFlag=0&isAppOpen=1&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl];
            AboutUsViewController *auvc = [[AboutUsViewController alloc] initWithUrl:url title:@"关于英特莱特"];
            [self.navigationController pushViewController:auvc animated:YES];
        }else if (indexPath.row == 1){
            NSString *url = [NSString stringWithFormat:@"%@/protocol?noHeaderFlag=0&isAppOpen=1&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl];
            ServiceProtocolController *auvc = [[ServiceProtocolController alloc] initWithUrl:url titleStr:@"服务协议"];
            [self.navigationController pushViewController:auvc animated:YES];
        }else if (indexPath.row == 2){
            NSString *url = [NSString stringWithFormat:@"%@/questions?Authorization=%@&isAppOpen=1&noHeaderFlag=0&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
            ServiceProtocolController *auvc = [[ServiceProtocolController alloc] initWithUrl:url titleStr:@"常见问题"];
            [self.navigationController pushViewController:auvc animated:YES];
        }else if (indexPath.row == 3){
            [self launchMailApp];
        }
        else if (indexPath.row == 4){
            [self cleanCache];
        }
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            if (![[AppStatus sharedInstance] logined]) {
                UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_center_login];
                [self.navigationController pushViewController:ulc animated:YES];
                return ;
            }else{
                MyWalletController *mcvc = [[MyWalletController alloc] init];
                [self.navigationController pushViewController:mcvc animated:YES];
            }
        }else{
            if (![[AppStatus sharedInstance] logined]) {
                UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_center_login];
                [self.navigationController pushViewController:ulc animated:YES];
                return ;
            }else{
                NSString *url = [NSString stringWithFormat:@"%@/coupons?Authorization=%@&isAppOpen=1&noHeaderFlag=1&noLocationFlag=0",[AppStatus sharedInstance].wxpubUrl,[AppStatus sharedInstance].user.accessToken];
                MyCouponViewController *mcvc = [[MyCouponViewController alloc] initWithUrl:url];
                [self.navigationController pushViewController:mcvc animated:YES];
            }
        }
        
    }else{
            [self loginOut];
        }

}

-(void)launchMailApp
{
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"first@example.com"];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    //添加抄送
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
    //添加密送
    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    //添加主题
    [mailUrl appendString:@"&subject=my email"];
    //添加邮件内容
    [mailUrl appendString:@"&body=<b>email</b> body!"];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}

- (void)loginOut{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认退出？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //点击取消按钮后控制台打印语句。
    }];
    //实例化确定按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [SVProgressHUD showWithStatus:@"正在退出..." maskType:SVProgressHUDMaskTypeBlack];
        [[UserStore sharedStore] removeSession:^(NSError *err) {
            [SVProgressHUD dismiss];
            if (err == nil) {
                [[NSNotificationCenter defaultCenter] postNotificationName:notification_name_session_update object:nil];
                AppStatus *as = [AppStatus sharedInstance];
                [[NSURLCache sharedURLCache] removeCachedResponseForRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:as.user.avatarUrl]]];// 清除旧的头像缓存
                [as initBaseData];
                [AppStatus saveAppStatus];
                [[UIApplication sharedApplication] cancelAllLocalNotifications];
                //返回tabbar第一个view
                
//                [self.navigationController popToRootViewControllerAnimated:NO];
                 [((AppDelegate *)[UIApplication sharedApplication].delegate).tabbar.tabBarController setTabBarHidden:YES animated:NO];
                [((AppDelegate *)[UIApplication sharedApplication].delegate).tabbar setSelectedIndex:3];
               
            }else{
                ExceptionMsg *exception = [[err userInfo] objectForKey:@"ExceptionMsg"];
                [self.view makeToast:exception.message duration:2.0 position:[NSValue valueWithCGPoint:self.view.center]];
            }
            [AppClientStore updateAppClient];
        } accessToken:[AppStatus sharedInstance].user.accessToken];
        [MobClick event:log_event_user_log_out];
    }];
    //实例化确定按钮
    //向弹出框中添加按钮和文本框
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    //将提示框弹出
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)rightSettingBtnClick:(UIButton *)sender{
    NSLog(@">>>>>>设置>>>");
    UserSettingController *usvc = [[UserSettingController alloc] init];
    [self.navigationController pushViewController:usvc animated:YES];
}

- (void)didUserInfoViewBtnClick:(UIButton *)sender{
    switch (sender.tag) {
        case next_btn_tag:
        {
            NSLog(@">>>>>>next_btn_tag>>>");
            if (![[AppStatus sharedInstance] logined]) {
                UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_center_login];
                [self.navigationController pushViewController:ulc animated:YES];
                return ;
            }else{
                SettingUserInfoController *uivc = [[SettingUserInfoController alloc] init];
                [self.navigationController pushViewController:uivc animated:YES];
            }
        }
            break;
        case connect_hardware_tag:
        {
            NSLog(@">>>>>>connect_hardware_tag>>>");
            if (![[AppStatus sharedInstance] logined]) {
                UserLoginViewController *ulc = [[UserLoginViewController alloc] initWithFrom:account_session_from_user_center_login];
                [self.navigationController pushViewController:ulc animated:YES];
                return ;
            }else{
                SharkeyDetailController *shdvc = [[SharkeyDetailController alloc] init];
                [self.navigationController pushViewController:shdvc animated:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)cleanCache{
    [self.view makeToast:[self getAllCacheData] duration:1.0 position:[NSValue valueWithCGPoint:self.view.center]];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog(@"files :%lu",(unsigned long)[files count]);
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    });
}

- (NSString *)getAllCacheData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    if ([self folderSizeAtPath:documentDirectory] >= 1) {
        return [NSString stringWithFormat:@"%.1f M",[self folderSizeAtPath:documentDirectory]];
    }else{
        return @"缓存已清除";
    }
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

-(NSString *)getPageName
{
    return page_name_user_center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
