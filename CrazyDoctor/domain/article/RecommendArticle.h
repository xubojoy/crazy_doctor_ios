//
//  RecommendArticle.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doctor.h"
#import "Project.h"
#import "Article.h"
@protocol RecommendArticle
@end
@interface RecommendArticle : JSONModel

@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *recommendType;//  推荐类型 ,  医生：doctor；理疗项目：project；运动排行：sport；文章：article
@property (nonatomic ,assign) int doctorId;// : 医生id
@property (nonatomic ,assign) int projectId;// : 理疗项目id
//@property (nonatomic ,assign) int sportId;// : 运动id
@property (nonatomic ,assign) int articleId;// : 文章id
@property (nonatomic ,strong) NSString<Optional> *tagType;// : 标签类型
@property (nonatomic ,strong) NSString<Optional> *tag;// : 标签名
@property (nonatomic ,assign) long long int createTime;// ：创建时间

@property (nonatomic ,strong) Article<Optional> *article;
@property (nonatomic ,strong) Doctor<Optional> *doctor;//医生对象
@property (nonatomic ,strong) Project<Optional> *project;//理疗项目对象

@end
