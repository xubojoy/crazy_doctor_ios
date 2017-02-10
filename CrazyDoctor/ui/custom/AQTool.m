//
//  AQTool.m
//  Picture
//
//  Created by aiqing on 16/1/10.
//  Copyright © 2016年 aiqing. All rights reserved.
//

#import "AQTool.h"
static CGRect oldframe;
@implementation AQTool
+(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.userInteractionEnabled=YES;
    imageView.tag=avatarImageView.tag;
    [backgroundView addSubview:imageView];
//    [window bringSubviewToFront:backgroundView];
    
    // 保存图片按钮
    
//    UIButton *  _saveImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _saveImageBtn.frame = CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 100,40, 40);
//    _saveImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//    [_saveImageBtn setImage:[UIImage imageNamed:@"save_icon.png"] forState:UIControlStateNormal];
//    [_saveImageBtn setImage:[UIImage imageNamed:@"save_icon_highlighted.png"] forState:UIControlStateHighlighted];
//    
//    _saveImageBtn.tag = avatarImageView.tag;
//    NSLog( @"buttonbuttonbutton%zi",_saveImageBtn.tag);
//    _saveImageBtn.backgroundColor = [UIColor purpleColor];
//    
//    [_saveImageBtn addTarget:self  action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [backgroundView addSubview:_saveImageBtn];
    
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldframe;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
+(void)saveImage:(id)imageBotton
{
    UIImageView * imageView = [UIImageView new];
    UIButton * button = (UIButton *)imageBotton;
    imageView.tag = button.tag;
    
    imageView = (UIImageView*)[button.superview viewWithTag:button.tag];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    });
}
+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
      NSLog(@"保存失败，权限未开？");
        
    } else {
        NSLog(@"成功保存到相册，可去照片查询");
    }
}

@end
