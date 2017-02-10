//
//  PushSettingCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQXSwitch.h"

@protocol PushSettingCellDelegate <NSObject>

//- (void)didPushSettingCellSwit:(LQXSwitch *)sender;

@end

@interface PushSettingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *meridianLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;
@property (nonatomic ,assign) BOOL canTouch;
@property (nonatomic ,strong) LQXSwitch *pushSwit;
@property (nonatomic ,assign) id<PushSettingCellDelegate> delegate;

- (void)renderPushSettingCellWithTime:(NSString *)time withMeridian:(NSString *)meridian;

@end
