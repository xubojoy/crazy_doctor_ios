//
//  SportSelectSharkeyCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/22.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCDSharkeyFunction.h"
@interface SportSelectSharkeyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sharkeyNameLabel;


@property (weak, nonatomic) IBOutlet UILabel *sharkeyModelNameLabel;

- (void)renderSportSelectSharkeyCell:(Sharkey *)sharkey;

@end
