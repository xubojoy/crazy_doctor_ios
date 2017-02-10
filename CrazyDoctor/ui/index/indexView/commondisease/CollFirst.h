//
//  CollFirst.h
//  豆果美食
//
//  Created by 张琦 on 16/3/31.
//  Copyright © 2016年 张琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollFirst : UICollectionViewCell

@property (nonatomic, copy) NSString *name;


- (void)renderCollFirst:(BOOL)show;

@end
