//
//  UserUnpaySelectPayTypeController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayProcessor.h"
#import "PopUpView.h"
#import "XbPopView.h"

@interface UserUnpaySelectPayTypeController :  BaseViewController<UITableViewDelegate,UITableViewDataSource,XbPopViewDelegate>

@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) PaymentType *paymentType;
@property (nonatomic ,strong) NSString *orderType;
@property (nonatomic ,assign) int orderId;
@property (nonatomic ,strong) NSString *orderNumber;
@property (nonatomic ,strong) DoctorOrder *doctorOrder;
@property (nonatomic ,strong) ProjectOrder *projectOrder;

@property (nonatomic ,strong) UIButton *confirmBtn;

@property (nonatomic ,assign) BOOL isClick;
@property (nonatomic ,strong) PopUpView *popUpView;
@property (nonatomic ,strong) XbPopView *xbPopView;


- (instancetype)initWithId:(int)orderId orderType:(NSString *)orderType orderNumber:(NSString *)orderNumber;

@end
