//
//  MedicalRecordModel.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/16.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "MedicalRecordModel.h"

@implementation MedicalRecordModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        self.name = dict[@"name"];
        self.isOpen = [dict[@"isOpen"] boolValue];
    }
    return  self;
}
@end
