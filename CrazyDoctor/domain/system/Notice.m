//
//  Notice.m
//  styler
//
//  Created by System Administrator on 13-6-21.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "Notice.h"

@implementation Notice

+(NSArray *) readNoticesFromJsonDictionayArray:(NSArray *)jsonDictArray{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(int i = 0; i < [jsonDictArray count]; i++){
        Notice *notice = [[Notice alloc] init];
        [notice readFromJSONDictionary:[jsonDictArray objectAtIndex:i]];
        [result addObject:notice];
    }
    return result;
}

- (void) readFromJSONDictionary:(NSDictionary *)jsonDict{
    self.noticeId = [[jsonDict objectForKey:@"id"] intValue];
    self.content = [jsonDict objectForKey:@"content"];
    
    long long int createTimeL = [[jsonDict objectForKey:@"createTime"] longLongValue];
    self.createTime = [NSDate dateWithTimeIntervalSince1970:createTimeL/1000];
}
@end
