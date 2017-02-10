//
//  MyWalletController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccount.h"
@interface MyWalletController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIImageView *bgImageView;
@property (nonatomic ,strong) UILabel *amountLabel;
@property (nonatomic ,strong) UserAccount *userAccount;

@end
