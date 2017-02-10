//
//  WLZShareItem.h
//  WLZShareView
//
//  Created by lijiarui on 15/11/11.
//  Copyright © 2015年 lijiarui qq:81995383. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLZBlockButton.h"

@interface WLZShareItem : UIView
@property (nonatomic, strong) WLZBlockButton *itemButton;

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *titleLabel;
@end
