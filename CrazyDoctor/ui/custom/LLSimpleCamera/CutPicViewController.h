//
//  CutPicViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/6/20.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CutPicViewController;
@protocol CutPicViewControllerDelegate <NSObject>

- (void)imageCropper:(CutPicViewController *)cropperViewController didFinished:(UIImage *)editedImage;

@end
@interface CutPicViewController : UIViewController
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UIImage *cutImage;
@property (nonatomic ,assign) id <CutPicViewControllerDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)cutImage;

@end
