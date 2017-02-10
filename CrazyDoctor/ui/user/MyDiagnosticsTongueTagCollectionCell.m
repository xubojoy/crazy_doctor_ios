//
//  MyDiagnosticsTongueTagCollectionCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/11.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MyDiagnosticsTongueTagCollectionCell.h"
#import "LBorderView.h"
@implementation MyDiagnosticsTongueTagCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.sepImageView = [[LBorderView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.sepImageView.borderType = BorderTypeDashed;
    self.sepImageView.dashPattern = 2;
    self.sepImageView.spacePattern = 2;
    self.sepImageView.borderWidth = 1;
    self.sepImageView.borderColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
    self.sepImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.sepImageView];
    
    self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(1, 1, self.sepImageView.frame.size.width-2, self.sepImageView.frame.size.height-2)];
    self.tagLabel.textColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
    self.tagLabel.font = [UIFont boldSystemFontOfSize:big_font_size];
    self.tagLabel.text = @"痰湿";
    self.tagLabel.textAlignment = NSTextAlignmentCenter;
    self.tagLabel.backgroundColor = [UIColor whiteColor];
    [self.sepImageView addSubview:self.tagLabel];
}

- (void)renderMyDiagnosticsTongueTagCollectionCellWithTagName:(NSString *)tagName{
    if ([NSStringUtils isNotBlank:tagName]) {
        self.tagLabel.text = tagName;
    }
}

@end
