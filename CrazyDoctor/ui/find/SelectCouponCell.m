//
//  SelectCouponCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/1.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SelectCouponCell.h"
#import "DashLineView.h"
@implementation SelectCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    self.yuanLabel.textColor = [UIColor whiteColor];
    self.amountLabel.textColor = [UIColor whiteColor];
    self.manjianTitleLabel.textColor = [UIColor whiteColor];
    self.limitUseLabel.textColor = [UIColor whiteColor];
    self.remindLabel.textColor = [UIColor whiteColor];
    self.dateBgView.backgroundColor = [UIColor whiteColor];
    self.dateBgView.layer.borderWidth = splite_line_height;
    self.dateBgView.layer.borderColor = [ColorUtils colorWithHexString:@"#774c22"].CGColor;
    self.dateLabel.textColor = [ColorUtils colorWithHexString:@"#999999"];
    DashLineView *dashLine = [[DashLineView alloc]initWithFrame:CGRectMake(148, 25, 1, 105-40)];
    [dashLine setLineColor:[UIColor whiteColor] LineWidth:1];
    dashLine.backgroundColor = [ColorUtils colorWithHexString:common_app_text_color];
    [self.contentView addSubview:dashLine];
}

- (void)renderSelectCouponCell:(RedEnvelope *)redEnvelope{
    if ([redEnvelope.type isEqualToString:@"meetSubtract"]) {
        self.limitAmountConstraint.constant = 21;
        self.amountLabel.text = [NSString stringWithFormat:@"%d",redEnvelope.amount];
        self.manjianTitleLabel.text = @"满减优惠券";
        self.limitUseLabel.text = [NSString stringWithFormat:@"满%d元可用",redEnvelope.meetAmount];
        self.remindLabel.text = @"除特例品、特殊商品外";
    }else{
        self.limitAmountConstraint.constant = 0;
        self.amountLabel.text = [NSString stringWithFormat:@"%d",redEnvelope.amount];
        self.manjianTitleLabel.text = @"立减优惠券";
        self.remindLabel.text = @"除特例品、特殊商品外";
    }
    NSDate *date = [NSDate date];
    NSString *nowDateStr = [DateUtils getDateByPickerDate:date];
    
    NSString *expireTimeStr = [DateUtils dateStringWithFromLongLongInt:redEnvelope.expireTime];
    
    NSLog(@">>>>>>有效期>>>>>>>>%@-------%@",nowDateStr,expireTimeStr);
    self.dateLabel.text = [NSString stringWithFormat:@"有效期：%@至%@",[nowDateStr substringFromIndex:2],[expireTimeStr substringFromIndex:2]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
