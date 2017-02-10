//
//  Article.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Article
@end
@interface Article : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *articleRelationTags;
@property (nonatomic ,assign) long long int createTime;
@property (nonatomic ,assign) long long int lastUpdateTime;

@property (nonatomic ,strong) NSString<Optional> *content;
@property (nonatomic ,assign) int createdUserId;
@property (nonatomic ,strong) NSString<Optional> *intro;
@property (nonatomic ,strong) NSString<Optional> *logoUrl;
@property (nonatomic ,assign) BOOL recommendFlag;
@property (nonatomic ,strong) NSString<Optional> *title;
@property (nonatomic ,strong) NSString<Optional> *videoUrl;
@property (nonatomic ,assign) int viewCount;


@end
