//
//  SetMainModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/16.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetMainModel : MJBaseViewModel

@property (nonatomic, strong) NSMutableArray *myDeviceList;

/**
 * 查询我的设备列表
 */
-(RACSignal *)fetchMyDeviceList;


/**
 * 注册设备
 */
-(RACSignal *)registerDevice:(BlueDeviceItem *) devItem;


/**
 * 解绑设备
 */
-(RACSignal *)unBindDevice:(NSString *)deviceId;


@end

NS_ASSUME_NONNULL_END
