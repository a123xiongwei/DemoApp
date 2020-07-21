//
//  SetMainModel.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/16.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "SetMainModel.h"

@implementation SetMainModel


/**
 * 查询我的设备列表
 */
-(RACSignal *)fetchMyDeviceList{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJSetMainReq *req = [[MJSetMainReq alloc] init];
        [req fetchMyDeviceListData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                
                self.myDeviceList = [MJHttpDataUtils convertMyDeviceListJson:objects];
                
                //本地保存我的设备列表
                [MJDataCacheManager saveMyDeviceListJsonData:objects];
                
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        return nil;
    }];
}


/**
 * 注册设备
 */
-(RACSignal *)registerDevice:(BlueDeviceItem *) devItem{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJSetMainReq *req = [[MJSetMainReq alloc] init];
        req.mac = devItem.mac;
        req.productKey = devItem.productKey;
        req.bluetoothAddress = devItem.bluetoothAddress;
        req.serialNumber = devItem.serialNumber;
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


/**
 * 解绑设备
 */
-(RACSignal *)unBindDevice:(NSString *)deviceId{
    
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
