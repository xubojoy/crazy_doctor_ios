//
//  MedicalRecordCommonCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalRecordCommonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;


- (void)renderMedicalRecordCommonCellWithTitle:(NSString *)title content:(NSString *)content;

@end
