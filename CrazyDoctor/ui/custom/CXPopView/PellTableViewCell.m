//
//  PellTableViewCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "PellTableViewCell.h"

@implementation PellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:light_line_colr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
