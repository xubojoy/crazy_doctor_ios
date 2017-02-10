//
//  SettingSportTargetController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/15.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingSportTargetController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UILabel *remindLabel;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *targetNumArray;

@property (nonatomic, assign) int currentItem;
@property (nonatomic, assign) int previousItem;
@property (nonatomic ,strong) UILabel *remindTitleLabel;
@end
