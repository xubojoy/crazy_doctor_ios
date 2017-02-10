//
//  SportSelectSharkeyController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/22.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface SportSelectSharkeyController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CBCentralManagerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (strong , nonatomic) CBCentralManager *manager;//中央设备
@property (nonatomic ,strong) UIView *downLine;
@property (nonatomic ,strong) NSMutableArray *SharkeyArray;
@end
