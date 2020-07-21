//
//  NSObject+Loading.m
//  JingJingApp
//
//  Created by user on 16/5/6.
//  Copyright © 2016年 Xiongwei. All rights reserved.
//

#import "NSObject+Loading.h"
#import "MBProgressHUD.h"
#import "UIView+Extension.h"

@implementation NSObject (Loading)

/**
 *  加载视图方法
 */
-(void)showHUDView{
    
    MBProgressHUD *imgHUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
    imgHUD.tag = 10000;
    imgHUD.mode = MBProgressHUDModeIndeterminate;
    imgHUD.color = [UIColor blackColor];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:imgHUD];
    imgHUD.labelFont = [UIFont systemFontOfSize:14];
    imgHUD.minSize = CGSizeMake(100.f, 100.f);
    imgHUD.labelColor = [UIColor whiteColor];
    imgHUD.minShowTime = 100;
    
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    [imgHUD showAnimated:YES whileExecutingBlock:^{
        
    }];
}

-(void)showHUDViewWithMessage:(NSString *)message {

    MBProgressHUD *imgHUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
    imgHUD.tag = 10000;
    imgHUD.mode = MBProgressHUDModeIndeterminate;
    imgHUD.color = [UIColor blackColor];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:imgHUD];
    imgHUD.labelFont = [UIFont systemFontOfSize:14];
    imgHUD.minSize = CGSizeMake(100.f, 100.f);
    imgHUD.labelColor = [UIColor whiteColor];
    imgHUD.labelText = message;
    
    
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];
    imgHUD.minShowTime = 1.5;
    [imgHUD showAnimated:YES whileExecutingBlock:^{
        
    }];
}


/**
 *  加载视图方法
 */
-(void)showHUDView:(UIView *)inView{
    MBProgressHUD *imgHUD = [[MBProgressHUD alloc] initWithView:inView];
    imgHUD.y = imgHUD.y - 64;
    imgHUD.tag = 10000;
    imgHUD.mode = MBProgressHUDModeIndeterminate;
    imgHUD.color = [UIColor blackColor];
    
    [inView addSubview:imgHUD];
    imgHUD.labelFont = [UIFont systemFontOfSize:14];
    imgHUD.minSize = CGSizeMake(100.f, 100.f);
    imgHUD.labelColor = [UIColor whiteColor];
    [UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil].color = [UIColor whiteColor];

    imgHUD.minShowTime = 1.5;
    [imgHUD showAnimated:YES whileExecutingBlock:^{
        
    }];
}

/**
 *  显示提示信息
 */
-(void)showMessage:(NSString *)title{
    
    if(![title isKindOfClass:[NSString class]]){
        return;
    }
    
    MBProgressHUD  *noticeHUD = [[MBProgressHUD alloc] initWithView:[[UIApplication sharedApplication] keyWindow]];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:noticeHUD];
    noticeHUD.mode = MBProgressHUDModeText;
    noticeHUD.detailsLabelFont = [UIFont systemFontOfSize:14];
    noticeHUD.detailsLabelText = title;
    noticeHUD.detailsLabelColor = [UIColor whiteColor];
    noticeHUD.color = [UIColor blackColor];
    noticeHUD.minShowTime = 1.5;
    [noticeHUD showAnimated:YES whileExecutingBlock:^{
        
    }];
    

}

/**
 *  隐藏加载视图
 */
-(void)HUDHidden{
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    [[view viewWithTag:10000] removeFromSuperview];
    [[view viewWithTag:10000] removeFromSuperview];
}

@end
