//
//  ExpertFilter.h
//  iUser
//
//  Created by System Administrator on 13-5-1.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertFilter : NSObject

@property int hairLengthTagId;
@property int tagId;
@property int childTagId;
@property int sortType;

-(NSArray *)getTagIds;

-(int) getPageSize;

-(id) initWithStatus:(int)hairLengthTagId
               tagId:(int)tagId
          childTagId:(int)childTagId
            sortType:(int)sortType;

-(int) skillTagId;

@end
