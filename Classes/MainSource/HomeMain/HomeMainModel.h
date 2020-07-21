//
//  HomeMainModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/14.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeMainModel : MJBaseViewModel

@property (nonatomic, strong) NSMutableArray *deviceList;
@property (nonatomic, strong) NSMutableArray *relationList;
@property (nonatomic, strong) NSMutableArray *subList;
@property (nonatomic, strong) RelationUserItem *myRelationItem;
@property (nonatomic, strong) NSMutableArray *weightList;

/**
 * 查询设备列表
 */
-(RACSignal *)fetchDeviceTypeList;

/**
 * 查询用户亲友列表
 */
-(RACSignal *)fetchAccountRelationList;

/**
 * 查询亲友体重记录
 */
-(RACSignal *)fetchRelationWeightList:(NSString *)relationId;

/**
 * 获取本地缓存设备类型列表
 */
-(RACSignal *)fetchNativeDeviceTypeList;

/**
 * 获取本地亲友数据列表
 */
-(RACSignal *)fetchNativeRelationUserList;


@end

NS_ASSUME_NONNULL_END
