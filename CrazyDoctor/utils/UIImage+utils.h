//
//  UIImage+utils.h
//  styler
//
//  Created by System Administrator on 13-6-5.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImage(util_extensions)
//extract a portion of an UIImage instance
-(UIImage *) cutout: (CGRect) coords;
//create a stretchable rendition of an UIImage instance, protecting edges as specified in cornerCaps
-(UIImage *) stretchImageWithCapInsets: (UIEdgeInsets) cornerCaps toSize: (CGSize) size;
@end
