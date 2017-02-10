//
//  CheckIndexController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentView.h"

#import "HomeViewController.h"
#import "CheckTongueDiagnosisController.h"
#import "CheckDiagnosisEyesController.h"
#import "CheckMeridiansRegulationController.h"
#import "Meridian.h"
#import "Acupoint.h"
#import "CheckMeridiansRegulationCell.h"
#import "PainLevelModel.h"
@interface CheckIndexController : BaseViewController<CustomSegmentViewDelegate,CheckTongueDiagnosisControllerDelegate,CheckDiagnosisEyesControllerDelegate,HomeViewControllerDelegate,CheckMeridiansRegulationControllerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) CustomSegmentView *customSegmentView;

@property (nonatomic ,strong) NSArray *currentGameStatuses;
@property (nonatomic ,strong) CheckTongueDiagnosisController *tongueDiagnosisController;
@property (nonatomic ,strong) CheckDiagnosisEyesController *diagnosisEyesController;
@property (nonatomic ,strong) CheckMeridiansRegulationController *meridiansRegulationController;

@property (nonatomic ,strong) UILabel *contentLabel;


@property (nonatomic ,strong) UILabel *remindLabel;
@property (nonatomic ,strong) UIImageView *markImgView;
@property (nonatomic ,strong) UILabel *contentCameraLabel;


@property (nonatomic ,strong) HomeViewController *homevc;


@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) Meridian *meridian;
@property (nonatomic ,strong) Acupoint *acupoint;
@property (nonatomic ,strong) NSMutableArray *meridianArray;
@property (nonatomic ,strong) NSMutableArray *acupointArray;
@property (nonatomic ,assign) NSInteger hour;

@property (nonatomic ,assign) int previousItem;
@property (nonatomic ,assign) int currentItem;

@property (nonatomic ,strong) PainLevelModel *painLevelModel;
@property (nonatomic ,strong) NSMutableArray *modelArray;

@end
