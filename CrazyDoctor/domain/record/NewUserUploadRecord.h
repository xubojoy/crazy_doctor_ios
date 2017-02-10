//
//  NewUserUploadRecord.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/15.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol NewUserUploadRecord
@end
@interface NewUserUploadRecord : JSONModel
@property (nonatomic ,assign) int userId;
@property (nonatomic ,strong) NSString<Optional> *userName;
@property (nonatomic ,strong) NSString<Optional> *hospital;
@property (nonatomic ,strong) NSString<Optional> *medicalRecordImageUrls;
@property (nonatomic ,strong) NSString<Optional> *prescriptionImageUrls;
@property (nonatomic ,strong) NSString<Optional> *conclusionImageUrls;

@property (nonatomic ,strong) NSString<Optional> *otherImageUrls;
@property (nonatomic ,strong) NSString<Optional> *remark;
@property (nonatomic ,assign) long long int diagnoseTime;
@end
