//
//  SessionMsg.h
//  styler
//
//  Created by System Administrator on 13-6-25.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface SessionMsg : NSObject<JSONSerializable>

@property int senderId;
@property (nonatomic, copy) NSString *txt;
@property (nonatomic, copy) NSDate *createTime;

-(SessionMsg *) init:(int)senderId txt:(NSString *)txt createTime:(NSDate *)createTime;

+(NSArray *) readMsgsFromJsonDictionayArray:(NSArray *)jsonDictArray;

@end
