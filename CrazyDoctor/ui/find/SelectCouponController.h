//
//  SelectCouponController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/1.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedEnvelope.h"
#import "CustomEmptyView.h"
@interface SelectCouponController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) RedEnvelope *redEnvelope;
@property (nonatomic ,strong) NSMutableArray *couponArray;
@property (nonatomic ,strong) CustomEmptyView *customEmptyView;
@property (nonatomic ,strong) NSString *type;

- (instancetype)initWithFromType:(NSString *)type;
@end
