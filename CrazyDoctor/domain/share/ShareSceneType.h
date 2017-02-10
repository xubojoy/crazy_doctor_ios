//
//  ShareSceneType.h
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
@interface ShareSceneType : NSObject

@property SSDKPlatformType sharedChannelType;   // 分享的渠道方法  （ 比如微信分享、新浪微博分享）

-(id) init __attribute__((unavailable("Must use initWithType: instead.")));

-(id) initWithSharedChannelType:(SSDKPlatformType) sharedChannelType;

-(NSString *) getValueOfSharedChannelType;  // 这个方法是用于获取自已后台对应的平台的值

@end
