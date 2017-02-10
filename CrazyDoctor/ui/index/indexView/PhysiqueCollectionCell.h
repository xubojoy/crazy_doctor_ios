//
//  PhysiqueCollectionCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhysiqueCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *classifyLogoImgView;

@property (weak, nonatomic) IBOutlet UIButton *classifyLogoTitleBtn;

- (void)renderPhysiqueCollectionCellWithTitle:(NSString *)title item:(NSInteger)item;

@end
