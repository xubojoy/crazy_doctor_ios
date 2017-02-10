//
//  FirstModel.h
//  豆果美食
//
//  Created by 张琦 on 16/3/31.
//  Copyright © 2016年 张琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, assign) BOOL flag;

+ (instancetype)defaultModel;


@end
