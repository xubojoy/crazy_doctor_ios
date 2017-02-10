//
//  ShareSDKProcessor.h
//  styler
//
//  Created by wangwanggy820 on 14-8-8.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareContent.h"
#import "ShareSceneType.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"


@interface ShareSDKProcessor : NSObject

+(void)initShareSDK;
-(void)followWeiXinTimeLine:(id)sender
               shareContent:(ShareContent *)shareContent
          shareSuccessBlock:(void(^)())shareSuccessBlock;
-(void)followWeiXinSession:(id)sender
              shareContent:(ShareContent *)shareContent
         shareSuccessBlock:(void(^)())shareSuccessBlock;

-(void)followSinaWeiBo:(id)sender
          shareContent:(ShareContent *)shareContent
     shareSuccessBlock:(void(^)())shareSuccessBlock;

-(void)followQQ:(id)sender
   shareContent:(ShareContent *)shareContent
shareSuccessBlock:(void(^)())shareSuccessBlock;

@end
