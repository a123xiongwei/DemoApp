//
//  HomeMainModel.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/14.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "HomeMainModel.h"
#import "MJHttpProtocol.h"

@implementation HomeMainModel

/**
 * 查询设备列表
 */
-(RACSignal *)fetchDeviceTypeList{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJHomeMainReq *req = [[MJHomeMainReq alloc] init];
        [req fetchDeviceTypeListData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                
                self.deviceList = [MJHttpDataUtils convertDeviceTypeListJson:objects];
                
                self.subList = [MJHttpDataUtils convertAllSubDeviceList:self.deviceList];
                
                //缓存本地设备列表
                [MJDataCacheManager saveDeviceListJsonData:objects];
                
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        return nil;
    }];
}

/**
 * 查询用户亲友列表
 */
-(RACSignal *)fetchAccountRelationList{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJHomeMainReq *req = [[MJHomeMainReq alloc] init];
        [req fetchAccountRelationListData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                
                self.relationList = [MJHttpDataUtils convertRelationUserListJson:objects];
                
                self.myRelationItem = [MJHttpDataUtils convertThisRelationUser:objects];
                
                if(self.myRelationItem){
                    //保存完善信息的状态
                    [MJDataCacheManager saveRelationThisStatus:@"1"];
                }else{
                    [MJDataCacheManager saveRelationThisStatus:@"0"];
                }
                
                //保存亲友列表数据
                [MJDataCacheManager saveRelationListJsonData:objects];
                
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        return nil;
    }];
}

/**
 * 查询亲友体重记录
 */
-(RACSignal *)fetchRelationWeightList:(NSString *)relationId{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJHomeMainReq *req = [[MJHomeMainReq alloc] init];
        req.relativesId = relationId;
        [req fetchRelationWeightListData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                self.weightList = [MJHttpDataUtils convertRelationWeightListJson:objects];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        
        return nil;
    }];
}

/**
 * 获取本地缓存设备类型列表
 */
-(RACSignal *)fetchNativeDeviceTypeList{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        id objects = [MJDataCacheManager findDeviceListData];
        if([objects isKindOfClass:[NSDictionary class]]){
            self.deviceList = [MJHttpDataUtils convertDeviceTypeListJson:objects];
            [subscriber sendCompleted];
        }
        
        return nil;
    }];
}

/**
 * 获取本地亲友数据列表
 */
-(RACSignal *)fetchNativeRelationUserList{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        id objects = [MJDataCacheManager findRelationListJsonData];
        if([objects isKindOfClass:[NSDictionary class]]){
            self.relationList = [MJHttpDataUtils convertRelationUserListJson:objects];
            [subscriber sendCompleted];
        }
        
        return nil;
    }];
}

@end
