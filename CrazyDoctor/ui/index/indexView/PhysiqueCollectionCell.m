//
//  PhysiqueCollectionCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PhysiqueCollectionCell.h"

@implementation PhysiqueCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)renderPhysiqueCollectionCellWithTitle:(NSString *)title item:(NSInteger)item{
    [self.classifyLogoTitleBtn setTitle:title forState:UIControlStateNormal];
//    bg_homepage_yellow@2x
    if (item == 0) {
        self.classifyLogoImgView.image = [UIImage imageNamed:@"bg_homepage_red"];
    }else if (item == 1){
        self.classifyLogoImgView.image = [UIImage imageNamed:@"bg_homepage_brownness"];
    }else{
        self.classifyLogoImgView.image = [UIImage imageNamed:@"bg_homepage_yellow"];
    }
}

@end
