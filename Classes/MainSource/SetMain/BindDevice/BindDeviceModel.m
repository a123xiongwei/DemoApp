//
//  BindDeviceModel.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/16.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "BindDeviceModel.h"

@implementation BindDeviceModel

/**
 * 绑定设备
 */
-(RACSignal *)bindDevice:(BlueDeviceItem *) deviceItem{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJSetMainReq *req = [[MJSetMainReq alloc] init];
        req.mac = deviceItem.mac;
        req.productKey = deviceItem.productKey;
        req.serialNumber = deviceItem.serialNumber;
        req.bluetoothAddress = deviceItem.bluetoothAddress;
        [req registerDeviceData:^(id objects, BOOL isSuccess) {
           
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
