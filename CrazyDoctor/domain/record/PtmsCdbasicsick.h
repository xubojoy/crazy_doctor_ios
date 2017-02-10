//
//  PtmsCdbasicsick.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/13.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol PtmsCdbasicsick
@end
@interface PtmsCdbasicsick : JSONModel
@property (nonatomic ,strong) NSString<Optional> *expression;
@property (nonatomic ,strong) NSString<Optional> *xianbs;
@property (nonatomic ,strong) NSString<Optional> *gerens;
@property (nonatomic ,strong) NSString<Optional> *hunyins;
@property (nonatomic ,strong) NSString<Optional> *shengyus;
@property (nonatomic ,strong) NSString<Optional> *guoms;
@property (nonatomic ,assign) int pitc;
@property (nonatomic ,strong) NSString<Optional> *tzmc;
@property (nonatomic ,strong) NSString<Optional> *mxmc;
@property (nonatomic ,strong) NSString<Optional> *blNote1;
@property (nonatomic ,strong) NSString<Optional> *blNote2;
@property (nonatomic ,strong) NSString<Optional> *blNote3;
@property (nonatomic ,strong) NSString<Optional> *blNote4;

@end
