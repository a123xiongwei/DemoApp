//
//  AddUserInfoModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/15.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddUserInfoModel : MJBaseViewModel

@property (nonatomic, strong) NSMutableArray *relationList;
@property (nonatomic, strong) NSString *avatarUrl;

/**
 * 添加亲友方法
 */
-(RACSignal *)addRelationUserInfo:(RelationUserItem *) userItem;

/**
 * 更新亲友关系
 */
-(RACSignal *)updateRelationUserInfo:(RelationUserItem *) userItem;

/**
 * 获取用户关系列表
 */
-(RACSignal *)fetchRelationList;

/**
 * 用户头像上传
 */
-(RACSignal *)uploadRelationAvatar:(UIImage *) image;


@end

NS_ASSUME_NONNULL_END
