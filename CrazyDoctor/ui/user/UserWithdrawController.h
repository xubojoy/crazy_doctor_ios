//
//  UserWithdrawController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserWithdrawController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIButton *withDrawBtn;

@property (nonatomic ,assign) float withDrawPrice;
@property (nonatomic ,strong) NSString *accountStr;
@property (nonatomic ,strong) NSString *nickNameStr;
@property (nonatomic ,assign) float balance;

- (instancetype)initWithWithdrawAccountBalance:(float)balance;
@end
