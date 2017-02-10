//
//  RechargeCommonCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RechargeCommonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic ,strong) UITextField *contentField;

@property (weak, nonatomic) IBOutlet UIView *downLine;


- (void)renderRechargeCommonCellWithTitle:(NSString *)titleStr titleColor:(UIColor *)titleColor content:(NSString *)contentStr placeholder:(NSString *)placeholderStr showLine:(BOOL)show userEnable:(BOOL)enable;


@end
