//
//  SessionMsg.m
//  styler
//
//  Created by System Administrator on 13-6-25.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "SessionMsg.h"

@implementation SessionMsg

-(SessionMsg *) init:(int)senderId txt:(NSString *)txt createTime:(NSDate *)createTime{
    SessionMsg *msg = [super init];
    if(msg){
        msg.senderId = senderId;
        msg.txt = txt;
        msg.createTime = createTime;
    }
    return msg;
}

- (void) readFromJSONDictionary:(NSDictionary *)jsonDict{
    self.txt = [jsonDict objectForKey:@"txt"];
    self.senderId = [[jsonDict objectForKey:@"senderId"] intValue];
    long long int createTimeL = [[jsonDict objectForKey:@"createTime"] longLongValue];
    self.createTime = [NSDate dateWithTimeIntervalSince1970:createTimeL/1000];
}

+(NSArray *) readMsgsFromJsonDictionayArray:(NSArray *)jsonDictArray{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(int i = (int)[jsonDictArray count]-1; i >= 0; i--){
        SessionMsg *msg = [[SessionMsg alloc] init];
        [msg readFromJSONDictionary:[jsonDictArray objectAtIndex:i]];
        [result addObject:msg];
    }
    return result;
}

@end
