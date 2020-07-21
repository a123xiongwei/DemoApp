//
//  CommDataUtils.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/8.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BlueDataUtils : NSObject

/**
 * NSString 转 SNDictionary
 */
+(NSMutableDictionary *)converStringToDictionary:(NSString *)jsonValue;


/**
 * NSDictionary 转 NSString
 */
+(NSString *)convertDictionyToString:(NSDictionary *) dictionary;

/**
 * 获取蓝牙返回结果
 * code 结果编码
 */
+(NSInteger)findBlueResultCode:(NSString *)jsonVaule;

/**
 * 获取蓝牙返回结果
 * weight 体重
 */
+(NSString *)findBlueResultWeight:(NSString *)jsonValue;

/**
 * 获取秤蓝牙地址
 */
+(NSString *)findBlueDeviceMac:(NSString *)jsonValue;


/**
 * 获取蓝牙设备SN
 */
+(NSString *)findBlueDeviceSN:(NSString *)jsonValue;

/**
 * 获取正常测量结果dataId
 */
+(NSString *)findBlueResultDataId:(NSString *)jsonValue;

/**
 * 体重小数部分转化
 */
+(NSString *)convertWeightDecimal:(NSString *) weight;

/**
* 体重整数部分转化
*/
+(NSString *)convertWeightInteger:(NSString *) weight;

/**
 * 测量结果优化方法
 */
+(NSString *)convertMesureResultData:(NSString *)json;

/**
 * 数据过滤
 */
+(NSString *)filterFloatData:(NSString *) data;

/**
 * 获取用户所属阶段
 */
+(NSString *)findUserStageDes:(NSDate *) date;

/**
 * 依据指标名称获取颜色
 */
+(NSString *)findIndexColorValueByName:(NSString *) statusName;

/**
 * 获取理想值区间
 */
+(NSString *)findStandarSpaceByName:(NSString *) standarName withStandar:(NSString *) standar;

/**
 * 获取最后一个标准指标值
 */
+(CGFloat)findIndexLastValue:(NSString *) standarValue;

@end

NS_ASSUME_NONNULL_END
