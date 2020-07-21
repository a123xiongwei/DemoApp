//
//  MesureReportModel.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/18.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MesureReportModel.h"

@implementation MesureReportModel

-(RACSignal *)findMesureReportById:(NSString *) detalId{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJMesureReportReq *req = [[MJMesureReportReq alloc] init];
        req.detailId = detalId;
        
        [req findMesureReportData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                self.detailsItem = [MJHttpDataUtils convertReportDetailsJson:objects];
                self.indexList = [MJHttpDataUtils convertIndexSubItemByReportDetails:self.detailsItem];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
       
        return nil;
    }];
}

-(RACSignal *)fetchIndexStandarList{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        MJMesureReportReq *req = [[MJMesureReportReq alloc] init];
        req.name = @"standard";
        [req fetchIndexStandarData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                
                self.standarList = [MJHttpDataUtils convertIndexStandarListJson:objects];
                
                //保存理想值区间
                [MJDataCacheManager saveStandarListJsonData:objects];
                
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        
        return nil;
    }];
}


@end
