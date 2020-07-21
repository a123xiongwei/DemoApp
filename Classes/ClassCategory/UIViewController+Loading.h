//
//  UIViewController+Loading.h
//  colfood-app
//
//  Created by user on 15/7/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Loading)

/**
 *  开始加载的方法
 *
 *  @param yValue 调整显示的位置
 */
-(void)startLoading:(CGFloat) yValue andXValue:(CGFloat) xValue;

/**
 *  结束加载的方法
 */
-(void)endLoading;

/**
 *  添加按钮刷新视图
 */
-(void)addRefreshButton:(CGFloat) yValue withClickBack:(void(^)(void)) clickBack;

/**
 *  添加分享按钮
 */
-(void)addShareButton:(CGFloat) yValue withClickBack:(void(^)(void)) clickBack;

@end
