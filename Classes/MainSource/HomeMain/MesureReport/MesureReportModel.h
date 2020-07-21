//
//  MesureReportModel.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/18.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MesureReportModel : MJBaseViewModel

@property (nonatomic, strong) ReportDetailsItem *detailsItem;
@property (nonatomic, strong) NSMutableArray *indexList;
@property (nonatomic, strong) NSMutableArray *standarList;

-(RACSignal *)findMesureReportById:(NSString *) detalId;

-(RACSignal *)fetchIndexStandarList;

@end

NS_ASSUME_NONNULL_END
