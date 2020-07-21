//
//  MJHttpDataUtils.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/9.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJHttpDataUtils.h"
#import <MJExtension.h>
#import "MJDataCacheManager.h"
#import "BlueDataUtils.h"

@implementation MJHttpDataUtils

/**
 * 获取麦咭Token值方法
 * resultData 接口返回结果
 */
+(NSString *)findMJAccountToken:(NSDictionary *) resultData{
    NSString *tokenValue = @"";
    
    NSDictionary *body = resultData[@"body"];
    if([body isKindOfClass:[NSDictionary class]]){
        tokenValue = body[@"token"];
    }
    
    return tokenValue;
}

/**
* 获取麦咭Token值方法
* resultData 接口返回结果
*/
+(NSString *)findMJSecurityToken:(NSDictionary *)resultData{
    NSString *tokenValue = @"";
    
    NSDictionary *body = resultData[@"body"];
    if([body isKindOfClass:[NSDictionary class]]){
        tokenValue = body[@"token"];
    }
    
    return tokenValue;
    
}

/**
 * 获取系统Token方法
 */
+(NSString *)findSystemAccountToken:(LoginAccountItem *) accountItem{
    
    NSString *systemToken = accountItem.token;
    
    return systemToken;
}

/**
 * 登录用户信息的转换
 */
+(LoginAccountItem *)convertLoginAccountItemJson:(id) objects{
    
    LoginAccountItem *accountItem ;
    NSDictionary *data = objects[@"data"];
    if([data isKindOfClass:[NSDictionary class]]){
        accountItem = [LoginAccountItem mj_objectWithKeyValues:data];
    }
    
    return accountItem;
}

/**
 * 获取设备类型转换列表
 */
+(NSMutableArray *)convertDeviceTypeListJson:(id) objects{
    
    NSMutableArray *muArray = [NSMutableArray array];
    NSArray *data = objects[@"data"];
    if([data isKindOfClass:[NSArray class]]){
        
        NSArray *array = [DeviceTypeItem mj_objectArrayWithKeyValuesArray:data];
        [muArray addObjectsFromArray:array];
        
    }
    
    //数据背景和子设备处理
    for (DeviceTypeItem *typeItem in muArray) {
        typeItem.isSelect = @"0";
        if([typeItem.categoryId isEqualToString:@"1"]){
            typeItem.isSelect = @"1";
            typeItem.bgIcon = @"h_weight_bg";
            typeItem.icon = @"s_weight_icon";
        }else if([typeItem.categoryId isEqualToString:@"2"]){
            typeItem.bgIcon = @"h_robot_bg";
            typeItem.icon = @"s_robot_icon";
        }else if([typeItem.categoryId isEqualToString:@"3"]){
            typeItem.bgIcon = @"h_watch_bg";
            typeItem.icon = @"s_watch_icon";
        }else if([typeItem.categoryId isEqualToString:@"4"]){
            typeItem.bgIcon = @"h_circle_bg";
            typeItem.icon = @"s_circle_icon";
        }
        
        NSArray *goodsDtos = typeItem.goodsDtos;
        if(goodsDtos && goodsDtos.count > 0){
            NSArray *array = [DeviceSubItem mj_objectArrayWithKeyValuesArray:goodsDtos];
            typeItem.goodsDtos = array;
        }
        
    }
    
    return muArray;
}


/**
 * 获取所有子设备列表
 */
+(NSMutableArray *)convertAllSubDeviceList:(NSMutableArray *) typeList{
    
    NSMutableArray *muArray = [NSMutableArray array];
    
    for (DeviceTypeItem *typeItem in typeList) {
        NSArray *goodsDtos = typeItem.goodsDtos;
        if(goodsDtos.count > 0){
            [muArray addObjectsFromArray:goodsDtos];
        }
    }
    
    return muArray;
}

/**
 * 亲友信息的转换列表
 */
+(NSMutableArray *)convertRelationUserListJson:(id) objects{
    
    NSMutableArray *muArray = [NSMutableArray array];
    
    NSDictionary *data = objects[@"data"];
    if([data isKindOfClass:[NSDictionary class]]){
        
        //自己信息
        NSDictionary *thisData = data[@"this"];
        RelationUserItem *userItem = [RelationUserItem mj_objectWithKeyValues:thisData];
        userItem.relativesWeight = [BlueDataUtils convertMesureResultData:userItem.relativesWeight];
        [muArray addObject:userItem];
        
        //其他亲友信息
        NSArray *otherListData = data[@"otherList"];
        if([otherListData isKindOfClass:[NSArray class]]){
            NSArray *listData = [RelationUserItem mj_objectArrayWithKeyValuesArray:otherListData];
            [muArray addObjectsFromArray:listData];
        }
        
        for (RelationUserItem *userItem in muArray) {
            userItem.relativesWeight = [BlueDataUtils convertMesureResultData:userItem.relativesWeight];
        }
        
    }
    
    //设置是否当前选择默认成员
    NSString *relationId = [MJDataCacheManager findSelectRelationId];
    for (RelationUserItem *userItem in muArray) {
        if([relationId isEqualToString:userItem.relativesId]){
            userItem.isSelect = @"1";
            break;
        }
    }
    
    return muArray;
}


/**
 * 转换自己信息列表
 */
+(RelationUserItem *)convertThisRelationUser:(id) objects{
    
    RelationUserItem *userItem;
    NSDictionary *data = objects[@"data"];
    if([data isKindOfClass:[NSDictionary class]]){
        //自己信息
        NSDictionary *thisData = data[@"this"];
        userItem = [RelationUserItem mj_objectWithKeyValues:thisData];
        userItem.relativesWeight = [BlueDataUtils filterFloatData:userItem.relativesWeight];
    }
    
    return userItem;
    
}

/**
 * 转换字典关系列表
 */
+(NSMutableArray *)convertRelationListJson:(id) objects{
    
    NSMutableArray *muArray = [NSMutableArray array];
    NSDictionary *data = objects[@"data"];
    if([data isKindOfClass:[NSDictionary class]]){
        NSArray *dictDetails = data[@"dictDetails"];
        if([dictDetails isKindOfClass:[NSArray class]]){
            NSArray *array = [RelationItem mj_objectArrayWithKeyValuesArray:dictDetails];
            [muArray addObjectsFromArray:array];
        }
    }
    return muArray;
}


/**
 * 转换我的设备列表
 */
+(NSMutableArray *)convertMyDeviceListJson:(id) objects{
    
    NSMutableArray *muArray = [NSMutableArray array];
    if([objects isKindOfClass:[NSDictionary class]]){
        
        NSArray *data = objects[@"data"];
        if([data isKindOfClass:[NSArray class]]){
            NSArray *array = [BlueDeviceItem mj_objectArrayWithKeyValuesArray:data];
            [muArray addObjectsFromArray:array];
        }
    }
    return muArray;
}

/**
 * 转换亲友体重信息列表
 */
+(NSMutableArray *)convertRelationWeightListJson:(id) objects{
    
    NSMutableArray *muArray = [NSMutableArray array];
    NSArray *data = objects[@"data"];
    if([data isKindOfClass:[NSArray class]]){        
        NSArray *array = [RelationWeightItem mj_objectArrayWithKeyValuesArray:data];
        [muArray addObjectsFromArray:array];
    }
    for (RelationWeightItem *weightItem in muArray) {
        weightItem.relativesWeight = [BlueDataUtils convertMesureResultData:weightItem.relativesWeight];
    }
    return muArray;
}


/**
 * 转换上传头像地址
 */
+(NSString *)convertRelationUserAvatarJson:(id) objects{
    
    NSString *avatarUrl;
    NSDictionary *data = objects[@"body"];
    if([data isKindOfClass:[NSDictionary class]]){
        avatarUrl = data[@"url"];
    }
    return avatarUrl;
    
}


/**
 * 成员详情转换
 */
+(RelationDetailsItem *)convertRelationDetailsJson:(id) objects{
    
    RelationDetailsItem *detailsItem ;
    NSDictionary *data = objects[@"data"];
    if([data isKindOfClass:[NSDictionary class]]){
        NSDictionary *relativesDto = data[@"relativesDto"];
        if([relativesDto isKindOfClass:[NSDictionary class]]){
            detailsItem = [RelationDetailsItem mj_objectWithKeyValues:relativesDto];
            detailsItem.relativesWeight = [BlueDataUtils filterFloatData:detailsItem.relativesWeight];
        }
    }
    
    return detailsItem;
}


/**
 * 成员分析列表转换
 */
+(NSMutableArray *)convertRelationRecordListJson:(id) objects{
    
    NSMutableArray *muArray = [NSMutableArray array];
    NSDictionary *data = objects[@"data"];
    if([data isKindOfClass:[NSDictionary class]]){
        NSArray *recordDtoList = data[@"recordDtoList"];
        NSArray *array = [RelationRecordItem mj_objectArrayWithKeyValuesArray:recordDtoList];
        [muArray addObjectsFromArray:array];
    }
    
    for (RelationRecordItem *recordItem in muArray) {
        recordItem.relativesWeight = [BlueDataUtils filterFloatData:recordItem.relativesWeight];
    }
    
    return muArray;
}

/**
 * 通过详情转换关系成员类
 */
+(RelationUserItem *)convertRelationUserItem:(RelationDetailsItem *) detailsItem{
    
    RelationUserItem *userItem = [[RelationUserItem alloc] init];
    userItem.relativesNickName = detailsItem.relativesNickName;
    userItem.relativesSex = detailsItem.relativesSex;
    userItem.relativesBirthday = detailsItem.relativesBirthday;
    userItem.relativesWith = detailsItem.relativesWith;
    userItem.relativesHeight = detailsItem.relativesHeight;
    userItem.relativesWithName = detailsItem.relativesWithName;
    userItem.relativesId = detailsItem.relativesId;
    userItem.relativesPicUrl = detailsItem.relativesPicUrl;
    userItem.relativesWithName = detailsItem.relativesWithName;
    
    return userItem;
}

/**
 * 报告详情的转换
 */
+(ReportDetailsItem *)convertReportDetailsJson:(id) objects{
    
    ReportDetailsItem *detailsItem ;
    NSDictionary *data = objects[@"data"];
    if([data isKindOfClass:[NSDictionary class]]){
        detailsItem = [ReportDetailsItem mj_objectWithKeyValues:data];
        detailsItem.relativesWeight = [BlueDataUtils filterFloatData:detailsItem.relativesWeight];
    }
    return detailsItem;
}


/**
 * 指标列表的转换
 */
+(NSMutableArray *)convertIndexSubItemByReportDetails:(ReportDetailsItem *) detailsItem{
    
    NSMutableArray *muArray = [NSMutableArray array];
    
    if(detailsItem){
        
        //体重
        IndexSubItem *weightSubItem = [MJHttpDataUtils initWith:@"体重" value:detailsItem.relativesWeight level:detailsItem.weightStatusName status:detailsItem.weightStatus standard:detailsItem.standardWeight unit:@"kg" icon:@"r_weight_icon"];
        weightSubItem.standardName = @"standardWeight";
        [muArray addObject:weightSubItem];
        
        
        //BMI
        IndexSubItem *bmiSubItem = [MJHttpDataUtils initWith:@"BMI" value:detailsItem.relativesBmi level:detailsItem.bmiStatusName status:detailsItem.bmiStatus standard:detailsItem.standardBmi unit:@"" icon:@"r_bmi"];
        bmiSubItem.standardName = @"standardBmi";
        [muArray addObject:bmiSubItem];
        
        //身体类型
        IndexSubItem *bodySubItem = [MJHttpDataUtils initWith:@"身体类型" value:@"" level:detailsItem.relativesShapeName status:detailsItem.weightStatus standard:@"" unit:@"" icon:@"r_body"];
        bodySubItem.standardName = @"";
        [muArray addObject:bodySubItem];
        
        //体脂率
        IndexSubItem *fatRateSubItem = [MJHttpDataUtils initWith:@"体脂率" value:detailsItem.bodyFatRate level:detailsItem.bodyFatRateStatusName status:detailsItem.bodyFatRateStatus standard:detailsItem.standardBodyFatRate unit:@"%" icon:@"r_fatrate"];
        fatRateSubItem.standardName = @"standardBodyFatRate";
         [muArray addObject:fatRateSubItem];
        
        //脂肪重量
        IndexSubItem *fatWeightSubItem = [MJHttpDataUtils initWith:@"脂肪重量" value:detailsItem.fatWeight level:detailsItem.fatWeightStatusName status:detailsItem.fatWeightStatus standard:detailsItem.standardFatWeight unit:@"kg" icon:@"r_fatweight"];
        fatWeightSubItem.standardName = @"standardFatWeight";
        [muArray addObject:fatWeightSubItem];
        
        //骨骼肌率
        IndexSubItem *skeletalSubItem = [MJHttpDataUtils initWith:@"骨骼肌率" value:detailsItem.ratioSkeletalMuscle level:detailsItem.skeletalMuscleRateStatusName status:detailsItem.skeletalMuscleRateStatus standard:detailsItem.standardSkeletalMuscleRate unit:@"%" icon:@"r_skeletal"];
        skeletalSubItem.standardName = @"standardSkeletalMuscleRate";
        [muArray addObject:skeletalSubItem];
        
        //骨骼肌重量
        IndexSubItem *sub1Item = [MJHttpDataUtils initWith:@"骨骼肌重量" value:detailsItem.weightSkeletalMuscle level:detailsItem.weightSkeletalMuscleStatusName status:detailsItem.weightSkeletalMuscleStatus standard:detailsItem.standardWeightSkeletalMuscle unit:@"kg" icon:@"r_skeletalweight"];
        sub1Item.standardName = @"standardWeightSkeletalMuscle";
        [muArray addObject:sub1Item];
        
        //肌肉重量
        IndexSubItem *muscleWeightSubItem = [MJHttpDataUtils initWith:@"肌肉重量" value:detailsItem.muscleWeight level:detailsItem.muscleWeightStatusName status:detailsItem.muscleWeightStatus standard:detailsItem.standardMuscleWeight unit:@"kg" icon:@"r_muscleweight"];
        muscleWeightSubItem.standardName = @"standardMuscleWeight";
        [muArray addObject:muscleWeightSubItem];
        
        //肌肉率
        IndexSubItem *muscleRateSubItem = [MJHttpDataUtils initWith:@"肌肉率" value:detailsItem.muscleRate level:detailsItem.muscleRateStatusName status:detailsItem.muscleRateStatus standard:detailsItem.standardMuscleRate unit:@"%" icon:@"r_musclerate"];
        muscleRateSubItem.standardName = @"standardMuscleRate";
        [muArray addObject:muscleRateSubItem];
        
        //内脏脂肪
        IndexSubItem *visceralFatSubItem = [MJHttpDataUtils initWith:@"内脏脂肪" value:detailsItem.visceralFat level:detailsItem.visceralFatStatusName status:detailsItem.visceralFatStatus standard:detailsItem.standardVisceralFat unit:@"kg" icon:@"r_visceral"];
        visceralFatSubItem.standardName = @"standardVisceralFat";
        [muArray addObject:visceralFatSubItem];
        
        //水份
        IndexSubItem *watercontentSubItem = [MJHttpDataUtils initWith:@"水份" value:detailsItem.waterContent level:detailsItem.waterContentStatusName status:detailsItem.waterContentStatus standard:detailsItem.standardWaterContent unit:@"kg" icon:@"r_water"];
        watercontentSubItem.standardName = @"standardWaterContent";
        [muArray addObject:watercontentSubItem];
        
        //水含量
        IndexSubItem *waterRateSubItem = [MJHttpDataUtils initWith:@"水含量" value:detailsItem.waterRate level:detailsItem.waterRateStatusName status:detailsItem.waterRateStatus standard:detailsItem.standardWaterRate unit:@"%" icon:@"r_waterrate"];
        waterRateSubItem.standardName = @"standardWaterRate";
        [muArray addObject:waterRateSubItem];
        
        //基础代谢
        IndexSubItem *basalMetabolismSubItem = [MJHttpDataUtils initWith:@"基础代谢" value:detailsItem.basalMetabolism level:detailsItem.basalMetabolismStatusName status:detailsItem.basalMetabolismStatus standard:detailsItem.standardBasalMetabolism unit:@"" icon:@"r_basal"];
        basalMetabolismSubItem.standardName = @"standardBasalMetabolism";
        [muArray addObject:basalMetabolismSubItem];
        
        //骨量
        IndexSubItem *boneMassSubItem = [MJHttpDataUtils initWith:@"骨量" value:detailsItem.boneMass level:detailsItem.boneMassStatusName status:detailsItem.boneMassStatus standard:detailsItem.standardBoneMass unit:@"kg" icon:@"r_bone"];
        boneMassSubItem.standardName = @"standardBoneMass";
        [muArray addObject:boneMassSubItem];
        
        //蛋白质
        IndexSubItem *proteinSubItem = [MJHttpDataUtils initWith:@"蛋白质" value:detailsItem.protein level:detailsItem.proteinStatusName status:detailsItem.proteinStatus standard:detailsItem.standardProtein unit:@"kg" icon:@"r_protein"];
        proteinSubItem.standardName = @"standardProtein";
        [muArray addObject:proteinSubItem];
        
        //去脂体重
        IndexSubItem *sub2Item = [MJHttpDataUtils initWith:@"去脂体重" value:detailsItem.leanBodyMass level:@"" status:@"" standard:@"" unit:@"kg" icon:@"r_redweight"];
        [muArray addObject:sub2Item];
        
        //身体年龄
        IndexSubItem *sub3Item = [MJHttpDataUtils initWith:@"身体年龄" value:detailsItem.bodyAge level:@"" status:@"" standard:@"" unit:@"" icon:@"r_bodyage"];
        [muArray addObject:sub3Item];
        
    }
    
    
    return muArray;
}

/**
 * 报告指标初始化方法
 *  name 名称
 *  value 测量值
 *  level 标准描叙
 *  status 标准状态
 *  standard 标准区间
 *  unit 单位
 *  icon 指标图标名
 *
 */
+(IndexSubItem *)initWith:(NSString *)name value:(NSString *)value level:(NSString *)level status:(NSString *)status standard:(NSString *)standard unit:(NSString *)unit icon:(NSString *)icon{
    
    IndexSubItem *subItem = [[IndexSubItem alloc] init];
    subItem.name = name;
    subItem.value = value;
    subItem.level = level;
    subItem.status = status;
    subItem.standard = standard;
    subItem.unit = unit;
    subItem.icon = icon;
    
    return subItem;
}

/**
 * 指标标准字典转换
 */
+(NSMutableArray *)convertIndexStandarListJson:(id) objects{
    
    NSMutableArray *muArray = [NSMutableArray array];
    NSDictionary *data = objects[@"data"];
    if([data isKindOfClass:[NSDictionary class]]){
        NSArray *dictDetails = data[@"dictDetails"];
        if([dictDetails isKindOfClass:[NSArray class]]){
            NSArray *array = [IndexStandarItem mj_objectArrayWithKeyValuesArray:dictDetails];
            [muArray addObjectsFromArray:array];
        }
    }
    
    return muArray;
}

@end
