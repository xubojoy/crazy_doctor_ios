//
//  DiscoverIndexCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/25.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DiscoverIndexCellDelegate <NSObject>

- (void)didOrderPhysiotheraprBtnClick:(UIButton *)sender;

@end
@interface DiscoverIndexCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *orderPhysiotheraprBtn;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic ,assign) id<DiscoverIndexCellDelegate> delegate;

- (void)renderDiscoverIndexCellWith:(NSString *)icon title:(NSString *)title;

@end
