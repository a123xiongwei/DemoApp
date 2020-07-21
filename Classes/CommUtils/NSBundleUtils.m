//
//  NSBundleUtils.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/20.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "NSBundleUtils.h"
#import "LoginMainController.h"
#import "MainTabBarController.h"
#import "MesureReportController.h"
#import "HomeMainController.h"
#import "SetMainController.h"
#import "ScaleTrendController.h"
#import "RelationDetailsController.h"
#import "AddUserInfoController.h"
#import "DeviceDetailsController.h"
#import "BindDeviceController.h"
#import "LoginMainController.h"
#import "DeviceMeasureController.h"

@implementation NSBundleUtils

/**
 * 构建控制器方法
 */
+(UIViewController *)buildViewController:(Class)classname{
    
    UIViewController *viewcon = nil;
    NSBundle *resourceBundle = [NSBundle bundleForClass:classname];
    
    if([NSStringFromClass(classname) isEqualToString:@"MainTabBarController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }else if([NSStringFromClass(classname) isEqualToString:@"MesureReportController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"HomeMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }else if([NSStringFromClass(classname) isEqualToString:@"HomeMainController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"HomeMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateInitialViewController];
    }else if([NSStringFromClass(classname) isEqualToString:@"SetMainController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"SetMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateInitialViewController];
    }else if([NSStringFromClass(classname) isEqualToString:@"ScaleTrendController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"HomeMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }else if([NSStringFromClass(classname) isEqualToString:@"RelationDetailsController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"HomeMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }else if([NSStringFromClass(classname) isEqualToString:@"AddUserInfoController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"SetMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }else if([NSStringFromClass(classname) isEqualToString:@"DeviceDetailsController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"SetMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }else if([NSStringFromClass(classname) isEqualToString:@"BindDeviceController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"SetMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }if([NSStringFromClass(classname) isEqualToString:@"LoginMainController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }if([NSStringFromClass(classname) isEqualToString:@"DeviceMeasureController"]){
        UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"SetMain" bundle:resourceBundle];
        viewcon = [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass(classname)];
    }
    return viewcon;
}

/**
 * 构建视图的方法
 */
+(UIView *)buildView:(Class)classname owner:(UIViewController *) owner{
    
    UIView *view ;
    NSBundle *viewBundle = [NSBundle bundleForClass:classname];
    view = [viewBundle loadNibNamed:NSStringFromClass(classname) owner:owner options:nil].lastObject;
    
    return view;
}

/**
 * 构建UIImage方法
 */
+(UIImage *)buildImage:(Class) classname imageName:(NSString *) name{
    UIImage *image;
    NSBundle *viewBundle = [NSBundle bundleForClass:classname];
    image = [UIImage imageNamed:name inBundle:viewBundle compatibleWithTraitCollection:nil];
    return image;
}

@end
