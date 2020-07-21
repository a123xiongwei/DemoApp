//
//  VTMesureServer.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/11.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "VTMesureServer.h"
#import "BlueDataUtils.h"

@implementation VTMesureServer

+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static id _shared;
    dispatch_once(&onceToken, ^{
        _shared = [[[self class] alloc] init];
    });
    return _shared;
}



/**
 * 发送蓝牙检测数据
 */
-(void)sendVTBlueMesureData:(id) mesureData{
    
    if(self.mesureSignal){
        [self.mesureScriber sendNext:mesureData];
    }else{
        self.mesureSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:mesureData];
            self.mesureScriber = subscriber;
            return nil;
        }];
    }
}

/**
 * 接受蓝牙发送数据方法
 */
-(void)addReceiveVTBlueData:(void(^)(id objects,NSString *weightValue)) receiveBack{
    
    if(!self.mesureSignal){
        self.mesureSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            self.mesureScriber = subscriber;
            return nil;
        }];
    }
    
    [self.mesureSignal subscribeNext:^(id x) {
        
        NSInteger code = [BlueDataUtils findBlueResultCode:x];
        if(code == VTScaleStatusCodeNormal){
            NSString *weight = [BlueDataUtils findBlueResultWeight:x];
            receiveBack(x,weight);
        }
    }];
    
}

@end
