//
//  Pathology.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/28.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Pathology
@end
@interface Pathology : JSONModel

@property (nonatomic ,assign) int pathologyTypeId;
@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *content;

@end
