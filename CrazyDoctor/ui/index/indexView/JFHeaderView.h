//
//  JFHeaderView.h
//  JFList
//
//  Created by 李俊峰 on 16/2/28.
//  Copyright © 2016年 李俊峰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelGroups.h"
@class JFHeaderView;

@protocol JFHeaderViewDelegate <NSObject>
- (void)jfHeaderView:(JFHeaderView *)view didButton:(UIButton *)sender;
@end

@interface JFHeaderView : UITableViewHeaderFooterView
@property(nonatomic, strong) UILabel * label;
@property(nonatomic, strong) UILabel * labelNum;
@property(nonatomic, strong) UIButton * button;
@property (nonatomic, strong) UIImageView *imageArrow;
@property (nonatomic ,strong) UIImageView *logoImageView;

+(JFHeaderView *)jfHeadViewWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ModelGroups *group;
@property (nonatomic, weak) id <JFHeaderViewDelegate>delegate;
@end
