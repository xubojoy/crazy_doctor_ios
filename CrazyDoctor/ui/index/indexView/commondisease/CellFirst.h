//
//  CellFirst.h
//  豆果美食
//
//  Created by 张琦 on 16/3/31.
//  Copyright © 2016年 张琦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pathology.h"
@class FirstModel;
typedef void (^nameBlock)(Pathology *pathology);
@interface CellFirst : UITableViewCell
@property (nonatomic, assign) int currentItem;
@property (nonatomic, assign) int previousItem;
@property (nonatomic, strong) FirstModel *model;
- (void)backNameWithNameBlock:(nameBlock)nameBlok;
@end
