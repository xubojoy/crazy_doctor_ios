//
//  TongueList.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/4/26.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TongueList
@end
@interface TongueList : JSONModel
@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString<Optional> *bodyTagQuestions;
@property (nonatomic ,strong) NSString<Optional> *detailImageUrl;
@property (nonatomic ,strong) NSString<Optional> *logoUrl;

@property (nonatomic ,strong) NSString<Optional> *name;
@property (nonatomic ,strong) NSString<Optional> *nameUrl;
@property (nonatomic ,strong) NSString<Optional> *remark;
@property (nonatomic ,strong) NSString<Optional> *tongueImageUrl;


@end
