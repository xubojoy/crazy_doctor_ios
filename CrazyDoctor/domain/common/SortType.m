//
//  SortType.m
//  styler
//
//  Created by System Administrator on 13-7-10.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "SortType.h"

@implementation SortType

-(id) init:(int)type name:(NSString *)name{
    SortType *sortType = [super init];
    if(sortType){
        sortType.type = type;
        sortType.name = name;
    }
    
    return sortType;
}

+(NSArray *) getAllSortType{
    static NSMutableArray *allSortType = nil;
    if(allSortType == nil){
        allSortType = [[NSMutableArray alloc] init];
        [allSortType addObject:[[SortType alloc] init:sort_type_order_by_update_time_desc name:@"最新发布"]];
        [allSortType addObject:[[SortType alloc] init:sort_type_order_by_distance_desc name:@"距离最近"]];
    }
    
    return allSortType;
}

@end
