//
//  CDAlertViewController.h
//  CrazyDoctor
//
//  Created by xubojoy on 16/7/18.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SHBAction : NSObject

@property (nonatomic, readonly, copy) NSString            *title;
@property (nonatomic, readonly, copy) dispatch_block_t    action;

+ (SHBAction *)actionWithTitle:(NSString *)title action:(dispatch_block_t)action;
- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action;

@end

@interface CDAlertViewController : UIViewController
@property (nonatomic, strong, readonly) NSString *content;
- (id)initWithTitle:(NSString *)title image:(UIImage *)image message:(NSString *)message;

- (void)addAction:(SHBAction *)action;

- (void)show;
@end
