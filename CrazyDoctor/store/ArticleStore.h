//
//  ArticleStore.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/19.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"
@interface ArticleStore : NSObject

+ (void)getAllRecommendArticles:(void(^)(Page *page ,NSError *error))completionBlock city:(NSString *)city age:(int)age userGender:(NSString *)userGender bodyTags:(NSString *)bodyTags eyeTagNames:(NSString *)eyeTagNames session:(NSString *)session pageNo:(int)pageNo pageSize:(int)pageSize;
+ (void)getAllIOSRecommendArticles:(void(^)(Page *page ,NSError *error))completionBlock city:(NSString *)city pageNo:(int)pageNo pageSize:(int)pageSize;

+ (void) updateArticleReadCount:(void(^)(NSDictionary *dict, NSError *err))completionBlock articleId:(int)articleId;
///ios/recommendArticles/search

@end
