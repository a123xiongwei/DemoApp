//
//  UIView+Extension.h
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;
/**
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;


@property (assign, nonatomic) NSString *backgroundType;


@property (assign, nonatomic) int cornerRadiusValue;

@property (nonatomic) BOOL isRaidus;

+(UIView *)findMainBundleByClassName:(NSString *) className owner:(id) owner;


@end
