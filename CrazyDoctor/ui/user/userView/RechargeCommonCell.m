//
//  RechargeCommonCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "RechargeCommonCell.h"

@implementation RechargeCommonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, screen_width-30, 50)];
    self.contentField.font = [UIFont systemFontOfSize:big_font_size];
    self.contentField.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.contentField];
    
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
}

- (void)renderRechargeCommonCellWithTitle:(NSString *)titleStr titleColor:(UIColor *)titleColor content:(NSString *)contentStr placeholder:(NSString *)placeholderStr showLine:(BOOL)show userEnable:(BOOL)enable{
    self.titleLabel.text = titleStr;
    self.titleLabel.textColor = titleColor;
    self.contentField.text = contentStr;
    self.contentField.placeholder = placeholderStr;
    
    if (enable) {
        self.contentField.userInteractionEnabled = YES;
    }else{
        self.contentField.userInteractionEnabled = NO;
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
