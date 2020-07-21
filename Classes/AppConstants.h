//
//  AppConstants.h
//  rrtApp
//
//  Created by yuangang on 15/4/13.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//
#import "UIView+Extension.h"
#import "NSObject+Loading.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "BlueDataUtils.h"
#import <MJExtension.h>
#import "MJDataCacheManager.h"

typedef NS_ENUM(NSInteger, VTScaleStatusCode) {
    VTScaleStatusCodeNormal = 0, // 正常测量
    VTScaleStatusCodeWeightNormal = 200, // 体重动态数据
    VTScaleStatusCodeInternal = 3001, // 内部错误
    VTScaleStatusCodeRecordFail = 3002, // 创建访问记录失败
    VTScaleStatusCodeVendorNotExist = 4001, // 厂商不存在
    VTScaleStatusCodeVendorBanned = 4002, // 厂商被禁用
    VTScaleStatusCodeSourceUnknown = 4003, // 数据来源不明确
    VTScaleStatusCodeUserMissing = 4004, // 用户信息缺失
    VTScaleStatusCodeProtocolUnknown = 4005, // 协议类型未识别
    VTScaleStatusCodeUserInfoInvalid = 4006, // 用户信息出错
    VTScaleStatusCodeBMIOutRange = 4007, // BMI不在合理区间
    VTScaleStatusCodeRValueInvalid = 4008, // RValue无效，即没测到阻值(比如穿着鞋上称)
    VTScaleStatusCodeRValueOutRange = 4009, // RValue不在合理区间，如：Rvalue<300或RValue>4000
    VTScaleStatusCodeUnauthorized = 4010, // 未登录
    VTScaleStatusCodeKeywordMissing = 4011 // 请传入keyword参数
};


#define UIKeyWindow [UIApplication sharedApplication].keyWindow

//
//
#define MainColor [CommUtils colorWithHexString:@"#1E1F20"]


//
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define DEFAULT_IMG [UIImage imageNamed:@"dev_icon"]
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height

#define kNavBarHeight 44.0

#define kTopHeight (kStatusBarHeight + kNavBarHeight)

#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20.1?83.0:49.0)

#define kTabBarArcHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20.1?34.0:0.0)

//#define MainSB [UIStoryboard storyboardWithName:@"Main" bundle:nil]

//#define HomeMainSB [UIStoryboard storyboardWithName:@"HomeMain" bundle:nil]

//#define SetMainSB [UIStoryboard storyboardWithName:@"SetMain" bundle:nil]

//#define RoleInfoMainSB [UIStoryboard storyboardWithName:@"RoleInfoMain" bundle:nil]


//#define MainColor  [UIColor purpleColor]
