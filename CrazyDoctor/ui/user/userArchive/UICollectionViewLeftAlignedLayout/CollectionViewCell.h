//
//  CollectionViewCell.h
//  CollectionViewSubscriptionLabel
//
//  Created by chenyk on 15/4/24.
//  Copyright (c) 2015年 chenyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBorderView.h"
@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel  * titleLabel;

@property (strong, nonatomic) LBorderView *sepImageView;
@end
