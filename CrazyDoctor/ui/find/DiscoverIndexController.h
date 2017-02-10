//
//  DiscoverIndexController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverIndexCell.h"
@interface DiscoverIndexController : BaseViewController<UITableViewDelegate, UITableViewDataSource,DiscoverIndexCellDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isShowMyInfo;
@end
