//
//  MJHttpDataUtils.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/9.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJHttpDataUtils : NSObject

/**
 * 获取麦咭Token值方法
 * resultData 接口返回结果
 */
+(NSString *)findMJAccountToken:(NSDictionary *) resultData;

/**
* 获取麦咭Token值方法
* resultData 接口返回结果
*/
+(NSString *)findMJSecurityToken:(NSDictionary *)resultData;


/**
 * 获取系统Token方法
 */
+(NSString *)findSystemAccountToken:(LoginAccountItem *) accountItem;


/**
 * 登录用户信息的转换
 */
+(LoginAccountItem *)convertLoginAccountItemJson:(id) objects;


/**
 * 获取设备类型转换列表
 */
+(NSMutableArray *)convertDeviceTypeListJson:(id) objects;


/**
 * 获取所有子设备列表
 */
+(NSMutableArray *)convertAllSubDeviceList:(NSMutableArray *) typeList;


/**
 * 亲友信息的转换列表
 */
+(NSMutableArray *)convertRelationUserListJson:(id) objects;


/**
 * 转换自己信息列表
 */
+(RelationUserItem *)convertThisRelationUser:(id) objects;


/**
 * 转换字典关系列表
 */
+(NSMutableArray *)convertRelationListJson:(id) objects;


/**
 * 转换我的设备列表
 */
+(NSMutableArray *)convertMyDeviceListJson:(id) objects;


/**
 * 转换亲友体重信息列表
 */
+(NSMutableArray *)convertRelationWeightListJson:(id) objects;


/**
 * 转换上传头像地址
 */
+(NSString *)convertRelationUserAvatarJson:(id) objects;


/**
 * 成员详情转换
 */
+(RelationDetailsItem *)convertRelationDetailsJson:(id) objects;


/**
 * 成员分析列表转换
 */
+(NSMutableArray *)convertRelationRecordListJson:(id) objects;


/**
 * 通过详情转换关系成员类
 */
+(RelationUserItem *)convertRelationUserItem:(RelationDetailsItem *) detailsItem;


/**
 * 报告详情的转换
 */
+(ReportDetailsItem *)convertReportDetailsJson:(id) objects;


/**
 * 指标列表的转换
 */
+(NSMutableArray *)convertIndexSubItemByReportDetails:(ReportDetailsItem *) detailsItem;


/**
 * 指标标准字典转换
 */
+(NSMutableArray *)convertIndexStandarListJson:(id) objects;


@end

NS_ASSUME_NONNULL_END
