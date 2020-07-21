//
//  ScaleDetailsModel.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/18.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "RelationDetailsModel.h"

@implementation RelationDetailsModel

/**
 * 查询亲友详情
 */
-(RACSignal *)findRelationDetailsById:(NSString *)relativesId{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJRelationDetailsReq *req = [[MJRelationDetailsReq alloc] init];
        req.relativesId = relativesId;
        [req findRelationDeailsByIdData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){

                self.detailsItem = [MJHttpDataUtils convertRelationDetailsJson:objects];
                self.recordList = [MJHttpDataUtils convertRelationRecordListJson:objects];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        return nil;
    }];
}

@end
