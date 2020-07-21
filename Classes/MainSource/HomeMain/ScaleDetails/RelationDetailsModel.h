//
//  ScaleDetailsModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/18.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBaseViewModel.h"
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RelationDetailsModel : MJBaseViewModel

@property (nonatomic, strong) RelationDetailsItem *detailsItem;
@property (nonatomic, strong) NSMutableArray *recordList;

/**
 * 查询亲友详情
 */
-(RACSignal *)findRelationDetailsById:(NSString *)relativesId;

@end

NS_ASSUME_NONNULL_END
