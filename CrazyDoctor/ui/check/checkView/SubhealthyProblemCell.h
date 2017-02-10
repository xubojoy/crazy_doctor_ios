//
//  SubhealthyProblemCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubhealthyProblemCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *leftLineView;

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;

@property (weak, nonatomic) IBOutlet UIView *rightLine;

@property (weak, nonatomic) IBOutlet UILabel *titlelabel;

@property (weak, nonatomic) IBOutlet UIView *upLine;

@property (weak, nonatomic) IBOutlet UIView *downLine;


- (void)renderSubhealthyProblemCell:(NSString *)title showUpLine:(BOOL)showUpLine showDownLine:(BOOL)showDownLine;



@end
