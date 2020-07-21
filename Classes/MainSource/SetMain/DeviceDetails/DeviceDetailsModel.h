//
//  DeviceDetailsModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/16.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceDetailsModel : MJBaseViewModel


@property (nonatomic, strong) BlueDeviceItem *deviceItem;


/**
 * 获取绑定设备列表
 */
-(RACSignal *)findDeviceDetailsById:(NSString *)goodsId;


/**
 * 解除绑定设备
 */
-(RACSignal *)unBindDeviceById:(NSString *)deviceId;


@end

NS_ASSUME_NONNULL_END
