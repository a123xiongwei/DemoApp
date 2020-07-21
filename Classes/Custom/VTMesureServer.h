//
//  VTMesureServer.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/11.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface VTMesureServer : NSObject

@property (nonatomic, strong) RACSignal *mesureSignal;
@property (nonatomic, strong) id<RACSubscriber> mesureScriber;

+(instancetype)sharedManager;

/**
 * 发送蓝牙检测数据
 */
-(void)sendVTBlueMesureData:(id) mesureData;

/**
 * 接受蓝牙发送数据方法
 */
-(void)addReceiveVTBlueData:(void(^)(id objects,NSString *weightValue)) receiveBack;


@end

NS_ASSUME_NONNULL_END
