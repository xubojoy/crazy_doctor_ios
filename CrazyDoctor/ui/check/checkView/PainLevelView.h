//
//  PainLevelView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/5.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PainLevelCollectionCell.h"
#import "Meridian.h"
#import "PainLevelModel.h"
@protocol PainLevelViewDelegate <NSObject>

- (void)didainLevelViewPainLevelBtnClick:(UIButton *)sender;

@end

@interface PainLevelView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,PainLevelCollectionCellDelegate>

@property (nonatomic ,strong) UICollectionView *painLevelCollectionView;

@property (weak, nonatomic) IBOutlet UIView *leftLine;

@property (weak, nonatomic) IBOutlet UIView *rightLine;

@property (weak, nonatomic) IBOutlet UIView *downLine;
@property (nonatomic ,strong) Meridian *meridian;

@property (nonatomic ,strong) NSMutableArray *modelArray;
@property (nonatomic ,strong) PainLevelModel *painLevelModel;

@property (nonatomic ,assign) id<PainLevelViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame meridian:(Meridian *)meridian;

@end
