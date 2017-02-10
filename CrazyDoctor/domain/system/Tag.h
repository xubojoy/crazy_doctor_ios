//
//  SkillTag.h
//  iUser
//
//  Created by System Administrator on 13-4-10.
//  Copyright (c) 2013年 珠元玉睿ray. All rights reserved.
//

#define hair_length_tag_id 85
#define technology_tag_id 31

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
#import "JSONModel.h"

@protocol Tag
@end

@interface Tag : JSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSMutableArray<Tag> *children;

@end
