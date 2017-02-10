//
//  CityStore.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityStore : NSObject

+(void) getAllCitys:(void(^)(NSDictionary *dict, NSError *err))completionBlock;

+(void) getAllHotCitys:(void(^)(NSArray *hotCitiesArr, NSError *err))completionBlock;

@end
