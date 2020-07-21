//
//  BindDeviceModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/16.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BindDeviceModel : MJBaseViewModel

/**
 * 绑定设备
 */
-(RACSignal *)bindDevice:(BlueDeviceItem *) deviceItem;

@end

NS_ASSUME_NONNULL_END
