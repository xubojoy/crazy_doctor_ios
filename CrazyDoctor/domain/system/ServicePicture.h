//
//  ExpertPicture.h
//  iUser
//
//  Created by System Administrator on 13-4-24.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//
 #import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "JSONSerializable.h"
#import "JSONModel.h"


@protocol ServicePicture
@end

@interface ServicePicture : JSONModel

@property int id;
@property (nonatomic, copy) NSString *fileUrl;//文件url
@property (nonatomic, copy) NSString *thumbnailUrl;//缩略图url
@property (nonatomic, copy) NSString *originUrl;//原图

@property (nonatomic, copy) NSString *thumbnailFileSize;
@property (nonatomic, copy) NSString *bigSize;
@property (nonatomic, copy) NSString *originSize;
@property int orderInx;//排序

-(CGSize) getBigCGSize;
-(CGSize) getThumbnailCGSize;
-(CGSize) getoriginSize;

@end
