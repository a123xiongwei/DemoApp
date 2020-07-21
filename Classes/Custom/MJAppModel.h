//
//  MJAppModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/9.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJAppModel : NSObject

@end

NS_ASSUME_NONNULL_END


/**
 * 蓝牙设备信息类
 */
@interface BlueDeviceItem : NSObject

@property (nonatomic, strong) NSString *mac;
@property (nonatomic, strong) NSString *productKey;
@property (nonatomic, strong) NSString *bluetoothAddress;
@property (nonatomic, strong) NSString *serialNumber;
@property (nonatomic, strong) NSString *deviceName;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *deviceSecret;
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *userDeviceId;
@property (nonatomic, strong) NSString *userId;

@end


/**
 * 体脂秤数据详情
 */
@interface ScaleDetailsItem : NSObject

@property (nonatomic, strong) NSString *ageOfBody; //身体年龄
@property (nonatomic, strong) NSArray *ageOfBodyRange;//【<实际，>=实际】

@property (nonatomic, strong) NSString *bmi;
@property (nonatomic, strong) NSArray *bmiRange;
@property (nonatomic, strong) NSArray *bmiWHORange;

@property (nonatomic, strong) NSString *bmr;//基础代谢
@property (nonatomic, strong) NSArray *bmrRange;//【不足，标准】

@property (nonatomic, strong) NSString *bodyShape;// 体型，1-隐性胖，2-偏胖型，3-运动型偏胖，4-缺乏锻炼型，5-标准型， 6-标准运动
@property (nonatomic, strong) NSString *desirableWeight;
@property (nonatomic, strong) NSString *fatFreeBodyWeight;//去脂体重
@property (nonatomic, strong) NSString *fatToControl;//脂肪控制量
@property (nonatomic, strong) NSString *idealWeight;//理想体重

@property (nonatomic, strong) NSString *levelOfVisceralFat;//内脏脂肪等级
@property (nonatomic, strong) NSArray *levelOfVisceralFatRange;//正常，偏高，严重偏高】

@property (nonatomic, strong) NSString *muscleToControl;//肌肉控制量
@property (nonatomic, strong) NSString *obesityLevel;
@property (nonatomic, strong) NSDictionary *rateOfBurnFat;//然脂心率（次数）

@property (nonatomic, strong) NSString *ratioOfFat;//体脂率 %
@property (nonatomic, strong) NSArray *ratioOfFatRange;//【偏瘦，健康，警戒，轻度肥胖，重度肥胖】

@property (nonatomic, strong) NSString *ratioOfMuscle;//肌肉率 %
@property (nonatomic, strong) NSArray *ratioOfMuscleRange;//【不足，标准，优】

@property (nonatomic, strong) NSString *ratioOfProtein;//蛋白质率
@property (nonatomic, strong) NSArray *ratioOfProteinRange;//【不足，标准，优】

@property (nonatomic, strong) NSString *ratioOfSkeletalMuscle;//骨骼肌率 %
@property (nonatomic, strong) NSArray *ratioOfSkeletalMuscleRange;//【不足，标准，优】

@property (nonatomic, strong) NSString *ratioOfSubcutaneousFat;//皮下脂肪 %
@property (nonatomic, strong) NSArray *ratioOfSubcutaneousFatRange;//【偏低，正常，偏高】

@property (nonatomic, strong) NSString *ratioOfWater;//水分 %
@property (nonatomic, strong) NSArray *ratioOfWaterRange;//【缺失，标准，优】

@property (nonatomic, strong) NSString *score;//身体评分
@property (nonatomic, strong) NSString *sn;
@property (nonatomic, strong) NSString *stateOfNutrition;// 营养状态 1-严重营养不良，2-中度营养不良，3-营养不良，4-标准，5-营养过剩，6-营养严重过剩
@property (nonatomic, strong) NSString *weight;//体重
@property (nonatomic, strong) NSArray *weightRange;//【不足，过轻，标准，过重，肥胖】

@property (nonatomic, strong) NSString *weightOfBone;//骨量
@property (nonatomic, strong) NSArray *weightOfBoneRange;//【偏低，正常，优】

@property (nonatomic, strong) NSString *weightOfFat;//脂肪重量
@property (nonatomic, strong) NSArray *weightOfFatRange;//【偏瘦，健康，警戒，轻度肥胖，重度肥胖】

@property (nonatomic, strong) NSString *weightOfMuscle;//肌肉重量
@property (nonatomic, strong) NSArray *weightOfMuscleRange;//【不足，标准，优】

@property (nonatomic, strong) NSString *weightOfProtein;//蛋白质重量
@property (nonatomic, strong) NSArray *weightOfProteinRange;//【不足，标准，优】

@property (nonatomic, strong) NSString *weightOfSkeletalMuscle;//骨骼肌重量

@property (nonatomic, strong) NSString *weightOfWater;//水分重量
@property (nonatomic, strong) NSArray *weightOfWaterRange;//【缺失，标准，优】

@property (nonatomic, strong) NSString *weightToControl;//体重控制量
@property (nonatomic, strong) NSArray *weightWHORange;//【不足，过轻，标准，过重，肥胖】

@end

/**
 * 用户成员对象类
 */
@interface SelectUserItem : NSObject

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *time;

@end


/**
 * 设备类别
 */
@interface DeviceTypeItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *bgIcon;
@property (nonatomic, strong) NSString *hIcon;
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *subCategoryId;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *categoryNote;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *orderLevel;
@property (nonatomic, strong) NSString *categroyKey;
@property (nonatomic, strong) NSArray *goodsDtos;
@property (nonatomic, strong) NSString *isSelect;

@end


/**
 * 子设备类
 */
@interface DeviceSubItem : NSObject

@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSString *corpId;
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *goodsNote;
@property (nonatomic, strong) NSString *productKey;
@property (nonatomic, strong) NSString *isSelect;
@property (nonatomic, strong) NSString *isBind;

@end


/**
 * 用户信息
 */
@interface LoginAccountItem : NSObject

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userType;

@end


/**
 * 亲友关系类
 */
@interface RelationUserItem : NSObject

@property (nonatomic, strong) NSString *relativesPicUrl;
@property (nonatomic, strong) NSString *relativesNickName;
@property (nonatomic, strong) NSString *relativesSex;
@property (nonatomic, strong) NSString *relativesBirthday;
@property (nonatomic, strong) NSString *relativesWith;
@property (nonatomic, strong) NSString *relativesWithName;
@property (nonatomic, strong) NSString *relativesHeight;
@property (nonatomic, strong) NSString *relativesId;
@property (nonatomic, strong) NSString *isSelect;
@property (nonatomic, strong) NSString *relativesBmi;
@property (nonatomic, strong) NSString *relativesWeight;
@property (nonatomic, strong) NSString *relativesBodyFatRate;
@property (nonatomic, strong) NSString *bodyFatRate;

@end


/**
 *  关系类
 */
@interface RelationItem : NSObject

@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *dictId;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *isSelect;

@end


/**
 * 亲友测量信息类
 */
@interface RelationWeightItem : NSObject

@property (nonatomic, strong) NSString *basalMetabolism;
@property (nonatomic, strong) NSString *bodyAge;
@property (nonatomic, strong) NSString *bodyFatRate;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *muscleRate;
@property (nonatomic, strong) NSString *protein;
@property (nonatomic, strong) NSString *relativesBmi;
@property (nonatomic, strong) NSString *relativesWeight;
@property (nonatomic, strong) NSString *visceralFat;
@property (nonatomic, strong) NSString *waterConent;
@property (nonatomic, strong) NSString *bodyStatus;

@end


/**
 * 成分记录类
 */
@interface RelationRecordItem : NSObject

@property (nonatomic, strong) NSString *bmiStatusName;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *heightStatus;
@property (nonatomic, strong) NSString *heightStatusName;
@property (nonatomic, strong) NSString *relativesBmi;
@property (nonatomic, strong) NSString *relativesHeight;
@property (nonatomic, strong) NSString *relativesShapeName;
@property (nonatomic, strong) NSString *relativesStage;
@property (nonatomic, strong) NSString *relativesWeight;
@property (nonatomic, strong) NSString *weightStatus;
@property (nonatomic, strong) NSString *weightStatusName;
@property (nonatomic, strong) NSString *dataId;

@end


/**
 * 成员详情
 */
@interface RelationDetailsItem : NSObject

@property (nonatomic, strong) NSString *bmiStatus;
@property (nonatomic, strong) NSString *bmiStatusName;
@property (nonatomic, strong) NSString *lastWeightTime;
@property (nonatomic, strong) NSString *relativesPicUrl;
@property (nonatomic, strong) NSString *relativesBirthday;
@property (nonatomic, strong) NSString *relativesBmi;
@property (nonatomic, strong) NSString *relativesHeight;
@property (nonatomic, strong) NSString *relativesId;
@property (nonatomic, strong) NSString *relativesNickName;
@property (nonatomic, strong) NSString *relativesSex;
@property (nonatomic, strong) NSString *relativesStage;
@property (nonatomic, strong) NSString *relativesStageName;
@property (nonatomic, strong) NSString *relativesStatus;
@property (nonatomic, strong) NSString *relativesWeight;
@property (nonatomic, strong) NSString *relativesWith;
@property (nonatomic, strong) NSString *relativesWithName;
@property (nonatomic, strong) NSString *standardBmi;
@property (nonatomic, strong) NSString *standarWeight;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *weightStatus;
@property (nonatomic, strong) NSString *weightStatusName;
@property (nonatomic, strong) NSString *dataId;

@end


/**
 * 报告详情
 */
@interface ReportDetailsItem : NSObject

@property (nonatomic, strong) NSString *addWeight;
@property (nonatomic, strong) NSString *basalMetabolism;
@property (nonatomic, strong) NSString *basalMetabolismStatus;
@property (nonatomic, strong) NSString *basalMetabolismStatusName;
@property (nonatomic, strong) NSString *bmiStatus;
@property (nonatomic, strong) NSString *bmiStatusName;
@property (nonatomic, strong) NSString *bodyAge;
@property (nonatomic, strong) NSString *bodyFatRate;
@property (nonatomic, strong) NSString *bodyFatRateStatus;
@property (nonatomic, strong) NSString *bodyFatRateStatusName;
@property (nonatomic, strong) NSString *boneMass;
@property (nonatomic, strong) NSString *boneMassStatus;
@property (nonatomic, strong) NSString *boneMassStatusName;
@property (nonatomic, strong) NSString *compositeScore;
@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *fatWeight;
@property (nonatomic, strong) NSString *fatWeightStatus;
@property (nonatomic, strong) NSString *fatWeightStatusName;
@property (nonatomic, strong) NSString *heightStatus;
@property (nonatomic, strong) NSString *heightStatusName;
@property (nonatomic, strong) NSString *leanBodyMass;
@property (nonatomic, strong) NSString *matchStatus;
@property (nonatomic, strong) NSString *matchTime;
@property (nonatomic, strong) NSString *muscleRate;
@property (nonatomic, strong) NSString *muscleRateStatus;
@property (nonatomic, strong) NSString *muscleRateStatusName;
@property (nonatomic, strong) NSString *muscleWeight;
@property (nonatomic, strong) NSString *muscleWeightStatus;
@property (nonatomic, strong) NSString *muscleWeightStatusName;
@property (nonatomic, strong) NSString *protein;
@property (nonatomic, strong) NSString *proteinStatus;
@property (nonatomic, strong) NSString *proteinStatusName;
@property (nonatomic, strong) NSString *relativesBmi;
@property (nonatomic, strong) NSString *relativesHeight;
@property (nonatomic, strong) NSString *relativesId;
@property (nonatomic, strong) NSString *relativesShape;
@property (nonatomic, strong) NSString *relativesShapeName;
@property (nonatomic, strong) NSString *relativesStage;
@property (nonatomic, strong) NSString *relativesWeight;
@property (nonatomic, strong) NSString *standardBasalMetabolism;
@property (nonatomic, strong) NSString *standardBmi;
@property (nonatomic, strong) NSString *standardBodyFatRate;
@property (nonatomic, strong) NSString *standardBoneMass;
@property (nonatomic, strong) NSString *standardFatWeight;
@property (nonatomic, strong) NSString *standardHeight;
@property (nonatomic, strong) NSString *standardMuscleRate;
@property (nonatomic, strong) NSString *standardMuscleWeight;
@property (nonatomic, strong) NSString *standardProtein;
@property (nonatomic, strong) NSString *standardVisceralFat;
@property (nonatomic, strong) NSString *standardWaterContent;
@property (nonatomic, strong) NSString *standardWaterRate;
@property (nonatomic, strong) NSString *standardWeight;
@property (nonatomic, strong) NSString *standardWeightSkeletalMuscle;
@property (nonatomic, strong) NSString *standardSkeletalMuscleRate;
@property (nonatomic, strong) NSString *suggest;
@property (nonatomic, strong) NSString *visceralFat;
@property (nonatomic, strong) NSString *visceralFatStatus;
@property (nonatomic, strong) NSString *visceralFatStatusName;
@property (nonatomic, strong) NSString *waterContent;
@property (nonatomic, strong) NSString *waterContentStatus;
@property (nonatomic, strong) NSString *waterContentStatusName;
@property (nonatomic, strong) NSString *waterRate;
@property (nonatomic, strong) NSString *waterRateStatus;
@property (nonatomic, strong) NSString *waterRateStatusName;
@property (nonatomic, strong) NSString *weightStatus;
@property (nonatomic, strong) NSString *weightStatusName;
@property (nonatomic, strong) NSString *weightSkeletalMuscle;
@property (nonatomic, strong) NSString *weightSkeletalMuscleStatus;
@property (nonatomic, strong) NSString *weightSkeletalMuscleStatusName;
@property (nonatomic, strong) NSString *ratioSkeletalMuscle;
@property (nonatomic, strong) NSString *skeletalMuscleRateStatus;
@property (nonatomic, strong) NSString *skeletalMuscleRateStatusName;


@end

/**
 * 指标对象类
 */
@interface IndexSubItem : NSObject

@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *standard;
@property (nonatomic, strong) NSString *unit;
@property (nonatomic, strong) NSString *standardName;


@end


/**
 * 标准指标字典
 */
@interface IndexStandarItem : NSObject

@property (nonatomic, strong) NSString *detailId;
@property (nonatomic, strong) NSString *dictId;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *value;

@end
