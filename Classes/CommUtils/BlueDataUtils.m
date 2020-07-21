//
//  CommDataUtils.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/8.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "BlueDataUtils.h"
#import "CommUtils.h"
#import "MJDataCacheManager.h"
#import "MJHttpDataUtils.h"

@implementation BlueDataUtils

/**
* NSString 转 SNDictionary
*/
+(NSMutableDictionary *)converStringToDictionary:(NSString *)jsonValue{
    
    NSData *data = [jsonValue dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSMutableDictionary * resultData = [NSMutableDictionary dictionaryWithDictionary:resultDic];
    
    return resultData;
    
}

/**
* NSDictionary 转 NSString
*/
+(NSString *)convertDictionyToString:(NSDictionary *) dictionary{
    
    NSString *jsonResult = @"";
    if([dictionary isKindOfClass:[NSDictionary class]]){
        NSData *data = [NSData dataWithData:[NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil]];
        jsonResult = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return jsonResult;
    
}


/**
 * 获取蓝牙返回结果code
 */
+(NSInteger)findBlueResultCode:(NSString *)jsonVaule{
    
    NSInteger code = 100;
    NSDictionary *resultData = [self converStringToDictionary:jsonVaule];
    if([resultData isKindOfClass:[NSDictionary class]]){
        NSString *resultCode = resultData[@"code"];
        if(resultCode){
            code = [resultCode integerValue];
        }
    }
    return code;
}

/**
 * 获取蓝牙返回结果
 * weight 体重
 */
+(NSString *)findBlueResultWeight:(NSString *)jsonValue{
    
    NSString *weightValue = @"";
    NSDictionary *resultData = [self converStringToDictionary:jsonValue];
    if([resultData isKindOfClass:[NSDictionary class]]){
        NSDictionary *resultDetails = resultData[@"details"];
        if([resultDetails isKindOfClass:[NSDictionary class]]){
            float weight = [resultDetails[@"weight"] floatValue];
            weightValue = [NSString stringWithFormat:@"%.2f",weight];
        }
    }
    return weightValue;
    
}

/**
 * 获取秤蓝牙地址
 */
+(NSString *)findBlueDeviceMac:(NSString *)jsonValue{
    
    NSString *deviceMac = @"";
    NSDictionary *resultData = [self converStringToDictionary:jsonValue];
    if([resultData isKindOfClass:[NSDictionary class]]){
        NSDictionary *resultDetails = resultData[@"details"];
        if([resultDetails isKindOfClass:[NSDictionary class]]){
            NSDictionary *deviceInfo = resultDetails[@"deviceInfo"];
            if([deviceInfo isKindOfClass:[NSDictionary class]]){
                deviceMac = deviceInfo[@"deviceMac"];
            }
        }
    }
    return deviceMac;
    
}


/**
 * 获取蓝牙设备SN
 */
+(NSString *)findBlueDeviceSN:(NSString *)jsonValue{
    
    NSString *deviceSN = @"";
       NSDictionary *resultData = [self converStringToDictionary:jsonValue];
       if([resultData isKindOfClass:[NSDictionary class]]){
           NSDictionary *resultDetails = resultData[@"details"];
           if([resultDetails isKindOfClass:[NSDictionary class]]){
               deviceSN = resultDetails[@"sn"];
           }
       }
       return deviceSN;
    
}

/**
 * 获取正常测量结果dataId
 */
+(NSString *)findBlueResultDataId:(NSString *)jsonValue{
    
    NSString *dataId = @"";
    NSDictionary *resultData = [self converStringToDictionary:jsonValue];
    if([resultData isKindOfClass:[NSDictionary class]]){
        NSDictionary *resultDetails = resultData[@"details"];
        if([resultDetails isKindOfClass:[NSDictionary class]]){
            NSDictionary *deviceInfo = resultDetails[@"deviceInfo"];
            if([deviceInfo isKindOfClass:[NSDictionary class]]){
                dataId = deviceInfo[@"dataId"];
            }
        }
    }
    return dataId;
    
}

/**
 * 体重小数部分转化
 */
+(NSString *)convertWeightDecimal:(NSString *) weight{
    NSArray *subItems = [weight componentsSeparatedByString:@"."];
    return subItems[1];
}

/**
* 体重整数部分转化
*/
+(NSString *)convertWeightInteger:(NSString *) weight{
    NSArray *subItems = [weight componentsSeparatedByString:@"."];
    return [NSString stringWithFormat:@"%@.",subItems[0]];
}


/**
 * 测量结果优化方法
 */
+(NSString *)convertMesureResultData:(NSString *)json{
    
    if(!json || [json isEqualToString:@""]) return @"";
    
    NSString * regExpStr = @"((\\d+)\\.(\\d{2}))(\\d+)";
    NSString * replacement = @"$1";
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
    NSString *resultStr = json;
    resultStr = [regExp stringByReplacingMatchesInString:json
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, json.length)
                                                    withTemplate:replacement];
    return resultStr;
}

/**
 * 数据过滤
 */
+(NSString *)filterFloatData:(NSString *) data{
    
    if(!data || [data isEqualToString:@""]) return @"";
    
    NSString * regExpStr = @"((\\d+)\\.(\\d{2}))(\\d+)";
    NSString * replacement = @"$1";
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:regExpStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
    NSString *resultStr = data;
    resultStr = [regExp stringByReplacingMatchesInString:data
                                                         options:NSMatchingReportProgress
                                                           range:NSMakeRange(0, data.length)
                                                    withTemplate:replacement];
    return resultStr;
    
}


/**
 * 获取用户所属阶段
 */
+(NSString *)findUserStageDes:(NSDate *) date{
    
    NSString *stageDes = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    NSDate *currentDate = [dateFormatter dateFromString:currentDateStr];
    
    NSTimeInterval time=[currentDate timeIntervalSinceDate:date];
    int age = ((int)time)/(3600*24*365);
    
    if(age > 18){
        stageDes = @"成人阶段";
    }else if(age <= 18 && age >= 7){
        stageDes = @"中小学阶段";
    }else if(age <= 7 && age >2){
        stageDes = @"幼儿阶段";
    }else{
        stageDes = @"婴儿阶段";
    }

    return stageDes;
}

/**
 * 依据指标名称获取颜色
 */
+(NSString *)findIndexColorValueByName:(NSString *) statusName{
    
//    标准/优/健康/正常就是蓝色 瘦/偏低/偏瘦/不足/过轻/缺失就是青色 偏高/高/胖/过重/警戒/轻度肥胖就是橙色  肥胖/重度肥胖/严重偏高就是粉色
    
    NSString *colorValue ;
    
    if([statusName isEqualToString:@"不⾜"]){
        NSLog(@"---");
    }
    
    if([statusName isEqualToString:@"标准"] || [statusName isEqualToString:@"优"] || [statusName isEqualToString:@"健康"] || [statusName isEqualToString:@"正常"]){
        colorValue = @"r_blue";
    }else if([statusName isEqualToString:@"瘦"] || [statusName isEqualToString:@"偏低"] || [statusName isEqualToString:@"偏瘦"] || [statusName isEqualToString:@"不⾜"] || [statusName isEqualToString:@"过轻"] || [statusName isEqualToString:@"缺失"]){
        colorValue = @"r_agreen";
    }else if([statusName isEqualToString:@"偏⾼"] || [statusName isEqualToString:@"高"] || [statusName isEqualToString:@"胖"] || [statusName isEqualToString:@"过重"] || [statusName isEqualToString:@"警戒"] || [statusName isEqualToString:@"轻度肥胖"] || [statusName isEqualToString:@"偏胖"]){
        colorValue = @"r_yellow";
    }else if([statusName isEqualToString:@"肥胖"] || [statusName isEqualToString:@"重度肥胖"] || [statusName isEqualToString:@"严重偏高"]){
        colorValue = @"r_red";
    }else{
        colorValue = @"";
    }//F2A77B  //EEAFCC
    return colorValue;
}

/**
 * 获取理想值区间
 */
+(NSString *)findStandarSpaceByName:(NSString *) standarName withStandar:(NSString *) standar{
    
    
    NSString *standarSpace = @"理想：-";
    int label = 0;
    id indexObjects = [MJDataCacheManager findStandarListJsonData];
    if(!indexObjects || [@"" isEqualToString:indexObjects]) return standarSpace;
    
    NSArray *indexList = [MJHttpDataUtils convertIndexStandarListJson:indexObjects];
    
    for (IndexStandarItem *staItem in indexList) {
        
        NSString *value = staItem.value;
        if([value isEqualToString:standarName]){
            label = [staItem.label intValue];
            break;
        }
    
    }
    
    //处理数值区间
    NSArray *items = [standar componentsSeparatedByString:@","];
    
    if(label <= items.count && label !=0){
        
        NSString *startValue = items[label-1];
        NSString *endValue = items[label];
        
        standarSpace = [NSString stringWithFormat:@"理想：%@~%@",startValue,endValue];
        
    }
    
    return standarSpace;
}


/**
 * 获取最后一个标准指标值
 */
+(CGFloat)findIndexLastValue:(NSString *) standarValue{
    
    CGFloat lastValue = 0;
    
    NSArray *items = [standarValue componentsSeparatedByString:@","];
    if(items.count > 0)
        lastValue = [items.lastObject floatValue];
    
    return lastValue;
}

@end
