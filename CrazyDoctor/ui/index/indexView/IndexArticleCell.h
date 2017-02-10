//
//  IndexArticleCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/12.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Acupoint.h"
#import "RecommendArticle.h"
#import "UserFavArticle.h"
@interface IndexArticleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *articleLogoImageView;

@property (weak, nonatomic) IBOutlet UIImageView *redDotImgView;


@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortIntroLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (nonatomic ,strong) Acupoint *acupoint;


- (void)renderIndexArticleCellWithAcupoint:(Acupoint *)acupoint;

- (void)renderIndexArticleCellWithRecommendArticle:(RecommendArticle *)recommendArticle;

- (void)renderIndexArticleCellWithUserFavArticle:(UserFavArticle *)userFavArticle;

@end
