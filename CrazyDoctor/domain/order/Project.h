//
//  Project.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/9.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Organization.h"
@protocol Project
@end
@interface Project : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,strong) NSString<Optional> *logoUrl;
@property (nonatomic ,assign) int organizationId;
@property (nonatomic ,assign) float price;
@property (nonatomic ,assign) float specialPrice;
@property (nonatomic ,strong) Organization<Optional> *organization;

@end
