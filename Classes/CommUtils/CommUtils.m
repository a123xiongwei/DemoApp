//
//  CommUtils.m
//  rrtApp
//
//  Created by yuangang on 15/3/30.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import "CommUtils.h"
#import "AppConstants.h"

@implementation CommUtils

/**
 *  颜色转换方法
 *
 *  @param stringToConvert rgb字符值
 *
 *  @return UIColor
 */
+(UIColor *)colorWithHexString:(NSString *)stringToConvert{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    else if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

#pragma mark -UITextView 文字内容的高度
+(CGFloat)getContentHeight:(NSString *) conStr {
    float conHeight;
    if([conStr length] == 1){
        conStr = [conStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    }
    if(conStr == nil || [conStr isEqualToString:@""] || [conStr length]<1 ) return 0;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    // 计算文本的大小
    CGSize textSize = [conStr boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    conHeight = textSize.height +1;
    return conHeight;
}

+(CGSize)sizeWithString:(NSString*)str andFont:(UIFont*)font  andMaxSize:(CGSize)size{
    NSDictionary*attrs = @{NSFontAttributeName: font};
    return  [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs  context:nil].size;
}

/**
 *  颜色值转换成UIImage对象
 *
 *  @param color 颜色对象
 *
 *  @return UIImage
 */
+(UIImage *)imageWithBgColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *获取渐变背景Layer
 */
+(CAGradientLayer *)findCGGradientLayer:(CGSize ) size withStartColors:(UIColor *)stColor endColor:(UIColor *) edColor{
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,size.width,size.height);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)stColor.CGColor,(__bridge id)edColor.CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
       
    return gl;
    
}


/**
 * 依据出生时间计算年龄
 */
+(int)findUserAgeValueByTime:(NSString *) timeValue{
    
    //计算年龄
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    //生日
    NSDate *birthDay = [dateFormatter dateFromString:timeValue];
    //当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
  
    NSTimeInterval time=[currentDate timeIntervalSinceDate:birthDay];
    int age = ((int)time)/(3600*24*365);
    NSLog(@"year %d",age);
    
    return age;
}

/**
 * 出生时间格式方法
 */
+(NSString *)convertTimeYMD:(NSDate *) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
}


/**
 * 时间格式转换yyyy-mm-dd
 */
+(NSString *)convertTimeSpaceYMD:(NSDate *) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *time = [dateFormatter stringFromDate:date];
    return time;
}

/**
 * 时间转换格式 mm-dd
 */
+(NSString *)convertTimeMMdd:(NSString *) createTime{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *createDate = [dateFormatter dateFromString:createTime];
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *time = [dateFormatter stringFromDate:createDate];
    
    return time;
}


/**
 * 生日时间转换日期
 */
+(NSDate *)convertTimeDate:(NSString *) birDay{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *birthDay = [dateFormatter dateFromString:birDay];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate:birthDay];
    birthDay = [birthDay dateByAddingTimeInterval:interval];
    
    return birthDay;
}

@end



