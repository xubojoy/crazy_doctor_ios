//
//  MedicalRecordClassifyCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MedicalRecordClassifyCell.h"

@implementation MedicalRecordClassifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.nameLabel.textColor = [ColorUtils colorWithHexString:@"#666666"];
    self.nameLabel.font = [UIFont systemFontOfSize:12];
    
    self.guigeLabel.textColor = [ColorUtils colorWithHexString:@"#666666"];
    self.guigeLabel.font = [UIFont systemFontOfSize:12];
    
    self.countLabel.textColor = [ColorUtils colorWithHexString:@"#666666"];
    self.countLabel.font = [UIFont systemFontOfSize:12];
    
    self.mgLabel.textColor = [ColorUtils colorWithHexString:@"#666666"];
    self.mgLabel.font = [UIFont systemFontOfSize:12];
    
    self.frequencyLabel.textColor = [ColorUtils colorWithHexString:@"#666666"];
    self.frequencyLabel.font = [UIFont systemFontOfSize:12];
    
    self.usageLabel.textColor = [ColorUtils colorWithHexString:@"#666666"];
    self.usageLabel.font = [UIFont systemFontOfSize:12];
    
    self.dayLabel.textColor = [ColorUtils colorWithHexString:@"#666666"];
    self.dayLabel.font = [UIFont systemFontOfSize:12];
    
    self.amountLabel.textColor = [ColorUtils colorWithHexString:@"#666666"];
    self.amountLabel.font = [UIFont systemFontOfSize:12];
    
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    
    for (NSInteger i = 0; i < 8; i ++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i*(screen_width/8), 0, splite_line_height, 50)];
        line.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
        [self.contentView addSubview:line];
    }
}

- (void)renderMedicalRecordClassifyCellWithDetailid:(Detailid *)detailid{
    self.nameLabel.text = detailid.itemname;
    self.guigeLabel.text = [NSString stringWithFormat:@"%d",detailid.medjl];
    self.countLabel.text = [NSString stringWithFormat:@"%d",detailid.leastnumber];
    self.mgLabel.text = detailid.medjldw;
    self.frequencyLabel.text = detailid.freqid;
    self.usageLabel.text = [NSString stringWithFormat:@"%f",detailid.price];
    self.dayLabel.text = [NSString stringWithFormat:@"%d",detailid.daynumber];
    self.amountLabel.text = [NSString stringWithFormat:@"%f",detailid.itemamount];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
