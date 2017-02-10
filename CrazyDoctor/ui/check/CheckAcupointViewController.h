//
//  CheckAcupointViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/4.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Acupoint.h"
#import "Meridian.h"
#import "PainLevelView.h"
#import "PainLevelModel.h"
@interface CheckAcupointViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,PainLevelViewDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) Acupoint *acupoint;
@property (nonatomic ,strong) Meridian *meridian;
@property (nonatomic ,strong) PainLevelView *painLevelView;
@property (nonatomic ,strong) UIButton *confirmBtn;
@property (nonatomic,strong) PainLevelModel *selectModel;

@property (nonatomic ,assign) int levelNum;
@property (nonatomic ,strong) UIImageView *streamerImgView;

- (instancetype)initWithAcupoint:(Acupoint *)acupoint meridian:(Meridian *)meridian;
@end
