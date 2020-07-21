//
//  NSObject+Loading.h
//  JingJingApp
//
//  Created by user on 16/5/6.
//  Copyright © 2016年 Xiongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Loading)

/**
 *  加载视图方法
 */
-(void)showHUDView;

/**
 *  加载视图方法
 */
-(void)showHUDView:(UIView *)inView;

/**
 *  隐藏加载视图
 */
-(void)HUDHidden;

/**
 *  显示提示信息
 */
-(void)showMessage:(NSString *)title;

/**
 *  hudView附带消息提示
 */
-(void)showHUDViewWithMessage:(NSString *)message;

@end
