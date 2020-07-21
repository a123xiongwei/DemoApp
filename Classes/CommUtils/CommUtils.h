//
//  CommUtils.h
//  rrtApp
//
//  Created by yuangang on 15/3/30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommUtils : NSObject

/**
 *  颜色转换方法
 *
 *  @param stringToConvert rgb字符值
 *
 *  @return UIColor
 */
+(UIColor *)colorWithHexString:(NSString *)stringToConvert;



+(CGSize)sizeWithString:(NSString*)str andFont:(UIFont*)font  andMaxSize:(CGSize)size;

/**
 *  颜色值转换成UIImage对象
 *
 *  @param color 颜色对象
 *
 *  @return UIImage
 */
+(UIImage *)imageWithBgColor:(UIColor *)color;


/**
 *获取渐变背景Layer
 */
+(CAGradientLayer *)findCGGradientLayer:(CGSize ) size withStartColors:(UIColor *)stColor endColor:(UIColor *) edColor;

/**
 * 依据出生时间计算年龄
 */
+(int)findUserAgeValueByTime:(NSString *) timeValue;

/**
 * 出生时间格式方法
 */
+(NSString *)convertTimeYMD:(NSDate *) date;

/**
 * 时间格式转换yyyy-mm-dd
 */
+(NSString *)convertTimeSpaceYMD:(NSDate *) date;

/**
 * 时间转换格式 mm-dd
 */
+(NSString *)convertTimeMMdd:(NSString *) createTime;

/**
 * 生日时间转换日期
 */
+(NSDate *)convertTimeDate:(NSString *) birDay;

@end
