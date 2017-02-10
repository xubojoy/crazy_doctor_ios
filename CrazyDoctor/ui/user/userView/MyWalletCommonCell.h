//
//  MyWalletCommonCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWalletCommonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)renderUserCenterCommonCellWithIcon:(NSString *)icon withTitle:(NSString *)title;

@end
