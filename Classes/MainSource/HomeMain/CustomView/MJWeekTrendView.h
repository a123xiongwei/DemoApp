//
//  MJWeekTrendView.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJWeekTrendView : UIView

@property (nonatomic, strong) IBOutlet UIView *trendView;
@property (nonatomic, strong) IBOutlet UILabel *timeLa;
@property (nonatomic, strong) IBOutlet UIImageView *faceImg;
@property (nonatomic, strong) IBOutlet UILabel *weightLa;
@property (nonatomic, strong) IBOutlet UIView *proView;

@property (nonatomic, strong) RelationWeightItem *weightItem;
@property (nonatomic) CGFloat maxValue;

@end

NS_ASSUME_NONNULL_END
