//
//  MJIndexProgressView.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/12.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJIndexProgressView : UIView

@property (nonatomic, strong) UIImageView *tagImg;
@property (nonatomic, strong) UILabel *weightLa;

@property (nonatomic) int indexCounts;

-(void)initSubViews;

@end

NS_ASSUME_NONNULL_END
