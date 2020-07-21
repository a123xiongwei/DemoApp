//
//  NSBundleUtils.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/20.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundleUtils : NSObject

/**
 * 构建控制器方法
 */
+(UIViewController *)buildViewController:(Class)classname;

/**
 * 构建视图的方法
 */
+(UIView *)buildView:(Class)classname owner:(UIViewController *) owner;

/**
 * 构建UIImage方法
 */
+(UIImage *)buildImage:(Class) classname imageName:(NSString *) name;


@end

NS_ASSUME_NONNULL_END
