//
//  PainLevelCollectionCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/5.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meridian.h"
#import "PainLevelModel.h"
@protocol PainLevelCollectionCellDelegate <NSObject>

- (void)didPainLevelBtnClick:(UIButton *)sender;

@end

@interface PainLevelCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *painLevelSelectBtn;


@property (weak, nonatomic) IBOutlet UILabel *remindLabel;

@property (nonatomic ,assign) id<PainLevelCollectionCellDelegate> delegate;


- (void)renderPainLevelCollectionCellWithTitle:(NSString *)title meridian:(NSString *)meridianRemind brownStr:(NSString *)brownStr;
- (void)cellWithData:(PainLevelModel *)model;

@end
