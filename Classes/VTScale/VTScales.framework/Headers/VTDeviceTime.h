//
//  VTDeviceTime.h
//  vtble_scale
//
//  Created by mac on 2019/10/11.
//  Copyright © 2019 VTrump. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTDeviceTime : NSObject

@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int second;

@property (nonatomic, strong, readonly) NSDate *date;

- (BOOL)isEqualToTime:(VTDeviceTime *)time;

- (BOOL)isEqualToDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
