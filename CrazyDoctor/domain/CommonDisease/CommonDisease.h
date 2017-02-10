//
//  CommonDisease.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pathology.h"
@protocol CommonDisease
@end
@interface CommonDisease : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString *name;
@property (nonatomic ,strong) NSArray<Pathology *><Optional> *pathologies;

@end
