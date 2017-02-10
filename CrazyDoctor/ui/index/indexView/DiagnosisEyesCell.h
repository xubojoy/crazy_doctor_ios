//
//  DiagnosisEyesCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/17.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiagnosisEyesCollectionCell.h"
#import "EyePositionModel.h"

@protocol DiagnosisEyesCellDelegate <NSObject>

- (void)didDiagnosisEyesCellBtnClick:(NSMutableArray *)selectedArray;

@end

@interface DiagnosisEyesCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic ,strong) NSMutableArray *modelArray;

@property (nonatomic ,strong) NSMutableArray *selectModelArray;
@property (nonatomic ,assign) id<DiagnosisEyesCellDelegate> delegate;

- (void)renderDiagnosisEyesCell:(NSMutableArray *)modelArray;

@end
