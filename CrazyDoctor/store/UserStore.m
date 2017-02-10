//
//  UserStore.m
//  Golf
//
//  Created by xubojoy on 15/3/30.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//

#import "UserStore.h"
#import "JSONKit.h"
#import "User.h"
@implementation UserStore
+ (UserStore *) sharedStore{
    static UserStore *userStore = nil;
    if(!userStore){
        userStore = [[super allocWithZone:nil] init];
    }
    
    return userStore;
}

+(id) allocWithZone:(NSZone *)zone{
    return [self sharedStore];
}

-(void) requestTempPwd:(void (^)(NSError *err))completionBlock mobileNo:(NSString *)mobileNo{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:mobileNo forKey:@"mobileNo"];
    
    [requestFacade post:[NSString stringWithFormat:@"%@/tempPwds",[AppStatus sharedInstance].apiUrl] completionBlock:^(id json, NSError *err) {
        completionBlock(err);
    } commonParams:params];
}

///userSessions/mob
-(void) login:(void (^)(User *user, NSError *err))completionBlock mobileNo:(NSString *) mobileNo pwd:(NSString *)pwd{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:pwd forKey:@"pwd"];
    [params setObject:mobileNo forKey:@"mobileNo"];
    [params setObject:@"ios" forKey:@"env"];
    [requestFacade post:[NSString stringWithFormat:@"%@/userSessions",[AppStatus sharedInstance].apiUrl]  completionBlock:^(id json, NSError *err) {
        NSLog(@"user login result:%@", json);
        if(json != nil){
            NSDictionary *dic = json;
            User *user = [[User alloc] init];
            [user readFromJSONDictionary:dic];
            
            AppStatus *as = [AppStatus sharedInstance];
            as.user = user;
            [AppStatus saveAppStatus];
            completionBlock(user, err);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } commonParams:params];
}

-(void) removeSession:(void (^)(NSError *err))completionBlock accessToken:(NSString *)accessToken{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if ([NSStringUtils isNotBlank:accessToken]) {
        [params setObject:accessToken forKey:@"accessToken"];
    }
    [requestFacade delete:@"/mySession" completionBlock:^(id json, NSError *err) {
        AppStatus *as = [AppStatus sharedInstance];
        as.user = nil;
        [AppStatus saveAppStatus];
        completionBlock(err);
    } param:params];
}

-(void) upLoadImg:(void(^)(NSString *imgUrl, NSError *err))completionBlock tongueImage:(UIImage *)image{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:image forKey:@"image"];
    [requestFacade post:[NSString stringWithFormat:@"%@/images/upload",[AppStatus sharedInstance].apiUrl] completionBlock:^(id json, NSError *err) {
        if(err == nil){
            NSString *imgUrl = json;
            NSLog(@"更新成功--%@",imgUrl);
            completionBlock(imgUrl,nil);
        }else{
            completionBlock(nil,err);
        }
    } params:params];
}


-(void)updateUserInfo:(void (^)(User *user ,NSError *))completionBlock
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
   pastMedicalHistory:(NSString *)pastMedicalHistory{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:name forKey:@"name"];
    [params setObject:avatarUrl forKey:@"avatarUrl"];
    [params setObject:@(userGender) forKey:@"userGender"];
    [params setObject:userSetCity forKey:@"userSetCity"];
    [params setObject:@(userRoleId) forKey:@"userRoleId"];
    [params setObject:@(receivePush) forKey:@"receivePush"];
    [params setObject:pushTimes forKey:@"pushTimes"];
    [params setObject:userJob forKey:@"userJob"];
    [params setObject:@(userType) forKey:@"userType"];
    [params setObject:realName forKey:@"realName"];
    [params setObject:birthCity forKey:@"birthCity"];
    [params setObject:@(userMarry) forKey:@"userMarry"];
    [params setObject:birthday forKey:@"birthday"];
    [params setObject:@(userHeight) forKey:@"userHeight"];
    [params setObject:@(userWeight) forKey:@"userWeight"];
    [params setObject:userIDNo forKey:@"userIDNo"];
    [params setObject:pastMedicalHistory forKey:@"pastMedicalHistory"];
    
    
    [requestFacade put:[NSString stringWithFormat:@"%@/users/%d/info",[AppStatus sharedInstance].apiUrl, userId] completionBlock:^(id json, NSError *err) {
        if(err == nil){
            NSDictionary *dic = json;
            User *user = [[User alloc] init];
            [user readFromJSONDictionary:dic];
            
            AppStatus *as = [AppStatus sharedInstance];
            as.user.name = name;
            as.user.avatarUrl = user.avatarUrl;
            as.user.pushTimes = user.pushTimes;
            [AppStatus saveAppStatus];
            completionBlock(user ,nil);
        }else{
            completionBlock(nil ,err);
        }
    } params:params];
}


-(void) updateAvatar:(void (^)(NSError *))completionBlock userId:(int)userId avatarImage:(UIImage *)avatarImage{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:avatarImage forKey:@"avatar"];
    [requestFacade post:[NSString stringWithFormat:@"%@/users/%d/avatar",[AppStatus sharedInstance].apiUrl, userId] completionBlock:^(id json, NSError *err) {
        if(err == nil){
            NSDictionary *dic = json;
            User *user = [[User alloc] init];
            [user readFromJSONDictionary:dic];
            
            AppStatus *as = [AppStatus sharedInstance];
            as.user.avatarUrl = user.avatarUrl;
            [AppStatus saveAppStatus];
            NSLog(@"更新成功");
            completionBlock(nil);
        }else{
            completionBlock(err);
        }
    } params:params];
}

-(void) updatePwd:(void(^)(NSError *err))completionBlock userId:(NSString *)userId pwd:(NSString *)pwd oldPwd:(NSString *)oldPwd{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:pwd forKey:@"pwd"];
    [params setObject:oldPwd forKey:@"oldPwd"];
    
    [requestFacade put:[NSString stringWithFormat:@"%@/users/%@/info", [AppStatus sharedInstance].apiUrl,userId] completionBlock:^(NSString *json, NSError *err) {
        if(err == nil){
            NSDictionary *dic = [json objectFromJSONString];
            AppStatus *as = [AppStatus sharedInstance];
            as.user.accessToken = [dic objectForKey:@"accessToken"];
            [AppStatus saveAppStatus];
        }
        completionBlock(err);
    } params:params];
}

- (void) getUserInfo:(void (^)(User *user, NSError *err))completionBlock{

    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/myUserInfo",[AppStatus sharedInstance].apiUrl];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request asiDoGet:urlStr completionBlock:^(NSString *json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>>>游戏币数据json：%@",json);
        if (err == nil) {
            NSDictionary *dic = [json objectFromJSONString];
            User *user = [[User alloc] init];
            [user readFromJSONDictionary:dic];
            completionBlock(user, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}


+ (void)getMyDiagnosticsRecordList:(void(^)(Page *page ,NSError *error))completionBlock userId:(int)userId pageNo:(int)pageNo pageSize:(int)pageSize{

    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/diagnoseLogs?userId=%d&pageNo=%d&pageSize=%d",[AppStatus sharedInstance].apiUrl,userId,pageNo,pageSize];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>>>游戏数据json：%@",json);
        if (err == nil) {
            NSDictionary *jsonDict = json;
            Page *page = [[Page alloc] initWithJSONDictionary:jsonDict];
            NSArray *jsonDictArray = [jsonDict objectForKey:@"items"];
            page.items = jsonDictArray;
            completionBlock(page, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}


+(void) getMyDoctor:(void(^)(NSDictionary *myDoctorDic, NSError *err))completionBlock medname:(NSString *)medname password:(NSString *)password{

    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:medname forKey:@"medname"];
    [params setObject:password forKey:@"password"];
    [requestFacade asiPost:@"http://218.249.44.54:8080/intelet_middleservice/hisInfo" completionBlock:^(NSString *json, NSError *err) {
        if(err == nil){
//            NSLog(@">jsonjsonjsonjson>>>%@",json);
           
            NSDictionary *myDoctorDic = [json objectFromJSONString];
            completionBlock(myDoctorDic ,nil);
        }else{
            completionBlock(nil ,err);
        }
    } params:params];
}

+(void) getMyPhysiotherapy:(void(^)(NSDictionary *myPhysiotherapyDict, NSError *err))completionBlock medname:(NSString *)medname password:(NSString *)password{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:medname forKey:@"medname"];
    [params setObject:password forKey:@"password"];
    [requestFacade asiPost:@"http://218.249.44.54:8080/intelet_middleservice/ptmsInfo" completionBlock:^(NSString *json, NSError *err) {
        if(err == nil){
            //            NSLog(@">jsonjsonjsonjson>>>%@",json);
            
            NSDictionary *myDoctorDic = [json objectFromJSONString];
            completionBlock(myDoctorDic ,nil);
        }else{
            completionBlock(nil ,err);
        }
    } params:params];
}

+(void) confirmUserUploadRecord:(void(^)(UserUploadRecord *userUploadRecord, NSError *err))completionBlock newUserUploadRecord:(NewUserUploadRecord *)newUserUploadRecord{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/userUploadRecords",[AppStatus sharedInstance].apiUrl];
    [requestFacade post:url completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>doctor>>>>>>>>>%@",json);
        if (err == nil) {
            NSDictionary *dic = json;
            UserUploadRecord *userUploadRecord = [[UserUploadRecord alloc] initWithDictionary:dic error:nil];
            NSLog(@">>>>>>>>>添加返回值userUploadRecord>>>>>>>>>%@",userUploadRecord);
            completionBlock(userUploadRecord, nil);
        }else if (err != nil){
            completionBlock(nil, err);
        }
    } jsonString:[newUserUploadRecord toDictionary]];
}

+ (void)getOtherHospitalRecordList:(void(^)(Page *page ,NSError *error))completionBlock userId:(int)userId pageNo:(int)pageNo pageSize:(int)pageSize{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/userUploadRecords?userId=%d&pageNo=%d&pageSize=%d",[AppStatus sharedInstance].apiUrl,userId,pageNo,pageSize];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>>>游戏数据json：%@",json);
        if (err == nil) {
            NSDictionary *jsonDict = json;
            Page *page = [[Page alloc] initWithJSONDictionary:jsonDict];
            NSArray *jsonDictArray = [jsonDict objectForKey:@"items"];
            page.items = jsonDictArray;
            completionBlock(page, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void) confirmCollectionArticle:(void(^)(NSDictionary *collectionDict, NSError *err))completionBlock articleId:(int)articleId{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    [requestFacade asiPost:[NSString stringWithFormat:@"%@/articles/%d/fav",[AppStatus sharedInstance].apiUrl,articleId]  completionBlock:^(NSString *json, NSError *err) {
        NSLog(@"收藏文章:%@", json);
        if(json != nil){
            NSDictionary *dic = [json objectFromJSONString];
            completionBlock(dic, err);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } params:nil];
}

+ (void) checkUserCollectionArticle:(void(^)(NSDictionary *collectionDict, NSError *err))completionBlock articleId:(int)articleId{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *urlStr = [NSString stringWithFormat:@"%@/articles/%d/fav",[AppStatus sharedInstance].apiUrl,articleId];
    NSURL *url = [NSURL URLWithString:urlStr];
    [request doGet:url completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *collectionDict = json;
            NSLog(@">>>>>>>>>>>>collectionDict>>>>>>>>>%@",collectionDict);
            completionBlock(collectionDict, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void)getAllUserCollectionArticles:(void(^)(Page *page ,NSError *error))completionBlock pageNo:(int)pageNo pageSize:(int)pageSize{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/articles/fav?pageNo=%d&pageSize=%d",[AppStatus sharedInstance].apiUrl,pageNo,pageSize];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>>货物收藏文章json：%@",json);
        if (err == nil) {
            NSDictionary *jsonDict = json;
            Page *page = [[Page alloc] initWithJSONDictionary:jsonDict];
            NSArray *jsonDictArray = [jsonDict objectForKey:@"items"];
            page.items = jsonDictArray;
            completionBlock(page, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void) getSystemInfo:(void(^)(NSDictionary *systemInfoDict, NSError *err))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/systemInfo",[AppStatus sharedInstance].apiUrl];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSDictionary *systemInfoDict = json;
            completionBlock(systemInfoDict, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void) getAllCommonDisease:(void(^)(NSArray *diseaseArray, NSError *err))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/pathologyTypes",[AppStatus sharedInstance].apiUrl];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        if (err == nil) {
            NSArray *diseaseArray = (NSArray *)json;
            completionBlock(diseaseArray, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void) getUserAccount:(void(^)(UserAccount *userAccount, NSError *err))completionBlock{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/userAccount",[AppStatus sharedInstance].apiUrl];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>用户账户json：%@",json);
        if (err == nil) {
            NSDictionary *userAccountDict = json;
            UserAccount *userAccount = [[UserAccount alloc] initWithDictionary:userAccountDict error:nil];
            completionBlock(userAccount, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void) userAccountRecharges:(void(^)(UserAccountRecharge *userAccountRecharge, NSError *err))completionBlock price:(float)price{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@(price) forKey:@"price"];
    [requestFacade post:[NSString stringWithFormat:@"%@/userAccountRecharges",[AppStatus sharedInstance].apiUrl] completionBlock:^(id json, NSError *err) {
        if(err == nil){
            NSLog(@">>>>>>>>>充值json：%@",json);
            NSDictionary *userAccountDict = json;
            UserAccountRecharge *userAccountRecharge = [[UserAccountRecharge alloc] initWithDictionary:userAccountDict error:nil];
            completionBlock(userAccountRecharge,nil);
        }else{
            completionBlock(nil,err);
        }
    } params:params];
}


+ (void) userAccountCashs:(void(^)(UserAccountCash *userAccountCash, NSError *err))completionBlock price:(float)price accountNo:(NSString *)accountNo accountName:(NSString *)accountName{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@(price) forKey:@"price"];
    [params setObject:accountNo forKey:@"accountNo"];
    [params setObject:accountName forKey:@"accountName"];
    [requestFacade post:[NSString stringWithFormat:@"%@/userAccountCashs",[AppStatus sharedInstance].apiUrl] completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>提现json：%@",json);
        if(err == nil){
            NSDictionary *userAccountDict = json;
            UserAccountCash *userAccountCash = [[UserAccountCash alloc] initWithDictionary:userAccountDict error:nil];
            completionBlock(userAccountCash,nil);
        }else{
            completionBlock(nil,err);
        }
    } params:params];
}

+(void) weiXinPayOrderClub:(void(^)(NSDictionary *weixinPayInfo, NSError *err))completionBlock payAmount:(float)payAmount orderNum:(NSString *)orderNum buyer:(NSString *)buyer desc:(NSString *)desc tradeType:(NSString *)tradeType type:(NSString *)type{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%f",payAmount] forKey:@"payAmount"];
    [params setObject:orderNum forKey:@"orderNum"];
    [params setObject:buyer forKey:@"buyer"];
    [params setObject:desc forKey:@"desc"];
    [params setObject:tradeType forKey:@"tradeType"];
    [params setObject:type forKey:@"type"];
    [params setObject:@"ios" forKey:@"env"];
    NSLog(@">>>>>>>>>>>>>>>>%@",params);
    [requestFacade post:[NSString stringWithFormat:@"%@/tenpay",[AppStatus sharedInstance].paymentUrl] completionBlock:^(id json, NSError *err) {
        if(json != nil){
            NSLog(@"payment result:%@", json);
            NSDictionary *weixinPayInfo = json;
            completionBlock(weixinPayInfo, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } params:params];
}


+(void) aliPayOrderClub:(void(^)(NSDictionary *aliPayInfo, NSError *err))completionBlock WIDtotal_fee:(float)WIDtotal_fee WIDout_trade_no:(NSString *)WIDout_trade_no WIDshow_url:(NSString *)WIDshow_url WIDsubject:(NSString *)WIDsubject WIDbody:(NSString *)WIDbody{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[NSString stringWithFormat:@"%f",WIDtotal_fee] forKey:@"WIDtotal_fee"];
    [params setObject:WIDout_trade_no forKey:@"WIDout_trade_no"];
    [params setObject:WIDshow_url forKey:@"WIDshow_url"];
    [params setObject:WIDsubject forKey:@"WIDsubject"];
    [params setObject:WIDbody forKey:@"WIDbody"];
    [params setObject:@"ios" forKey:@"env"];
    NSLog(@">>>>>>>>>>>>>>>>%@",params);
    [requestFacade post:[NSString stringWithFormat:@"%@/alipay/alipayapi.jsp",[AppStatus sharedInstance].paymentUrl] completionBlock:^(id json, NSError *err) {
        if(json != nil){
            NSLog(@"payment result:%@", json);
            NSDictionary *weixinPayInfo = json;
            completionBlock(weixinPayInfo, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } commonParams:params];
}

+(void) syncSharkeyData:(void(^)(SharkeyData *sharkeyData, NSError *err))completionBlock NewSharkeyData:(NewSharkeyData *)newSharkeyData{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/sharkeyData",[AppStatus sharedInstance].apiUrl];
    [requestFacade post:url completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>sharkeyData>>>>>>>>>%@",json);
        if (err == nil) {
            NSDictionary *dic = json;
            NSLog(@">>>>>>>>>dic>>>>>>>>>%@",dic);
            SharkeyData *sharkeyData = [[SharkeyData alloc] initWithDictionary:dic error:nil];
            NSLog(@">>>>>>>>>添加返回值sharkeyData>>>>>>>>>%@",sharkeyData);
            completionBlock(sharkeyData, nil);
        }else if (err != nil){
            completionBlock(nil, err);
        }
    } jsonString:[newSharkeyData toDictionary]];
}

+ (void)getUserSportRank:(void(^)(Page *page ,NSError *error))completionBlock pageNo:(int)pageNo pageSize:(int)pageSize type:(NSString *)type{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/sharkeyDatas/sort?type=%@&pageNo=%d&pageSize=%d&cacheFlag=NO",[AppStatus sharedInstance].apiUrl,type,pageNo,pageSize];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>>货物收藏文章json：%@",json);
        if (err == nil) {
            NSDictionary *jsonDict = json;
            Page *page = [[Page alloc] initWithJSONDictionary:jsonDict];
            NSArray *jsonDictArray = [jsonDict objectForKey:@"items"];
            page.items = jsonDictArray;
            completionBlock(page, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void)getMySportRank:(void(^)(SharkeySort *sharkeySort ,NSError *error))completionBlock type:(NSString *)type{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/sharkeyDatas/myselfSort?type=%@",[AppStatus sharedInstance].apiUrl,type];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>>我的排名：%@",json);
        if (err == nil) {
            NSDictionary *jsonDict = json;
            SharkeySort *sharkeySort = [[SharkeySort alloc] initWithDictionary:jsonDict error:nil];
            completionBlock(sharkeySort, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void)getAllSharkeyData:(void(^)(NSMutableArray *sharkeyDataArray ,NSError *error))completionBlock beginTime:(NSString *)beginTime endTime:(NSString *)endTime{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/sharkeyDatas?beginTime=%@&endTime=%@",[AppStatus sharedInstance].apiUrl,beginTime,endTime];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>>所有数据：%@",json);
        if (err == nil) {
            NSMutableArray *sharkeyDataArray = (NSMutableArray *)json;
            completionBlock(sharkeyDataArray, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void)getSomeDaySharkeyData:(void(^)(SharkeyData *sharkeyData ,NSError *error))completionBlock createTime:(NSString *)createTime{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/sharkeyData/%@",[AppStatus sharedInstance].apiUrl,createTime];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>某一台数据：%@",json);
        if (err == nil) {
            NSDictionary *sharkeyDataDict = (NSDictionary *)json;
            SharkeyData *sharkeyData = [[SharkeyData alloc] initWithDictionary:sharkeyDataDict error:nil];
            completionBlock(sharkeyData, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void)getAllUnusedRedEnvelope:(void(^)(NSMutableArray *redEnvelopeArray ,NSError *error))completionBlock status:(NSString *)status{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/redEnvelopes?status=%@",[AppStatus sharedInstance].apiUrl,status];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>优惠券数据：%@",json);
        if (err == nil) {
            NSMutableArray *redEnvelopeArray = (NSMutableArray *)json;
            completionBlock(redEnvelopeArray, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}
///projectOrders/
+ (void)getProjectOrderById:(void(^)(ProjectOrder *projectOrder ,NSError *error))completionBlock projectOrderIdArray:(NSArray *)projectOrderIdArray{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/projectOrders/%@",[AppStatus sharedInstance].apiUrl,[projectOrderIdArray componentsJoinedByString:@","]];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>优惠券数据：%@",json);
        if (err == nil) {
            NSDictionary *projectOrderDict = (NSDictionary *)json;
            ProjectOrder *projectOrder = [[ProjectOrder alloc] initWithDictionary:projectOrderDict error:nil];
            completionBlock(projectOrder, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void)getDoctorOrderById:(void(^)(DoctorOrder *doctorOrder ,NSError *error))completionBlock doctorOrderIdArray:(NSArray *)doctorOrderIdArray{
    HttpRequestFacade *request = [HttpRequestFacade sharedInstance];
    NSString *url = [NSString stringWithFormat:@"%@/doctorOrders/%@",[AppStatus sharedInstance].apiUrl,[doctorOrderIdArray componentsJoinedByString:@","]];
    NSURL *urlStr = [NSURL URLWithString:url];
    [request doGet:urlStr completionBlock:^(id json, NSError *err) {
        NSLog(@">>>>>>>>>>>>>>数据：%@",json);
        if (err == nil) {
            NSDictionary *doctorOrderDict = (NSDictionary *)json;
            DoctorOrder *doctorOrder = [[DoctorOrder alloc] initWithDictionary:doctorOrderDict error:nil];
            completionBlock(doctorOrder, nil);
        }else if(err != nil){
            completionBlock(nil, err);
        }
    } refresh:NO useCacheIfNetworkFail:NO];
}

+ (void) userDeleteFavArticle:(void(^)(NSError *err))completionBlock articleId:(int)articleId{
    HttpRequestFacade *requestFacade = [HttpRequestFacade sharedInstance];
    NSString *urlStr = [NSString stringWithFormat:@"/articles/%d/fav",articleId];
    [requestFacade delete:urlStr completionBlock:^(id json, NSError *err) {
        if(err == nil){
            completionBlock(nil);
        }else{
            completionBlock(err);
        }
    } param:nil];
}


@end
