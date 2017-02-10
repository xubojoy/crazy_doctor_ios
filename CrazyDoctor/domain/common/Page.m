//
//  Page.m
//  styler
//
//  Created by wangwanggy820 on 14-3-28.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "Page.h"

@implementation Page

-(id) initWithJSONDictionary:(NSDictionary *)jsonDict{
    self = [super init];
    [self readFromJSONDictionary:jsonDict];
    return self;
}

+(NSArray *) readFromJsonDictionayArray: (NSArray *)jsonDictArray{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(int i = 0; i < [jsonDictArray count]; i++){
        Page *page = [[Page alloc] initWithJSONDictionary:jsonDictArray[i]];
        [result addObject:page];
    }
    return result;
}

//把picture的所有属性放到数组中
- (void) readFromJSONDictionary:(NSDictionary *)jsonDict
{
    self.pageNo = [[jsonDict objectForKey:@"pageNo"] intValue];
    self.pageSize = [[jsonDict objectForKey:@"pageSize"] intValue];
    self.totalCount = [[jsonDict objectForKey:@"totalCount"] intValue];
}

-(int)currentPageNo{
    return self.pageNo;
}

-(BOOL) isLastPage{
    if (self.totalCount <= self.pageNo * self.pageSize) {
        return YES;
    }
    return NO;
}

@end
