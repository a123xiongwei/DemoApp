//
//  VTUnitConverter.h
//  vtble_scale
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 VTrump. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTUnitConverter : NSObject

+ (double)poundValueFromKgValue:(double)kgValue;

+ (double)kgValueFromPoundValue:(double)poundValue;

+ (double)stoneValueFromKgValue:(double)kgValue;

+ (double)kgValueFromStoneValue:(double)stoneValue;

+ (double)stoneValueFromPoundValue:(double)poundValue;

+ (double)poundValueFromStoneValue:(double)stoneValue;

+ (NSString *)stonePoundValueStringFromKgValue:(double)kgValue withDataScale:(NSUInteger)dataScale;

@end

NS_ASSUME_NONNULL_END
