//
//  MyPhysiotherapyCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyPhysiotherapyCell.h"

@implementation MyPhysiotherapyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = [ColorUtils colorWithHexString:gray_text_color];
    self.downLine.backgroundColor = [ColorUtils colorWithHexString:splite_line_color];
}

- (void)renderMyPhysiotherapyCellWithMyDoctor:(MyDoctor *)myDoctor title:(NSString *)title{
    self.dateLabel.text = [DateUtils stringFromLongLongIntDate:myDoctor.modifydate];
    if ([NSStringUtils isNotBlank:myDoctor.cdbasicsick.paName]) {
       self.nameLabel.text = myDoctor.cdbasicsick.paName;
    }
    
    self.titleLabel.text = title;
}

- (void)renderMyPhysiotherapyCellWithMyPhysiotherapy:(MyPhysiotherapy *)myPhysiotherapy title:(NSString *)title{
    self.dateLabel.text = [DateUtils stringFromLongLongIntDate:myPhysiotherapy.sheetPsdate];
    if ([NSStringUtils isNotBlank:myPhysiotherapy.paName]) {
        self.nameLabel.text = myPhysiotherapy.paName;
    }
    
    self.titleLabel.text = title;

}

- (void)renderMyPhysiotherapyCellWithUserUploadRecord:(UserUploadRecord *)userUploadRecord{
    self.dateLabel.text = [DateUtils stringFromLongLongIntDate:userUploadRecord.diagnoseTime];
    if ([NSStringUtils isNotBlank:userUploadRecord.userName]) {
        self.nameLabel.text = userUploadRecord.userName;
    }
    self.titleLabel.text = userUploadRecord.hospital;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
