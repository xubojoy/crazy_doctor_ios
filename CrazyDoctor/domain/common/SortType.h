//
//  SortType.h
//  styler
//
//  Created by System Administrator on 13-7-10.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#define sort_type_order_by_update_time_desc 0
#define sort_type_order_by_distance_desc 1
#define sort_type_order_by_price_asc 2
#define sort_type_order_by_price_desc 3


#import <Foundation/Foundation.h>

@interface SortType : NSObject

@property int type;
@property (nonatomic, retain) NSString *name;

-(id) init:(int)type name:(NSString *)name;

+(NSArray *) getAllSortType;

@end
