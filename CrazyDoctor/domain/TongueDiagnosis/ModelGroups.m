//
//  ModelGroups.m
//  JFList
//
//  Created by 李俊峰 on 16/2/28.
//  Copyright © 2016年 李俊峰. All rights reserved.
//

#import "ModelGroups.h"

@implementation ModelGroups

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.id = [dict[@"id"] intValue];
        self.bodyTagQuestions = dict[@"bodyTagQuestions"];
        self.detailImageUrl = dict[@"detailImageUrl"];
        self.logoUrl = dict[@"logoUrl"];
        self.name = dict[@"name"];
        self.nameUrl = dict[@"nameUrl"];
        self.remark = dict[@"remark"];
        self.tongueImageUrl = dict[@"tongueImageUrl"];
        self.isOpen = [dict[@"isOpen"] boolValue];
        self.groups = dict[@"groups"];
    }
    return  self;
}


@end
