//
//  LoginMainModel.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/14.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "LoginMainModel.h"
#import "NSString+MD5.h"
#import "AppConstants.h"

/**
* 登录页接口请求类
*/
@implementation LoginMainModel

/**
*  麦咭用户登录
*/
-(RACSignal *)userLogin:(NSString *)userName withPwd:(NSString *) pwd{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        MJLoginMainReq *req = [[MJLoginMainReq alloc] init];
        req.userName = userName;
        req.userPwd = [NSString md5Hash:pwd];
        
        [req userLoginData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                
                self.tokenValue = [MJHttpDataUtils findMJAccountToken:objects];
                
                NSString *securityToken = [MJHttpDataUtils findMJSecurityToken:objects];
                
                //保存秘钥
                [MJDataCacheManager saveMJSecurityToken:securityToken];
                
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        return nil;
    }];
}

/**
 * 获取登录账号信息
 * token 麦咭token
 */
-(RACSignal *)findAccountInfo:(NSString *)token{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        MJLoginMainReq *req = [[MJLoginMainReq alloc] init];
        req.mageeToken = token;
        [req findAccountInfoData:^(id objects, BOOL isSuccess) {
            
            if(isSuccess){
                
                LoginAccountItem *accountItem = [MJHttpDataUtils convertLoginAccountItemJson:objects];
                NSString *systemToken = accountItem.token;
                
                //保存系统Token
                [MJDataCacheManager saveSystemToken:systemToken];
                
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        
        return nil;
    }];
}

@end
