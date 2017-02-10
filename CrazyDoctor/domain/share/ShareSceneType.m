//
//  ShareSceneType.m
//

#import "ShareSceneType.h"

@implementation ShareSceneType


-(id) initWithSharedChannelType:(SSDKPlatformType)sharedChannelType{
    self = [super init];
    if (self) {
        self.sharedChannelType = sharedChannelType;
    }
    return self;
}

-(NSString *) getValueOfSharedChannelType{
    switch (self.sharedChannelType) {
        case SSDKPlatformTypeSinaWeibo:
            return @"新浪微博";
        case SSDKPlatformSubTypeQZone:
            return @"QQ空间";
        case SSDKPlatformSubTypeWechatFav:
            return @"微信收藏";
        case SSDKPlatformSubTypeWechatSession:
            return @"微信好友";
        case SSDKPlatformSubTypeWechatTimeline:
            return @"微信朋友圈";
        case SSDKPlatformSubTypeQQFriend:
            return @"QQ";
        default:
            break;
    }
    return nil;
}

@end
