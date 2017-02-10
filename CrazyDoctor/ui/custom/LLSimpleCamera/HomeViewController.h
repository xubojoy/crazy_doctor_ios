//
//  HomeViewController.h
//  LLSimpleCameraExample
//
//  Created by Ömer Faruk Gül on 29/10/14.
//  Copyright (c) 2014 Ömer Faruk Gül. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSimpleCamera.h"
@class HomeViewController;
@protocol HomeViewControllerDelegate <NSObject>

-(void) homeViewController:(HomeViewController *)picker didFinishPickingMediaWithImage:(UIImage *)image;

@end

@interface HomeViewController : BaseViewController <LLSimpleCameraDelegate>

@property (nonatomic ,assign) id<HomeViewControllerDelegate> delegate;
@property (nonatomic ,strong) UIImage *portraitImg;

- (void)switchButtonPressed:(UIButton *)button;
@end
