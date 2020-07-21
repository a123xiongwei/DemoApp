//
//  MJScaleService.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/20.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJScaleService : NSObject


/**
 *
 * 跳转到登录页
 * viewCon 当前控制器UIViewController
 *
 */
-(void)initPushToLoginMain:(UIViewController *) viewCon;

/**
 *
 * 根据Token跳转到主页
 * token 麦咭TVtoken
 * viewCon 当前控制器UIViewController
 *
 */
-(void)initToken:(NSString *)token pushToHomeMain:(UIViewController *) viewCon;

@end

NS_ASSUME_NONNULL_END
