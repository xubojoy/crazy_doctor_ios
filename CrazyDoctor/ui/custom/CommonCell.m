//
//  CommonCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CommonCell.h"

@implementation CommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
}

- (void)renderCommonCellWithTitle:(NSString *)title showLine:(BOOL)show{
    if ([NSStringUtils isNotBlank:title]) {
        self.titleLabel.text = title;
    }
    if (show) {
        self.downLine.hidden = NO;
    }else{
        self.downLine.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
