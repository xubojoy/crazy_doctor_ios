//
//  FirstModel.m
//  豆果美食
//
//  Created by 张琦 on 16/3/31.
//  Copyright © 2016年 张琦. All rights reserved.
//

#import "FirstModel.h"

@implementation FirstModel

+ (instancetype)defaultModel {
    FirstModel *model = [[self alloc] init];
    model.flag = NO;
    model.array = [NSMutableArray array];
    return model;
}

@end
