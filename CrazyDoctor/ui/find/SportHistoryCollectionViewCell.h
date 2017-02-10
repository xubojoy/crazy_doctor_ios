//
//  SportHistoryCollectionViewCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/24.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportHistoryCollectionViewCell : UICollectionViewCell

@property (nonatomic ,strong) UIView *barView;
//@property (nonatomic ,strong) UILabel *dateLabel;
@property (nonatomic ,strong) UIView *sepLine;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;



- (void)renderSportHistoryCollectionViewCell:(float)height dateStr:(NSString *)dateStr;

@end
