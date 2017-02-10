//
//  MeridianStore.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/4.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeridianStore : NSObject

+(void) getMeridiansInfo:(void(^)(NSArray *meridiansArray, NSError *err))completionBlock;

+(void) confirmMeridianRecord:(void(^)(NSDictionary *dict, NSError *err))completionBlock  userId:(int)userId meridianId:(int)meridianId acupointId:(int)acupointId level:(int)level;

@end
