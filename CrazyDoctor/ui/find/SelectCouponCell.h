//
//  SelectCouponCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/1.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedEnvelope.h"
@interface SelectCouponCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (weak, nonatomic) IBOutlet UILabel *yuanLabel;

@property (weak, nonatomic) IBOutlet UILabel *manjianTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *limitUseLabel;

@property (weak, nonatomic) IBOutlet UILabel *remindLabel;

@property (weak, nonatomic) IBOutlet UIView *dateBgView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *limitAmountConstraint;



- (void)renderSelectCouponCell:(RedEnvelope *)redEnvelope;

@end
