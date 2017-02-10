//
//  SportDetailStepCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/21.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportDetailStepCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


@property (weak, nonatomic) IBOutlet UILabel *stepNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *kmLabel;

@property (weak, nonatomic) IBOutlet UILabel *kcallLabel;

- (void)renderSportDetailStepCell:(NSDictionary *)dict row:(NSInteger)row;


@end
