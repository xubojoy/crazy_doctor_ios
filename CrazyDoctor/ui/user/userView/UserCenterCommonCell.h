//
//  UserCenterCommonCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterCommonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImgView;

- (void)renderUserCenterCommonCellWithIcon:(NSString *)icon withTitle:(NSString *)title showLine:(BOOL)show showRightArrow:(BOOL)showRightArrow;

@end
