//
//  LoginMainModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/14.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * 登录页接口请求类
 */
@interface LoginMainModel : MJBaseViewModel

@property (nonatomic, strong) NSString *tokenValue;

/**
 * 麦咭用户登录
 */
-(RACSignal *)userLogin:(NSString *)userName withPwd:(NSString *) pwd;

/**
 * 获取登录账号信息
 */
-(RACSignal *)findAccountInfo:(NSString *)token;

@end

NS_ASSUME_NONNULL_END
