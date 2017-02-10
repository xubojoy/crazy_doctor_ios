//
//  MyArchivesViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSegmentView.h"
#import "MyDiagnosticsViewController.h"
#import "MyPhysiotherapyViewController.h"
#import "MyDoctorViewController.h"
#import "OtherHospitalViewController.h"
@interface MyArchivesViewController : BaseViewController<CustomSegmentViewDelegate,MyDoctorViewControllerDelegate,MyPhysiotherapyViewControllerDelegate,OtherHospitalViewControllerDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) CustomSegmentView *customSegmentView;
@property (nonatomic ,strong) NSArray *currentGameStatuses;

@property (nonatomic ,strong) MyDiagnosticsViewController *mdvc;
@property (nonatomic ,strong) MyPhysiotherapyViewController *mpvc;
@property (nonatomic ,strong) MyDoctorViewController *mdoctorvc;
@property (nonatomic ,strong) OtherHospitalViewController *ohvc;
@property (nonatomic ,strong) UIButton *rightAddBtn;

@end
