//
//  LocalMeridian.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/24.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "LocalMeridian.h"

@implementation LocalMeridian
-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.jingLuoName forKey:@"jingLuoName"];
    [aCoder encodeObject:self.localAcupoint forKey:@"localAcupoint"];
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    if(self){
        self.jingLuoName = [aDecoder decodeObjectForKey:@"jingLuoName"];
        self.localAcupoint = [aDecoder decodeObjectForKey:@"localAcupoint"];
    }
    
    return self;
}

- (void) readFromJSONDictionary:(NSDictionary *)jsonDict{
    [self setJingLuoName:[jsonDict objectForKey:@"jingLuoName"]];
    [self setLocalAcupoint:[jsonDict objectForKey:@"localAcupoint"]];
}

-(LocalMeridian *) copyWithZone:(NSZone *)zone{
    LocalMeridian *localMeridian = [[LocalMeridian allocWithZone:zone] init];
    localMeridian.jingLuoName = self.jingLuoName;
    return localMeridian;
}

-(NSString *) description{
    return [NSString stringWithFormat:@"jingLuoName:%@",self.jingLuoName];
}

@end
