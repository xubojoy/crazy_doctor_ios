//
//  ExpertFilter.m
//  iUser
//
//  Created by System Administrator on 13-5-1.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "ExpertFilter.h"
#import "Tag.h"
#import "SortType.h"

@implementation ExpertFilter

-(int)skillTagId{
    if(self.childTagId<=0){
        return self.tagId;
    }
    return self.childTagId;
}

-(int) getPageSize{
    return 50;
}

-(NSArray *)getTagIds{
    NSMutableArray *tagIds = [[NSMutableArray alloc] init];
    [tagIds addObject:[[NSNumber alloc] initWithInt:self.hairLengthTagId]];
    if(self.childTagId > 0){
        [tagIds addObject:[[NSNumber alloc] initWithInt:self.childTagId]];
    }else{
        [tagIds addObject:[[NSNumber alloc] initWithInt:self.tagId]];
    }
    return tagIds;
}

-(id)init{
    return [self initWithStatus:hair_length_tag_id tagId:0 childTagId:0 sortType:sort_type_order_by_update_time_desc];
}

-(id) initWithStatus:(int)hairLengthTagId
                 tagId:(int)tagId
            childTagId:(int)childTagId
              sortType:(int)sortType{
    self = [super init];
    if(self){
        self.hairLengthTagId = hairLengthTagId;
        self.tagId = tagId;
        self.childTagId = childTagId;
        self.sortType = sortType;
    }
    return self;
}

@end
