//
//  LoginMainController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/5.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "LoginMainController.h"
#import "AppConstants.h"
#import "HomeMainController.h"
#import "MainTabBarController.h"
#import "DeviceDetailsController.h"
#import "LoginMainModel.h"
#import "MJDataCacheManager.h"
#import "NSBundleUtils.h"

@interface LoginMainController ()

@property (nonatomic, strong) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) LoginMainModel *loginModel;

@end

@implementation LoginMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginModel = [[LoginMainModel alloc] init];
    
    self.view.width = SCREEN_WIDTH;
    
    self.loginBtn.isRaidus = YES;
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [self initUerLoginData];
        
    }];

}

/**
 * 用户登录方法
 */
-(void)initUerLoginData{
    
    NSString *userName = @"18676724057";
    NSString *pwd = @"123456";
    
    [self showHUDView];
    [[self.loginModel userLogin:userName withPwd:pwd] subscribeError:^(NSError *error) {
        [self HUDHidden];
    } completed:^{
        
        NSLog(@"---tokenVaue---:%@",self.loginModel.tokenValue);
        NSString *tokenValue = self.loginModel.tokenValue;
        [self initFindAccountInfoData:tokenValue];
        
    }];
    
     
    
}

/**
 *获取用户信息方法
 */
-(void)initFindAccountInfoData:(NSString *)tokenValue{
    
    [[self.loginModel findAccountInfo:tokenValue] subscribeError:^(NSError *error) {
        [self HUDHidden];
    } completed:^{
        [self HUDHidden];
        
        UIViewController *homeCon = [NSBundleUtils buildViewController:[MainTabBarController class]];
        [self.navigationController pushViewController:homeCon animated:YES];
        
    }];
}


@end
