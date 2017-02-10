//
//  TongueDiagnosisResultCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BodyTag.h"
@interface TongueDiagnosisResultCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@property (weak, nonatomic) IBOutlet UIImageView *titleBgImageView;


@property (weak, nonatomic) IBOutlet UIImageView *questionImageView;

@property (strong, nonatomic) UILabel *featureLabel;


- (void)renderTongueDiagnosisResultCell:(BodyTag *)bodyTag withSection:(NSInteger)section;

@end
