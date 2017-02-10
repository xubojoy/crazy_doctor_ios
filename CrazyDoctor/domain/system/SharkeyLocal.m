//
//  SharkeyLocal.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/22.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "SharkeyLocal.h"

@implementation SharkeyLocal
-(void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.modelName forKey:@"modelName"];
    [aCoder encodeObject:self.macAddress forKey:@"macAddress"];
//    [aCoder encodeObject:self.firmwareVersion forKey:@"firmwareVersion"];
    [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
}

-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    if(self){
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.modelName = [aDecoder decodeObjectForKey:@"modelName"];
        self.macAddress = [aDecoder decodeObjectForKey:@"macAddress"];
//        self.firmwareVersion = [aDecoder decodeObjectForKey:@"firmwareVersion"];
        self.serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
        self.identifier = [aDecoder decodeObjectForKey:@"identifier"];
    }
    
    return self;
}

- (void) readFromJSONDictionary:(NSDictionary *)jsonDict{
    [self setName:[jsonDict objectForKey:@"name"]];
    [self setModelName:[jsonDict objectForKey:@"modelName"]];
    [self setMacAddress:[jsonDict objectForKey:@"macAddress"]];
//    [self setFirmwareVersion:[jsonDict objectForKey:@"firmwareVersion"]];
    [self setSerialNumber:[jsonDict objectForKey:@"serialNumber"]];
    [self setIdentifier:[jsonDict objectForKey:@"identifier"]];
}

-(SharkeyLocal *) copyWithZone:(NSZone *)zone{
    SharkeyLocal *sharkey = [[SharkeyLocal allocWithZone:zone] init];
    sharkey.name = self.name;
    sharkey.modelName = self.modelName;
    sharkey.macAddress = self.macAddress;
//    sharkey.firmwareVersion = self.firmwareVersion;
    sharkey.serialNumber = self.serialNumber;
    sharkey.identifier = self.identifier;
    return sharkey;
}

-(NSString *) description{
    return [NSString stringWithFormat:@"name:%@, modelName:%@, identifier:%@, serialNumber:%@",self.name, self.modelName, self.identifier,self.serialNumber];
}

@end
