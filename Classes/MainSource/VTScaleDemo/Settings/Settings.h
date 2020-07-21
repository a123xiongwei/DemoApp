//
//  Settings.h
//  VTScaleDemo
//
//  Created by mac on 2019/4/8.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Settings : NSObject

@property (nonatomic, assign) NSUInteger gender; // 0 男，1 女
@property (nonatomic, assign) NSUInteger age;
@property (nonatomic, assign) NSUInteger height;
    
+ (instancetype)sharedSettings;

@end

NS_ASSUME_NONNULL_END
