//
//  PellTableViewCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;


@end
