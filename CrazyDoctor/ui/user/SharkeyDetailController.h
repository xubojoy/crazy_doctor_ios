//
//  SharkeyDetailController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/27.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharkeyDetailView.h"
@interface SharkeyDetailController : BaseViewController
@property (nonatomic, strong) HeaderView *headerView;
@property (nonatomic ,strong) SharkeyDetailView *sharkeyDetailView;
@property (nonatomic ,strong) UIView *upLine;
@property (nonatomic ,strong) UIButton *deleteBtn;
@property (nonatomic ,strong) UILabel *noneSharkeyLabel;

@end
