//
//  UserStore.h
//  Golf
//
//  Created by xubojoy on 15/3/30.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Page.h"
#import "UserUploadRecord.h"
#import "NewUserUploadRecord.h"
#import "UserAccount.h"
#import "UserAccountRecharge.h"
#import "UserAccountCash.h"
#import "NewSharkeyData.h"
#import "SharkeyData.h"
#import "SharkeySort.h"
#import "RedEnvelope.h"
#import "ProjectOrder.h"
#import "DoctorOrder.h"
@interface UserStore : NSObject
+ (UserStore *) sharedStore;

//忘记密码重新获取
-(void) requestTempPwd:(void (^)(NSError *err))completionBlock mobileNo:(NSString *)mobileNo;


//普通登陆
-(void) login:(void (^)(User *user, NSError *err))completionBlock mobileNo:(NSString *) mobileNo pwd:(NSString *)pwd;

//退出登陆
-(void) removeSession:(void (^)(NSError *err))completionBlock accessToken:(NSString *)accessToken;


//上传图片
-(void) upLoadImg:(void(^)(NSString *imgUrl, NSError *err))completionBlock tongueImage:(UIImage *)image;


//修改用户信息
-(void) updateUserInfo:(void (^)(User *user ,NSError *err))completionBlock
                userId:(int)userId
                  name:(NSString *)name
             avatarUrl:(NSString *)avatarUrl
            userGender:(int)userGender
           userSetCity:(NSString *)userSetCity
            userRoleId:(int)userRoleId
           receivePush:(BOOL)receivePush
             pushTimes:(NSString *)pushTimes
               userJob:(NSString *)userJob
              userType:(int)userType
              realName:(NSString *)realName
             birthCity:(NSString *)birthCity
             userMarry:(BOOL)userMarry
              birthday:(NSString *)birthday
            userHeight:(float)userHeight
            userWeight:(float)userWeight
              userIDNo:(NSString *)userIDNo
    pastMedicalHistory:(NSString *)pastMedicalHistory;

//修改用户头像
-(void) updateAvatar:(void (^)(NSError *err))completionBlock userId:(int)userId avatarImage:(UIImage *)avatarImage;

//修改密码
-(void) updatePwd:(void(^)(NSError *err))completionBlock userId:(NSString *)userId pwd:(NSString *)pwd oldPwd:(NSString *)oldPwd;


- (void) getUserInfo:(void (^)(User *user, NSError *err))completionBlock;


+ (void)getMyDiagnosticsRecordList:(void(^)(Page *page ,NSError *error))completionBlock userId:(int)userId pageNo:(int)pageNo pageSize:(int)pageSize;

+(void) getMyDoctor:(void(^)(NSDictionary *myDoctorDic, NSError *err))completionBlock medname:(NSString *)medname password:(NSString *)password;
//MyPhysiotherapy

+(void) getMyPhysiotherapy:(void(^)(NSDictionary *myPhysiotherapyDict, NSError *err))completionBlock medname:(NSString *)medname password:(NSString *)password;


+(void) confirmUserUploadRecord:(void(^)(UserUploadRecord *userUploadRecord, NSError *err))completionBlock newUserUploadRecord:(NewUserUploadRecord *)newUserUploadRecord;

+ (void)getOtherHospitalRecordList:(void(^)(Page *page ,NSError *error))completionBlock userId:(int)userId pageNo:(int)pageNo pageSize:(int)pageSize;


+ (void) confirmCollectionArticle:(void(^)(NSDictionary *collectionDict, NSError *err))completionBlock articleId:(int)articleId;

+ (void) checkUserCollectionArticle:(void(^)(NSDictionary *collectionDict, NSError *err))completionBlock articleId:(int)articleId;

+ (void)getAllUserCollectionArticles:(void(^)(Page *page ,NSError *error))completionBlock pageNo:(int)pageNo pageSize:(int)pageSize;

+ (void) getSystemInfo:(void(^)(NSDictionary *systemInfoDict, NSError *err))completionBlock;


+ (void) getAllCommonDisease:(void(^)(NSArray *diseaseArray, NSError *err))completionBlock;


+ (void) getUserAccount:(void(^)(UserAccount *userAccount, NSError *err))completionBlock;

+ (void) userAccountRecharges:(void(^)(UserAccountRecharge *userAccountRecharge, NSError *err))completionBlock price:(float)price;
+ (void) userAccountCashs:(void(^)(UserAccountCash *userAccountCash, NSError *err))completionBlock price:(float)price accountNo:(NSString *)accountNo accountName:(NSString *)accountName;

+(void) weiXinPayOrderClub:(void(^)(NSDictionary *weixinPayInfo, NSError *err))completionBlock payAmount:(float)payAmount orderNum:(NSString *)orderNum buyer:(NSString *)buyer desc:(NSString *)desc tradeType:(NSString *)tradeType type:(NSString *)type;

+(void) aliPayOrderClub:(void(^)(NSDictionary *aliPayInfo, NSError *err))completionBlock WIDtotal_fee:(float)WIDtotal_fee WIDout_trade_no:(NSString *)WIDout_trade_no WIDshow_url:(NSString *)WIDshow_url WIDsubject:(NSString *)WIDsubject WIDbody:(NSString *)WIDbody;

+(void) syncSharkeyData:(void(^)(SharkeyData *sharkeyData, NSError *err))completionBlock NewSharkeyData:(NewSharkeyData *)newSharkeyData;

+ (void)getUserSportRank:(void(^)(Page *page ,NSError *error))completionBlock pageNo:(int)pageNo pageSize:(int)pageSize type:(NSString *)type;

+ (void)getMySportRank:(void(^)(SharkeySort *sharkeySort ,NSError *error))completionBlock type:(NSString *)type;

+ (void)getAllSharkeyData:(void(^)(NSMutableArray *sharkeyDataArray ,NSError *error))completionBlock beginTime:(NSString *)beginTime endTime:(NSString *)endTime;
+ (void)getSomeDaySharkeyData:(void(^)(SharkeyData *sharkeyData ,NSError *error))completionBlock createTime:(NSString *)createTime;

+ (void)getAllUnusedRedEnvelope:(void(^)(NSMutableArray *redEnvelopeArray ,NSError *error))completionBlock status:(NSString *)status;

+ (void)getProjectOrderById:(void(^)(ProjectOrder *projectOrder ,NSError *error))completionBlock projectOrderIdArray:(NSArray *)projectOrderIdArray;
+ (void)getDoctorOrderById:(void(^)(DoctorOrder *doctorOrder ,NSError *error))completionBlock doctorOrderIdArray:(NSArray *)doctorOrderIdArray;

+ (void) userDeleteFavArticle:(void(^)(NSError *err))completionBlock articleId:(int)articleId;


@end
