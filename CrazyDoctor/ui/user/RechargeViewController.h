//
//  RechargeViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayProcessor.h"
#import "UserAccountRecharge.h"
@interface RechargeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) PaymentType *paymentType;
@property (nonatomic ,strong) UIButton *rechargeBtn;


@property (nonatomic ,assign) float price;
@property (nonatomic ,strong) UserAccountRecharge *userAccountRecharge;
@property (nonatomic ,assign) float balance;
@property (nonatomic ,strong) UITextField *amountTextField;

- (instancetype)initWithAccountBalance:(float)balance;

@end
