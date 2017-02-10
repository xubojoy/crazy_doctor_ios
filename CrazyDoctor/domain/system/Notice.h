//
//  Notice.h
//  styler
//
//  Created by System Administrator on 13-6-21.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface Notice : NSObject<JSONSerializable>

@property int noticeId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSDate *createTime;

+(NSArray *) readNoticesFromJsonDictionayArray:(NSArray *)jsonDictArray;

@end
