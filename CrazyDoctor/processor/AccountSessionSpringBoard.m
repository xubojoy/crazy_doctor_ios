//
//  AccountSessionSpringBoard.m
//  styler
//
//  Created by System Administrator on 13-6-27.
//  Copyright (c) 2013年 mlzj. All rights reserved.
//

#import "AccountSessionSpringBoard.h"
#import "UserCenterViewController.h"
#import "IndexViewController.h"
#import "CheckIndexController.h"
#import "CheckAcupointViewController.h"
#import "OrderPhysiotherapyController.h"
#import "TongueDiagnosisTestController.h"
#import "DiagnosisOnRightEyesController.h"
#import "ArticleDetailController.h"
@implementation AccountSessionSpringBoard

+(void) jumpToAccountSessionFrom:(UIViewController *)viewController accountSessionFrom:(int)accountSessionFrom{
    NSNotification *notification = [NSNotification notificationWithName:@"sessionUpdate" object:nil];
    NSNotification *notification2 = [NSNotification notificationWithName:notification_name_user_login object:nil userInfo:[NSDictionary dictionaryWithObject:[[NSNumber alloc] initWithInt:accountSessionFrom] forKey:notification_name_pn_account_session_from]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [[NSNotificationCenter defaultCenter] postNotification:notification2];
    
    
    if(accountSessionFrom == account_session_from_index){
        [viewController.navigationController popToRootViewControllerAnimated:YES];
    }else if(accountSessionFrom == account_session_from_user_home){
        NSArray *controllers = viewController.navigationController.viewControllers;
        for(UIViewController *controller in controllers){
            if([controller isKindOfClass:[IndexViewController class]]){
                [viewController.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }else if(accountSessionFrom == account_session_from_user_chati){
        NSArray *controllers = viewController.navigationController.viewControllers;
        for(UIViewController *controller in controllers){
            if([controller isKindOfClass:[CheckIndexController class]]){
                [viewController.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }
    else if(accountSessionFrom == account_session_from_xuewei_detail){
        NSArray *controllers = viewController.navigationController.viewControllers;
        for(UIViewController *controller in controllers){
            if([controller isKindOfClass:[CheckAcupointViewController class]]){
                [viewController.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }else if(accountSessionFrom == account_session_from_OrderPhysiotherapy){
        NSArray *controllers = viewController.navigationController.viewControllers;
        for(UIViewController *controller in controllers){
            if([controller isKindOfClass:[OrderPhysiotherapyController class]]){
                [viewController.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }else if(accountSessionFrom == account_session_from_user_center_login){
        NSArray *controllers = viewController.navigationController.viewControllers;
        for(UIViewController *controller in controllers){
            if([controller isKindOfClass:[UserCenterViewController class]]){
                [viewController.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }else if(accountSessionFrom == account_session_from_user_tongueDiagnosisTest){
        NSArray *controllers = viewController.navigationController.viewControllers;
        for(UIViewController *controller in controllers){
            if([controller isKindOfClass:[TongueDiagnosisTestController class]]){
                [viewController.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }else if(accountSessionFrom == account_session_from_user_diagnosisOnRightEyes){
        NSArray *controllers = viewController.navigationController.viewControllers;
        for(UIViewController *controller in controllers){
            if([controller isKindOfClass:[DiagnosisOnRightEyesController class]]){
                [viewController.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }else if(accountSessionFrom == account_session_from_user_articleDetail){
        NSArray *controllers = viewController.navigationController.viewControllers;
        for(UIViewController *controller in controllers){
            if([controller isKindOfClass:[ArticleDetailController class]]){
                [viewController.navigationController popToViewController:controller animated:NO];
                break;
            }
        }
    }
    else{
        [viewController.navigationController popToRootViewControllerAnimated:YES];
    }
//    account_session_from_user_diagnosisOnRightEyes
}

@end
