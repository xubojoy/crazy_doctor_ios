//
//  UserCenterViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/3/31.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoView.h"
#import "UserCenterCommonCell.h"
#import "UserLoginViewController.h"
#import <MessageUI/MessageUI.h>
@interface UserCenterViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UserInfoViewDelegate,MFMailComposeViewControllerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UIButton *rightSettingBtn;
@property (nonatomic ,strong) UserInfoView *userInfoView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UserLoginViewController *userLoginvc;

@property (nonatomic, assign) BOOL isShowMyInfo;
@end
