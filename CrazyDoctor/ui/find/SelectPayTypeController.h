//
//  SelectPayTypeController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/1.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayProcessor.h"
@interface SelectPayTypeController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic, strong) PaymentType *paymentType;
@property (nonatomic ,strong) NSString *type;

- (instancetype)initWithFromType:(NSString *)type;

@end
