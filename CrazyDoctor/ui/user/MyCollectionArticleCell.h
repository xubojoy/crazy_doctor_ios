//
//  MyCollectionArticleCell.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/8/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserFavArticle.h"
@interface MyCollectionArticleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *articleLogoImageView;

@property (weak, nonatomic) IBOutlet UILabel *articleTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *shortIntroLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UIView *downLine;

@property (weak, nonatomic) IBOutlet UIButton *deleteFavBtn;

- (void)renderMyCollectionArticleCellWithUserFavArticle:(UserFavArticle *)userFavArticle;

@end
