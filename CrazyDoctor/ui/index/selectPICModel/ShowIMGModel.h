//
//  ShowIMGModel.h
//  selectPIC
//
//  Created by colorful-ios on 15/11/24.
//  Copyright © 2015年 7Color. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Photos/Photos.h>

@interface ShowIMGModel : NSObject

@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *bodyTagQuestions;
@property (nonatomic ,strong) NSString<Optional> *detailImageUrl;
@property (nonatomic ,strong) NSString<Optional> *logoUrl;

@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,strong) NSString<Optional> *nameUrl;
@property (nonatomic ,strong) NSString<Optional> *remark;
@property (nonatomic ,strong) NSString<Optional> *tongueImageUrl;

@property (nonatomic,assign) BOOL    selected;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
