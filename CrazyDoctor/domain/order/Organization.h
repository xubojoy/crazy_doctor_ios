//
//  Organization.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/9.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Organization
@end
@interface Organization : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,strong) NSString<Optional> *phone;
@property (nonatomic ,strong) NSString<Optional> *logoUrl;
@property (nonatomic ,strong) NSString<Optional> *intro;
@property (nonatomic ,strong) NSString<Optional> *projectFeatures;
@property (nonatomic ,strong) NSString<Optional> *address;

@end
