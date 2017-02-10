//
//  AppActiveScene.h
//  styler
//
//  Created by 冯聪智 on 14-9-13.
//  Copyright (c) 2014年 mlzj. All rights reserved.
//

#ifndef styler_AppActiveScene_h
#define styler_AppActiveScene_h

typedef enum {
    fromAppLaunch = 1,           //  app 一启动时变成活跃
    fromBackgroundAwake = 2,     //  app 从后台到前台变成活跃
    fromOtherAppLaunch = 3,      //  app 从其它app启动(自己app还没有启动)
    fromOtherAppAwake = 4,       //  app 从其它app切换到自己的app (自已的app已经启动)
}
AppActiveScene;


#endif
