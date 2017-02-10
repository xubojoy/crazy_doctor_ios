//
//  MyDiagnosticsEyeCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#define kControllerHeaderViewHeight                90
#define kControllerHeaderToCollectionViewMargin    0
#define kCollectionViewCellsHorizonMargin          2
#define kCollectionViewCellHeight                  25
#define kCollectionViewItemButtonImageToTextMargin 5

#define kCollectionViewToLeftMargin                16
#define kCollectionViewToTopMargin                 0
#define kCollectionViewToRightMargin               16
#define kCollectionViewToBottomtMargin             10
//
#define kCellImageToLabelMargin                    10
#define kCellBtnCenterToBorderMargin               10

#import <UIKit/UIKit.h>
#import "DiagnoseLog.h"
#import "SectionHeaderViewCollectionReusableView.h"

#import "UICollectionViewLeftAlignedLayout.h"
#import "CollectionViewCell.h"

@interface MyDiagnosticsEyeCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (weak, nonatomic) IBOutlet UILabel *remindLabel;


@property (weak, nonatomic) IBOutlet UIView *downLine;


@property (strong, nonatomic) UICollectionView *myDiagnosticsEyeCollectionView;

@property (nonatomic ,strong) DiagnoseLog *diagnoseLog;
@property (nonatomic ,strong) NSMutableArray *tagsArray;

- (void)renderMyDiagnosticsEyeCellWithDiagnoseLog:(DiagnoseLog *)diagnoseLog;

@end
