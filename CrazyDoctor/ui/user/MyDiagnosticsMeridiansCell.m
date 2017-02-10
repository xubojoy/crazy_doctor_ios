//
//  MyDiagnosticsMeridiansCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyDiagnosticsMeridiansCell.h"

@implementation MyDiagnosticsMeridiansCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
    self.dateLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    
    self.sepImageView = [[LBorderView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
    self.sepImageView.borderType = BorderTypeDashed;
    self.sepImageView.dashPattern = 2;
    self.sepImageView.spacePattern = 2;
    self.sepImageView.borderWidth = 1;
    self.sepImageView.borderColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
    self.sepImageView.backgroundColor = [UIColor whiteColor];
    [self.bgMeridiansView addSubview:self.sepImageView];
    
    self.acupointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 25)];
    self.acupointLabel.textAlignment = NSTextAlignmentCenter;
    self.acupointLabel.textColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
    self.acupointLabel.font = [UIFont boldSystemFontOfSize:default_font_size];
//    self.acupointLabel.text = @"孔最穴";
    [self.sepImageView addSubview:self.acupointLabel];
    
    self.painLevelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 90, 15)];
    self.painLevelLabel.textAlignment = NSTextAlignmentCenter;
    self.painLevelLabel.textColor = [ColorUtils colorWithHexString:light_gray_text_color];
    self.painLevelLabel.font = [UIFont systemFontOfSize:9];
//    self.painLevelLabel.text = @"痛感等级，微痛喜按";
    [self.sepImageView addSubview:self.painLevelLabel];
}

- (void)renderMyDiagnosticsMeridiansCellWithDiagnoseLog:(DiagnoseLog *)diagnoseLog{
    if ([NSStringUtils isNotBlank:diagnoseLog.acupoint]) {
        self.acupointLabel.text = diagnoseLog.acupoint;
    }
    self.dateLabel.text = [DateUtils dateWithStringFromLongLongInt:diagnoseLog.createTime];
    if (diagnoseLog.painLevel == 1) {
        self.painLevelLabel.text = @"痛感等级，不痛";
    }else if (diagnoseLog.painLevel == 2){
        self.painLevelLabel.text = @"痛感等级，微痛喜按";
    }else if (diagnoseLog.painLevel == 3){
        self.painLevelLabel.text = @"痛感等级，中痛喜按";
    }else{
        self.painLevelLabel.text = @"痛感等级，剧痛拒按";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
