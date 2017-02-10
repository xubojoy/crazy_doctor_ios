//
//  CutPicViewController.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "CutPicViewController.h"

@interface CutPicViewController ()

@end

@implementation CutPicViewController
- (instancetype)initWithImage:(UIImage *)cutImage{
    self = [super init];
    if (self) {
        self.cutImage = cutImage;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.image = self.cutImage;
    [self.view addSubview:self.imageView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, screen_height-70, screen_width, 70)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
    UIButton *reTakeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reTakeButton.frame = CGRectMake(15, 0, 70.0f, 70.0f);
    [reTakeButton setTitle:@"重拍" forState:UIControlStateNormal];
    
    [reTakeButton addTarget:self action:@selector(reTakeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:reTakeButton];
    
    UIButton *usePictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    usePictureButton.frame = CGRectMake(screen_width-15-80, 0, 80.0f, 70.0f);
    [usePictureButton setTitle:@"使用照片" forState:UIControlStateNormal];
    [usePictureButton addTarget:self action:@selector(usePictureButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:usePictureButton];
    
//    float w = (screen_width*384)/750;
//    float y = (screen_height*430)/1373;
//    float height = ((screen_width-30)*42)/69;
//    UIView *kuangView = [[UIView alloc] initWithFrame:CGRectMake(general_margin, y, screen_width-30, height)];
//    kuangView.layer.borderWidth = 1.0;
//    kuangView.layer.borderColor = [UIColor whiteColor].CGColor;
//    kuangView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:kuangView];
    
}

//截取view中某个区域生成一张图片
- (UIImage *)shotWithView:(UIView *)view scope:(CGRect)scope{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self shotWithView:view].CGImage, scope);
    UIGraphicsBeginImageContext(scope.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, scope.size.width, scope.size.height);
    CGContextTranslateCTM(context, 0, rect.size.height);//下移
    CGContextScaleCTM(context, 1.0f, -1.0f);//上翻
    CGContextDrawImage(context, rect, imageRef);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    //    CGContextRelease(context);
    return image;
}

//截取view生成一张图片
- (UIImage *)shotWithView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)reTakeButtonPressed{
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"重新拍照" object:nil];
}

- (void)usePictureButtonPressed{
    [self dismissViewControllerAnimated:NO completion:nil];
//    float w = (screen_width*384)/750;
    float y = (screen_height*430)/1373;
    float height = ((screen_width-30)*42)/69;
    UIImage *tmp = [self shotWithView:self.view scope:CGRectMake(general_margin, y-20, screen_width-30, height)];
    if ([self.delegate respondsToSelector:@selector(imageCropper:didFinished:)]) {
        [self.delegate imageCropper:self didFinished:tmp];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
