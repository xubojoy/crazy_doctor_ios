//
//  CommonItemTxt.m
//  styler
//
//  Created by System Administrator on 13-7-4.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "CommonItemTxt.h"

@implementation CommonItemTxt

-(id) init:(int)txtType title:(NSString *)title content:(NSString *)content{
    CommonItemTxt *txt = [super init];
    if(txt){
        txt.txtType = txtType;
        txt.title = title;
        txt.content = content;
    }
    return txt;
}

@end
