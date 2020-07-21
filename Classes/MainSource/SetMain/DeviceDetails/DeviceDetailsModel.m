//
//  DeviceDetailsModel.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/16.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "DeviceDetailsModel.h"
#import "MJAppModel.h"

@implementation DeviceDetailsModel

/**
 * 获取绑定设备列表
 */
-(RACSignal *)findDeviceDetailsById:(NSString *)goodsId{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        id objects = [MJDataCacheManager findMyDeviceListJsonData];
        NSMutableArray *bindList = [MJHttpDataUtils convertMyDeviceListJson:objects];
        
        BlueDeviceItem *bindDevice ;
        
        for (BlueDeviceItem *deviceItem in bindList) {
            if([goodsId isEqualToString:deviceItem.goodsId]){
                bindDevice = deviceItem;
                break;
            }
        }
        
        self.deviceItem = bindDevice;
        [subscriber sendCompleted];
        
        return nil;
        
    }];
}


/**
 * 解除绑定设备
 */
-(RACSignal *)unBindDeviceById:(NSString *)deviceId{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJSetMainReq *req = [[MJSetMainReq alloc] init];
        req.userDeviceId = deviceId;
        [req unBindDeviceData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        
        return nil;
    }];
}

@end
