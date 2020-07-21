//
//  MJScaleService.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/20.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJScaleService.h"
#import "LoginMainController.h"
#import "AppConstants.h"
#import "NSBundleUtils.h"
#import "LoginMainModel.h"
#import "MainTabBarController.h"

@implementation MJScaleService

/**
*
* 跳转到登录页
* viewCon 当前控制器UIViewController
*
*/
-(void)initPushToLoginMain:(UIViewController *) viewCon{
    
    LoginMainController *loginCon = (LoginMainController *)[NSBundleUtils buildViewController:[LoginMainController class]];
    [viewCon.navigationController pushViewController:loginCon animated:YES];
    
}

/**
*
* 根据Token跳转到主页
* token 麦咭TVtoken
* viewCon 当前控制器UIViewController
*
*/
-(void)initToken:(NSString *)token pushToHomeMain:(UIViewController *) viewCon{
    
    [self showHUDView];
    LoginMainModel *loginModel = [[LoginMainModel alloc] init];
    [[loginModel findAccountInfo:token] subscribeError:^(NSError *error) {
        [self HUDHidden];
    } completed:^{
        [self HUDHidden];
        UIViewController *homeCon = [NSBundleUtils buildViewController:[MainTabBarController class]];
        [viewCon.navigationController pushViewController:homeCon animated:YES];
        
    }];
    
}


@end
