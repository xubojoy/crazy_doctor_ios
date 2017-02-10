//
//  CollectionViewCell.m
//  CollectionViewSubscriptionLabel
//
//  Created by chenyk on 15/4/24.
//  Copyright (c) 2015年 chenyk. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder: (NSCoder *)aDecoder {
    self = [super initWithCoder: aDecoder];
    if (self) {
        self = [self sharedInit];
    }
    return self;
}
- (id)sharedInit {
    [self setup];
    return self;
}

- (void)setup {
    
    self.sepImageView = [[LBorderView alloc] init];
    self.sepImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.sepImageView.borderType = BorderTypeDashed;
    self.sepImageView.dashPattern = 2;
    self.sepImageView.spacePattern = 2;
    self.sepImageView.borderWidth = 1;
    self.sepImageView.borderColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
    self.sepImageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.sepImageView];
    
    
    self.titleLabel = [UILabel new];
    self.titleLabel.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:big_font_size];
    self.titleLabel.textColor = [ColorUtils colorWithHexString:lighter_2_brown_color];
    self.titleLabel.backgroundColor = [UIColor clearColor];
//    self.titleLabel.layer.borderWidth = .5;
//    self.titleLabel.layer.masksToBounds = YES;
//    self.titleLabel.layer.borderColor = [ColorUtils colorWithHexString:splite_line_color].CGColor;
    
    [self.contentView addSubview:self.titleLabel];
}


@end
