//
//  SportHistoryCollectionViewCell.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/24.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SportHistoryCollectionViewCell.h"

@implementation SportHistoryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.barView = [[UIView alloc] init];
    self.barView.backgroundColor = [ColorUtils colorWithHexString:@"#9bc01d"];
    [self.contentView addSubview:self.barView];
    
//    self.sepLine = [[UIView alloc] init];
//    self.sepLine.backgroundColor = [ColorUtils colorWithHexString:@"#684e45"];
//    [self.contentView addSubview:self.sepLine];
    
    self.dateLabel.backgroundColor = [UIColor clearColor];
    self.dateLabel.textColor = [ColorUtils colorWithHexString:@"#efd6bc"];
    self.dateLabel.font = [UIFont systemFontOfSize:10];
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)renderSportHistoryCollectionViewCell:(float)height dateStr:(NSString *)dateStr{
    NSLog(@">>>>>>>渲染日期为>>>>>>>>>>%@-------%.2f",dateStr,height);
    self.sepLine.frame = CGRectMake(0, self.frame.size.height-20, 37, splite_line_height);
    int viewHeight = ((674/2)-64)-30;
    self.barView.frame = CGRectMake(0, viewHeight-height-20, 32, height);
//    CGSize buttonSize = CGSizeMake(32, height);
    self.dateLabel.text = [dateStr substringFromIndex:5];
}

@end
