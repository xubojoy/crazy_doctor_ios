//
//  Province.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
@protocol Province
@end
@interface Province : JSONModel
@property (nonatomic ,strong) NSString<Optional> *areaName;
@property (nonatomic ,strong) NSArray<City *><Optional> *cities;
@property (nonatomic ,strong) NSString<Optional> *name;
@end
