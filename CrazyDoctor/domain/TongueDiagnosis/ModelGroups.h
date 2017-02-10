//
//  ModelGroups.h
//  JFList
//
//  Created by 李俊峰 on 16/2/28.
//  Copyright © 2016年 李俊峰. All rights reserved.
//

#import "ModelBase.h"

@interface ModelGroups : ModelBase

@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *bodyTagQuestions;
@property (nonatomic ,strong) NSString<Optional> *detailImageUrl;
@property (nonatomic ,strong) NSString<Optional> *logoUrl;

@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,strong) NSString<Optional> *nameUrl;
@property (nonatomic ,strong) NSString<Optional> *remark;
@property (nonatomic ,strong) NSString<Optional> *tongueImageUrl;
@property (nonatomic, strong) NSArray<Optional> *groups;
/**
 *  记录这行是否被打开
 */
@property (nonatomic, getter=isOpen) BOOL isOpen;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
