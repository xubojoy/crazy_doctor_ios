//
//  UserStore.h
//  Golf
//
//  Created by xubojoy on 15/3/30.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//
#define gender_female 0
#define gender_male 1

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"


@interface User : NSObject<JSONSerializable, NSCopying, NSCoding>

@property (nonatomic ,assign) int id;
@property (nonatomic ,strong) NSString *age;
@property (nonatomic, strong) NSString *name;
@property (nonatomic ,strong) NSString *realName;
@property (nonatomic, strong) NSString *userCode;
@property (nonatomic ,assign) int userType;
@property (nonatomic ,assign) BOOL userMarry;
@property (nonatomic ,strong) NSString *birthday;
@property (nonatomic ,assign) float userHeight;
@property (nonatomic ,assign) float userWeight;
@property (nonatomic ,strong) NSString *birthCity;
@property (nonatomic ,strong) NSString *userIDNo;
@property (nonatomic ,strong) NSString *pastMedicalHistory;
//默认为女的即0 男 1
@property (nonatomic, assign) int userGender;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *accessToken;
@property (nonatomic, strong) NSString *mobileNo;
@property (nonatomic ,assign) int userRoleId;
@property (nonatomic ,strong) NSString *userSetCity;
@property (nonatomic ,strong) NSString *devices;//用户所使用的设备ID集合
@property (nonatomic ,assign) BOOL receivePush;//用户是否接收PUSH
@property (nonatomic ,strong) NSString *pushTimes;// 用户接收PUSH的时间点，多个时间点用逗号隔开
@property (nonatomic ,strong) NSString *bodyTagNames;//用户的体质
@property (nonatomic ,strong) NSString *eyeTagNames;
@property (nonatomic ,strong) NSString *userJob;//用户职业

@property (nonatomic, retain) NSMutableSet *favArticleIds;
@property (nonatomic, retain) NSMutableSet *readArticleIds;


-(NSString *)genderTxt;

-(void) addFavArticle:(int)articleId;
-(void) removeFavArticle:(int)articleId;
-(BOOL) hasAddFavArticle:(int)articleId;


-(void) addReadArticle:(int)recommendId;
-(BOOL) hasReadFavArticle:(int)recommendId;

@end
