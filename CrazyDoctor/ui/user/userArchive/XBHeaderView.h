//
//  XBHeaderView.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/16.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MedicalRecordModel.h"
@class XBHeaderView;

@protocol XBHeaderViewDelegate <NSObject>
- (void)xbHeaderView:(XBHeaderView *)view didButton:(UIButton *)sender;
@end

@interface XBHeaderView : UITableViewHeaderFooterView
@property(nonatomic, strong) UILabel * label;
@property(nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIImageView *imageArrow;

+(XBHeaderView *)xbHeaderViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) MedicalRecordModel *group;
@property (nonatomic, weak) id <XBHeaderViewDelegate>delegate;
@end
