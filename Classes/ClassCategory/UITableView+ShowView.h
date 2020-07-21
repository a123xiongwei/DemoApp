//
//  UITableView+ShowView.h
//  TraderGem
//
//  Created by 熊伟 on 2019/4/24.
//  Copyright © 2019年 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (ShowView)

-(void)showNoData:(NSString *) message withYValue:(CGFloat) yValue;

-(void)dissShowNoData;

-(void)showMoreTradeView:(void(^)(void)) callBack;

-(void)showNoDataRefresh:(NSString *)message withYValue:(CGFloat) yValue callBack:(void(^)(void)) callBack;

@end

NS_ASSUME_NONNULL_END
