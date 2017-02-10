//
//  MyPhysiotherapyCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDoctor.h"
#import "MyPhysiotherapy.h"
#import "UserUploadRecord.h"
@interface MyPhysiotherapyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UIView *downLine;

- (void)renderMyPhysiotherapyCellWithMyDoctor:(MyDoctor *)myDoctor title:(NSString *)title;

- (void)renderMyPhysiotherapyCellWithMyPhysiotherapy:(MyPhysiotherapy *)myPhysiotherapy title:(NSString *)title;

- (void)renderMyPhysiotherapyCellWithUserUploadRecord:(UserUploadRecord *)userUploadRecord;

@end
