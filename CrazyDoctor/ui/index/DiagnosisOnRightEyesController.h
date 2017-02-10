//
//  DiagnosisOnRightEyesController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/29.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiagnosisOnEyesCell.h"
#import "EyePosition.h"
#import "EyePositionModel.h"
#import "DiagnosisOnEyesSelectCollectionCell.h"
#import "DiagnosisEyesCell.h"
@interface DiagnosisOnRightEyesController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,DiagnosisEyesCellDelegate>
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UILabel *topRemarkLabel;
@property (nonatomic ,strong) UIImageView *rightEyeImgView;

@property (nonatomic ,strong) EyePosition *eyePosition;

@property (nonatomic ,strong) NSMutableArray *eyePositionArray;
@property (nonatomic ,strong) NSMutableArray *eyePositionModelArray;

@property (nonatomic ,strong) NSMutableArray *selectModelArray;

@property (nonatomic ,strong) UILabel *selectTitleLabel;

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UIImageView *eyeSelectIconImgView;

@property (nonatomic ,strong) NSMutableArray *pointIdArray;

- (instancetype)initWithSelectLeftIdArray:(NSMutableArray *)pointIdArray;

@end
