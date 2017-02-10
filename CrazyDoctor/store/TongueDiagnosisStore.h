//
//  TongueDiagnosisStore.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/26.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TongueDiagnosisStore : NSObject
+(void) getUserTongueDiagnoses:(void(^)(NSDictionary *tongueDiagnoseDic, NSError *err))completionBlock;

+(void) getAllBodyTags:(void(^)(NSArray *tags, NSError *err))completionBlock;

+(void) upLoadTongueDiagnosisImg:(void(^)(NSString *imgUrl, NSError *err))completionBlock tongueImage:(UIImage *)image;
+(void) confirmTongueDiagnosisTest:(void(^)(NSDictionary *dict, NSError *err))completionBlock userTongueUrl:(NSString *)userTongueUrl bodyTagIds:(NSArray *)bodyTagIds userSelectQuestions:(NSArray *)userSelectQuestions isPingHe:(BOOL)isPingHe;

@end
