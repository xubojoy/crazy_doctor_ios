//
//  EyePositionModel.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/3.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "EyePositionModel.h"

@implementation EyePositionModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.positionId = [dict[@"positionId"] intValue];
        self.organ = dict[@"organ"];
        self.imgUrl = dict[@"imgUrl"];
        self.selectState = [dict[@"selectState"] boolValue];
        self.remark = dict[@"remark"];
    }
    return  self;
}

@end
