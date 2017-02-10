//
//  ShowIMGModel.m
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import "ShowIMGModel.h"


@implementation ShowIMGModel

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
        self.selected = [dict[@"selected"] boolValue];
    }
    return  self;
}

@end
