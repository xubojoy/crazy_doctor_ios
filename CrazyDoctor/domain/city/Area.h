//
//  Area.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Province.h"
@protocol Area
@end
@interface Area : JSONModel
@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,strong) NSArray<Province *><Optional> *provinces;

@end
