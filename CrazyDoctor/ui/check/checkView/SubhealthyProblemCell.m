//
//  SubhealthyProblemCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SubhealthyProblemCell.h"

@implementation SubhealthyProblemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.leftLineView.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.rightLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.upLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    
    self.upLine.hidden = YES;
    self.downLine.hidden = YES;
    self.titlelabel.font = [UIFont systemFontOfSize:default_2_font_size];
    self.titlelabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
}

- (void)renderSubhealthyProblemCell:(NSString *)title showUpLine:(BOOL)showUpLine showDownLine:(BOOL)showDownLine{
    if ([NSStringUtils isNotBlank:title]) {
        self.titlelabel.text = title;
    }
    
    if (showUpLine) {
        self.upLine.hidden = NO;
    }else{
        self.upLine.hidden = YES;
    }
    
    if (showDownLine) {
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
