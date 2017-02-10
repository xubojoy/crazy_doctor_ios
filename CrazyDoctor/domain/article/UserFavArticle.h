//
//  UserFavArticle.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol UserFavArticle
@end
@interface UserFavArticle : JSONModel

@property (nonatomic ,assign) int id;
@property (nonatomic ,assign) int userId;
@property (nonatomic ,assign) int articleId;// : 文章id
@property (nonatomic ,strong) NSString<Optional> *articleTitle;// : 文章标题
@property (nonatomic ,strong) NSString<Optional> *logoUrl;// ：文章Logo url
@property (nonatomic ,strong) NSString<Optional> *intro;// : 文章介绍
@property (nonatomic ,assign) long long int createTime;// ：收藏时间

@end
