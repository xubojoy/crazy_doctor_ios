//
//  ShareSDKProcessor.m
//  styler
//
//  Created by wangwanggy820 on 14-8-8.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#import "ShareSDKProcessor.h"
@implementation ShareSDKProcessor

//微信朋友圈
-(void)followWeiXinTimeLine:(id)sender
               shareContent:(ShareContent *)shareContent
          shareSuccessBlock:(void(^)())shareSuccessBlock{
    
    //1、创建分享参数
    NSArray* imageArray = shareContent.imageArray;
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        [shareParams SSDKSetupWeChatParamsByText:shareContent.content
                                           title:shareContent.content
                                             url:[NSURL URLWithString:shareContent.url]
                                      thumbImage:nil
                                           image:[imageArray objectAtIndex:0]
                                    musicFileURL:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil
                                            type:SSDKContentTypeAuto
                              forPlatformSubType:SSDKPlatformSubTypeWechatTimeline];
        
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     
                     NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                     [SVProgressHUD showSuccessWithStatus:@"分享成功" maskType:SVProgressHUDMaskTypeNone];
                     shareSuccessBlock();
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     
                     NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)error.code, error.localizedDescription);
                     [SVProgressHUD showErrorWithStatus:@"分享失败！" maskType:SVProgressHUDMaskTypeNone];                     shareSuccessBlock();
                     
                     break;
                 }
                 default:
                     break;
             }

         }];
    }
    
}

//微信好友
-(void)followWeiXinSession:(id)sender
              shareContent:(ShareContent *)shareContent
         shareSuccessBlock:(void(^)())shareSuccessBlock{
    //1、创建分享参数
    NSArray* imageArray = shareContent.imageArray;
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupWeChatParamsByText:shareContent.content
                                           title:shareContent.title
                                             url:[NSURL URLWithString:shareContent.url]
                                      thumbImage:nil
                                           image:[imageArray objectAtIndex:0]
                                    musicFileURL:nil
                                         extInfo:nil
                                        fileData:nil
                                    emoticonData:nil
                                            type:SSDKContentTypeAuto
                              forPlatformSubType:SSDKPlatformSubTypeWechatSession];
    
        
        [ShareSDK share:SSDKPlatformSubTypeWechatSession
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     
                     NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                     [SVProgressHUD showSuccessWithStatus:@"分享成功" maskType:SVProgressHUDMaskTypeNone];
                     shareSuccessBlock();
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     
                     NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)error.code, error.localizedDescription);
                    [SVProgressHUD showErrorWithStatus:@"分享失败！" maskType:SVProgressHUDMaskTypeNone];
                     shareSuccessBlock();
                     
                     break;
                 }
                 default:
                     break;
             }
             
         }];
    }

    
}
//新浪微博分享
-(void)followSinaWeiBo:(id)sender
          shareContent:(ShareContent *)shareContent
     shareSuccessBlock:(void(^)())shareSuccessBlock{
        //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    NSArray* imageArray = shareContent.imageArray;
    
    if (imageArray) {
        
        [shareParams SSDKSetupSinaWeiboShareParamsByText:shareContent.sinaWeiBoContent
                                                   title:shareContent.title
                                                   image:[imageArray objectAtIndex:0]
                                                     url:[NSURL URLWithString:shareContent.url]
                                                latitude:0
                                               longitude:0
                                                objectID:nil
                                                    type:SSDKContentTypeAuto];
        
        
        //进行分享
        [ShareSDK share:SSDKPlatformTypeSinaWeibo
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                     [SVProgressHUD showSuccessWithStatus:@"分享成功" maskType:SVProgressHUDMaskTypeNone];
                     shareSuccessBlock();
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)error.code, error.localizedDescription);
                     [SVProgressHUD showErrorWithStatus:@"分享失败！" maskType:SVProgressHUDMaskTypeNone];
                     break;
                 }
                default:
                     break;
             }
             
             
         }];
    }


}

//QQ分享
-(void)followQQ:(id)sender
          shareContent:(ShareContent *)shareContent
     shareSuccessBlock:(void(^)())shareSuccessBlock{

    NSArray* imageArray = shareContent.imageArray;
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupQQParamsByText:shareContent.content
                                       title:shareContent.title
                                         url:[NSURL URLWithString:shareContent.url]
                                  thumbImage:nil
                                       image:[imageArray objectAtIndex:0]
                                        type:SSDKContentTypeAuto
                          forPlatformSubType:SSDKPlatformSubTypeQQFriend];
        
        [ShareSDK share:SSDKPlatformSubTypeQQFriend
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     
                     NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"分享成功"));
                     [SVProgressHUD showSuccessWithStatus:@"分享成功" maskType:SVProgressHUDMaskTypeNone];
                     shareSuccessBlock();
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     
                     NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)error.code, error.localizedDescription);
                    [SVProgressHUD showErrorWithStatus:@"分享失败！" maskType:SVProgressHUDMaskTypeNone];
                     shareSuccessBlock();
                     
                     break;
                 }
                 default:
                     break;
             }
             
         }];
    }

}


//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image
{
    if (image.size.width == image.size.height) {
        return image;
    }
    CGSize size = image.size;
    float ratio = size.width/size.height;
    float newRatio = 1;
    float x = 0;
    float y = 0;
    float cropedWidth = 0;
    float cropedHeight = 0;
    if (ratio > newRatio) {
        cropedHeight = size.height;
        cropedWidth = cropedHeight*newRatio;
        x = (size.width - cropedWidth)/2;
    }else{
        cropedWidth = size.width;
        cropedHeight = cropedWidth/newRatio;
        y = (size.height - cropedHeight)/2;
    }
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(x, y, cropedWidth, cropedHeight));
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    
    CGSize newSize = CGSizeMake(200, 200);
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [smallImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

-(void) convertSpecialSymbol:(ShareContent *)shareContent{
    shareContent.title = [shareContent.title stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    shareContent.content = [shareContent.content stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    shareContent.sinaWeiBoContent = [shareContent.sinaWeiBoContent stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
}

+(void) initShareSDK{
    [ShareSDK registerApp:share_app_key
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
                 //             case SSDKPlatformTypeSinaWeibo:
                 //                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 //                 break;
                 
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx15c8b624548493ae"
                                       appSecret:@"91650c3d47de74a9715747b89b8320dd"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1105211001"
                                      appKey:@"E7Jw4cgRDl2zitWh"
                                    authType:SSDKAuthTypeBoth];
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"307270095"
                                           appSecret:@"cdbeb0abdc4d0935d49f8b8bda28bb4d"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];

}
@end
