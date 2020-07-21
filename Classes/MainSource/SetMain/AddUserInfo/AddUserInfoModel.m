//
//  AddUserInfoModel.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/15.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "AddUserInfoModel.h"

@implementation AddUserInfoModel

/**
 * 添加亲友方法
 */
-(RACSignal *)addRelationUserInfo:(RelationUserItem *) userItem{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJAddUserInfoReq *req = [[MJAddUserInfoReq alloc] init];
        req.userItem = userItem;
        [req addRelationUserInfoData:^(id objects, BOOL isSuccess) {
           
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
 * 更新亲友关系
 */
-(RACSignal *)updateRelationUserInfo:(RelationUserItem *) userItem{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
       
        return nil;
    }];
}


/**
 * 获取用户关系列表
 */
-(RACSignal *)fetchRelationList{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        MJAddUserInfoReq *req = [[MJAddUserInfoReq alloc] init];
        req.name = @"relatives";
        
        [req fetchRelationListData:^(id objects, BOOL isSuccess) {
            
            if(isSuccess){
                self.relationList = [MJHttpDataUtils convertRelationListJson:objects];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        
        return nil;
    }];
}

/**
* 用户头像上传
*/
-(RACSignal *)uploadRelationAvatar:(UIImage *) image{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        MJAddUserInfoReq *req = [[MJAddUserInfoReq alloc] init];
        req.image = image;
        req.mageeToken = [MJDataCacheManager findMJSecurityToken];

        [req uploadRelationAvatarData:^(id objects, BOOL isSuccess) {
           
            if(isSuccess){
                self.avatarUrl = [MJHttpDataUtils convertRelationUserAvatarJson:objects];
                [subscriber sendCompleted];
            }else{
                [subscriber sendError:nil];
            }
            
        }];
        return nil;
    }];
}

@end
