//
//  City.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol City
@end
@interface City : JSONModel

@property (nonatomic ,strong) NSString<Optional> *province;
@property (nonatomic ,strong) NSString<Optional> *name;

@end
