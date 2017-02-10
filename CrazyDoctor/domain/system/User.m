//
//  UserStore.h
//  Golf
//
//  Created by xubojoy on 15/3/30.
//  Copyright (c) 2015年 xubojoy. All rights reserved.
//
#import "User.h"
@implementation User

-(NSString *)genderTxt{
    if(self.userGender == gender_male){
        return @"男";
    }
    return @"女";
}

-(void) addFavArticle:(int)articleId{
    if(self.favArticleIds == nil){
        self.favArticleIds = [[NSMutableSet alloc] init];
    }
    NSMutableSet *articleIds = [[NSMutableSet alloc] initWithSet:self.favArticleIds];
    [articleIds addObject:@(articleId)];
    self.favArticleIds = articleIds;
}
-(void) removeFavArticle:(int)articleId{
    NSMutableSet *articleIds = [[NSMutableSet alloc] init];
    for (NSNumber *favId in self.favArticleIds) {
        if([favId intValue] != articleId){
            [articleIds addObject:favId];
        }
    }
    self.favArticleIds = articleIds;

}
-(BOOL) hasAddFavArticle:(int)articleId{
    if(self.favArticleIds != nil){
        for (NSNumber *favId in self.favArticleIds) {
            if([favId intValue] == articleId){
                return YES;
            }
        }
    }
    return NO;
}


-(void) addReadArticle:(int)recommendId{
    if(self.readArticleIds == nil){
        self.readArticleIds = [[NSMutableSet alloc] init];
    }
    NSMutableSet *articleIds = [[NSMutableSet alloc] initWithSet:self.readArticleIds];
    [articleIds addObject:@(recommendId)];
    self.readArticleIds = articleIds;
}
-(BOOL) hasReadFavArticle:(int)recommendId{
    if(self.readArticleIds != nil){
        for (NSNumber *favId in self.readArticleIds) {
            if([favId intValue] == recommendId){
                return YES;
            }
        }
    }
    return NO;
}

-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt:self.id forKey:@"id"];
    [aCoder encodeObject:self.age forKey:@"age"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.userGender forKey:@"userGender"];
    [aCoder encodeObject:self.avatarUrl forKey:@"avatarUrl"];
    [aCoder encodeObject:self.accessToken forKey:@"accessToken"];
    [aCoder encodeObject:self.mobileNo forKey:@"mobileNo"];
    [aCoder encodeObject:self.userCode forKey:@"userCode"];
    [aCoder encodeInt:self.userRoleId forKey:@"userRoleId"];
    [aCoder encodeObject:self.userSetCity forKey:@"userSetCity"];
    [aCoder encodeObject:self.devices forKey:@"devices"];
    [aCoder encodeBool:self.receivePush forKey:@"receivePush"];
    [aCoder encodeObject:self.pushTimes forKey:@"pushTimes"];
    [aCoder encodeObject:self.bodyTagNames forKey:@"bodyTagNames"];
    [aCoder encodeObject:self.eyeTagNames forKey:@"eyeTagNames"];
    [aCoder encodeObject:self.userJob forKey:@"userJob"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeInt:self.userType forKey:@"userType"];
    [aCoder encodeBool:self.userMarry forKey:@"userMarry"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeFloat:self.userHeight forKey:@"userHeight"];
    [aCoder encodeFloat:self.userWeight forKey:@"userWeight"];
    [aCoder encodeObject:self.birthCity forKey:@"birthCity"];
    [aCoder encodeObject:self.userIDNo forKey:@"userIDNo"];
    [aCoder encodeObject:self.pastMedicalHistory forKey:@"pastMedicalHistory"];
    if(self.favArticleIds != nil){
        [aCoder encodeObject:self.favArticleIds forKey:@"favArticleIds"];
    }
    
    if(self.readArticleIds != nil){
        [aCoder encodeObject:self.favArticleIds forKey:@"readArticleIds"];
    }
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    if(self){
        self.id = [aDecoder decodeIntForKey:@"id"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.userGender = [aDecoder decodeIntForKey:@"userGender"];
        self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
        self.accessToken = [aDecoder decodeObjectForKey:@"accessToken"];
        self.mobileNo = [aDecoder decodeObjectForKey:@"mobileNo"];
        self.userCode = [aDecoder decodeObjectForKey:@"userCode"];
        self.userRoleId = [aDecoder decodeIntForKey:@"userRoleId"];
        self.userSetCity = [aDecoder decodeObjectForKey:@"userSetCity"];
        self.devices = [aDecoder decodeObjectForKey:@"devices"];
        self.receivePush = [aDecoder decodeBoolForKey:@"receivePush"];
        self.pushTimes = [aDecoder decodeObjectForKey:@"pushTimes"];
        self.bodyTagNames = [aDecoder decodeObjectForKey:@"bodyTagNames"];
        self.eyeTagNames = [aDecoder decodeObjectForKey:@"eyeTagNames"];
        self.userJob = [aDecoder decodeObjectForKey:@"userJob"];
        self.realName = [aDecoder decodeObjectForKey:@"realName"];
        self.userType = [aDecoder decodeIntForKey:@"userType"];
        self.userMarry = [aDecoder decodeBoolForKey:@"userMarry"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.userHeight = [aDecoder decodeFloatForKey:@"userHeight"];
        self.userWeight = [aDecoder decodeFloatForKey:@"userWeight"];
        self.birthCity = [aDecoder decodeObjectForKey:@"birthCity"];
        self.userIDNo = [aDecoder decodeObjectForKey:@"userIDNo"];
        self.pastMedicalHistory = [aDecoder decodeObjectForKey:@"pastMedicalHistory"];
        self.favArticleIds = [aDecoder decodeObjectForKey:@"favArticleIds"];
        self.readArticleIds = [aDecoder decodeObjectForKey:@"readArticleIds"];
    }
    
    return self;
}

- (void) readFromJSONDictionary:(NSDictionary *)jsonDict{
    [self setId:[[jsonDict objectForKey:@"id"] intValue]];
    [self setAge:[jsonDict objectForKey:@"age"]];
    [self setName:[jsonDict objectForKey:@"name"]];
    [self setUserGender:[[jsonDict objectForKey:@"userGender"] intValue]];
    [self setAccessToken:[jsonDict objectForKey:@"accessToken"]];
    [self setMobileNo:[jsonDict objectForKey:@"mobileNo"]];
    [self setUserCode:[jsonDict objectForKey:@"userCode"]];
    [self setAvatarUrl:[jsonDict objectForKey:@"avatarUrl"]];
    [self setUserRoleId:[[jsonDict objectForKey:@"userRoleId"] intValue]];
    [self setUserSetCity:[jsonDict objectForKey:@"userSetCity"]];
    [self setDevices:[jsonDict objectForKey:@"devices"]];
    [self setReceivePush:[[jsonDict objectForKey:@"receivePush"] boolValue]];
    [self setPushTimes:[jsonDict objectForKey:@"pushTimes"]];
    [self setBodyTagNames:[jsonDict objectForKey:@"bodyTagNames"]];
    [self setEyeTagNames:[jsonDict objectForKey:@"eyeTagNames"]];
    [self setUserJob:[jsonDict objectForKey:@"userJob"]];
    [self setRealName:[jsonDict objectForKey:@"realName"]];
    [self setUserType:[[jsonDict objectForKey:@"userType"] intValue]];
    [self setUserMarry:[[jsonDict objectForKey:@"userMarry"] boolValue]];
    [self setBirthday:[jsonDict objectForKey:@"birthday"]];
    [self setUserHeight:[[jsonDict objectForKey:@"userHeight"] floatValue]];
    [self setUserWeight:[[jsonDict objectForKey:@"userWeight"] floatValue]];
    [self setBirthCity:[jsonDict objectForKey:@"birthCity"]];
    [self setUserIDNo:[jsonDict objectForKey:@"userIDNo"]];
    [self setPastMedicalHistory:[jsonDict objectForKey:@"pastMedicalHistory"]];
    [self setFavArticleIds:[[NSMutableSet alloc] initWithArray:[jsonDict objectForKey:@"favArticleIds"]]];
    [self setReadArticleIds:[[NSMutableSet alloc] initWithArray:[jsonDict objectForKey:@"readArticleIds"]]];
}

-(User *) copyWithZone:(NSZone *)zone{
    User *user = [[User allocWithZone:zone] init];
    user.id = self.id;
    user.age = self.age;
    user.name = self.name;
    user.userGender = self.userGender;
    user.accessToken = self.accessToken;
    user.mobileNo = self.mobileNo;
    user.userCode = self.userCode;
    user.avatarUrl = self.avatarUrl;
    user.userRoleId = self.userRoleId;
    user.userSetCity = self.userSetCity;
    user.devices = self.devices;
    user.receivePush = self.receivePush;
    user.pushTimes = self.pushTimes;
    user.bodyTagNames = self.bodyTagNames;
    user.userJob = self.userJob;
    user.realName = self.realName;
    user.userType = self.userType;
    user.userMarry = self.userMarry;
    user.birthday = self.birthday;
    user.userHeight = self.userHeight;
    user.userWeight = self.userWeight;
    user.birthCity = self.birthCity;
    user.userIDNo = self.userIDNo;
    user.pastMedicalHistory = self.pastMedicalHistory;
    user.favArticleIds = self.favArticleIds;
    user.readArticleIds = self.readArticleIds;
    return user;
}

-(NSString *) description{
    return [NSString stringWithFormat:@"id:%d, name:%@, accessToken:%@, moblieNo:%@, receivePush:%d, pushTimes:%@, bodyTagNames:%@", self.id, self.name, self.accessToken, self.mobileNo, self.receivePush,self.pushTimes,self.bodyTagNames];
}

@end
