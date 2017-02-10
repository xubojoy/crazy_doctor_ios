//
//  ExpertPicture.m
//  iUser
//
//  Created by System Administrator on 13-4-24.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "ServicePicture.h"

@implementation ServicePicture

-(CGSize) getBigCGSize{
    return CGSizeFromString([NSString stringWithFormat:@"{%@}", self.bigSize]);
}

-(CGSize) getThumbnailCGSize{
    return CGSizeFromString([NSString stringWithFormat:@"{%@}", self.thumbnailFileSize]);
}

-(CGSize) getoriginSize{
    return CGSizeFromString([NSString stringWithFormat:@"{%@}", self.originSize]);
}

@end
