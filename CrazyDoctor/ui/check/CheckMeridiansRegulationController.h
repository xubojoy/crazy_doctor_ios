//
//  CheckMeridiansRegulationController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meridian.h"
#import "Acupoint.h"
#import "PainLevelModel.h"
#import "CheckMeridiansRegulationCell.h"
@protocol CheckMeridiansRegulationControllerDelegate <NSObject>

- (void)didreCheckMeridiansRegulationWithAcupoint:(Acupoint *)acupoint meridian:(Meridian *)meridian;

@end
@interface CheckMeridiansRegulationController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) Meridian *meridian;
@property (nonatomic ,strong) Acupoint *acupoint;
@property (nonatomic ,strong) NSMutableArray *meridianArray;
@property (nonatomic ,strong) NSMutableArray *acupointArray;
@property (nonatomic ,assign) NSInteger hour;

@property (nonatomic ,strong) PainLevelModel *painLevelModel;
@property (nonatomic ,strong) NSMutableArray *modelArray;

@property (nonatomic ,strong) UIImageView *streamerImgView;

@property (nonatomic ,assign) id<CheckMeridiansRegulationControllerDelegate> delegate;

@end
