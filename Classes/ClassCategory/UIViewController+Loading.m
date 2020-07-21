//
//  UIViewController+Loading.m
//  colfood-app
//
//  Created by user on 15/7/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "AppConstants.h"
#import "UIView+Extension.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UIViewController (Loading)


/**
 *  开始加载的方法
 *
 *  @param yValue 调整显示的位置
 */
-(void)startLoading:(CGFloat) yValue andXValue:(CGFloat) xValue{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] init];
    indicatorView.tag = 100;
    indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    CGRect rect = self.view.frame;
    rect.origin = CGPointMake(rect.origin.x/2+ xValue, rect.origin.y/2-50 + yValue);
    [indicatorView startAnimating];
    indicatorView.alpha = 0.5;
    [self.view addSubview:indicatorView];
    
    UILabel *descripLa = [[UILabel alloc] initWithFrame:CGRectMake(xValue, (SCREEN_HEIGHT - 108)/2+yValue-25, SCREEN_WIDTH, 20)];
    descripLa.text = @"数据加载中…";
    descripLa.tag = 101;
    descripLa.font = [UIFont systemFontOfSize:14];
    descripLa.textAlignment = NSTextAlignmentCenter;
    descripLa.textColor = [UIColor colorWithRed:0.227 green:0.263 blue:0.294 alpha:0.8];
//    [self.view addSubview:descripLa];
    
    
    indicatorView.center = CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT)/2 - yValue);
    
    UIView *bgView = [[UIView alloc] init];
    bgView.tag = 102;
    bgView.frame = self.view.frame;
//    [self.view addSubview:bgView];
    //    [IanAlert showLoading:@"加载中…"];
}


/**
 *  结束加载的方法
 */
-(void)endLoading{
    [[self.view viewWithTag:100] removeFromSuperview];
    [[self.view viewWithTag:100] removeFromSuperview];
    [[self.view viewWithTag:101] removeFromSuperview];
    [[self.view viewWithTag:102] removeFromSuperview];
}

/**
 *  添加按钮刷新视图
 */
-(void)addRefreshButton:(CGFloat) yValue withClickBack:(void(^)(void)) clickBack{
    
    UIButton *refreshBtn = [[UIButton alloc] init];
    refreshBtn.width = 40;
    refreshBtn.height = 40;
    refreshBtn.x = SCREEN_WIDTH - 20 - 40;
    refreshBtn.y = self.view.height - 27 - 40 - yValue - kTabBarArcHeight;
    [refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateHighlighted];
    [[refreshBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        clickBack();
    }];
    [self.view addSubview:refreshBtn];
    
}

/**
 *  添加分享按钮
 */
-(void)addShareButton:(CGFloat) yValue withClickBack:(void(^)(void)) clickBack{
    UIButton *refreshBtn = [[UIButton alloc] init];
    refreshBtn.width = 40;
    refreshBtn.height = 40;
    refreshBtn.x = SCREEN_WIDTH - 20 - 40;
    refreshBtn.y = self.view.height - 27 - 40 - yValue - kTabBarArcHeight - 50;
    [refreshBtn setImage:[UIImage imageNamed:@"s_share"] forState:UIControlStateNormal];
    [refreshBtn setImage:[UIImage imageNamed:@"s_share"] forState:UIControlStateHighlighted];
    [[refreshBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        clickBack();
    }];
    [self.view addSubview:refreshBtn];
    
}


@end
