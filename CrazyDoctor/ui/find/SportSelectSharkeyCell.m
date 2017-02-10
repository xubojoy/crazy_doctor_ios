//
//  SportSelectSharkeyCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/22.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportSelectSharkeyCell.h"

@implementation SportSelectSharkeyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)renderSportSelectSharkeyCell:(Sharkey *)sharkey{
    self.sharkeyNameLabel.text = sharkey.modelName;
    self.sharkeyModelNameLabel.text = sharkey.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
