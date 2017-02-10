//
//  IndexTopView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhysiqueCollectionCell.h"

@protocol IndexTopViewDelegate <NSObject>

- (void)didTongueDiagnosisReadyBtnClick:(UIButton *)sender;

@end

@interface IndexTopView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UICollectionView *physiqueClassifyView;

@property (weak, nonatomic) IBOutlet UIImageView *bgBtnImgView;
@property (weak, nonatomic) IBOutlet UIButton *tongueDiagnosisReadyBtn;

@property (nonatomic ,assign) id<IndexTopViewDelegate> delegate;

@property (nonatomic ,strong) NSArray *classifyArray;

- (id)initWithFrame:(CGRect)frame classifyArray:(NSArray *)array;
@end
