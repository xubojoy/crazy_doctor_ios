//
//  UserSleepDetailCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserSleepDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UILabel *sleepLabel;

- (void)renderUserSleepDetailCell:(NSDictionary *)dict row:(NSInteger)row;
@end
