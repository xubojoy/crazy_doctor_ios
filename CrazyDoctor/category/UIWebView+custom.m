//
//  UIWebView+custom.m
//  CrazyDoctor
//
//  Created by xubojoy on 16/5/10.
//  Copyright © 2016年 xubojoy. All rights reserved.
//

#import "UIWebView+custom.h"

@implementation UIWebView (custom)
+ (void)load{
    //  "v@:"
    Class class = NSClassFromString(@"WebActionDisablingCALayerDelegate");
    class_addMethod(class, @selector(setBeingRemoved), setBeingRemoved, "v@:");
    class_addMethod(class, @selector(willBeRemoved), willBeRemoved, "v@:");
    
    class_addMethod(class, @selector(removeFromSuperview), willBeRemoved, "v@:");
}

id setBeingRemoved(id self, SEL selector, ...)
{
    return nil;
}

id willBeRemoved(id self, SEL selector, ...)
{
    return nil;
}
@end
