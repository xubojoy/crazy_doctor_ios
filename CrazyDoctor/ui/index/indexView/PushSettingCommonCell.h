//
//  PushSettingCommonCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQXSwitch.h"
@protocol PushSettingCommonCellDelegate <NSObject>

- (void)didPushCommonCellSwit:(LQXSwitch *)sender;

@end

@interface PushSettingCommonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (nonatomic ,strong) LQXSwitch *pushSwit;

@property (nonatomic ,assign) id<PushSettingCommonCellDelegate> delegate;
@end
