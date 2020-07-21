//
//  UIImage+Scale.h
//  TraderBreeder
//
//  Created by 刘晓峰 on 2017/2/21.
//  Copyright © 2017年 Xiongwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

- (UIImage *)scaledCopyOfSizeMin:(CGSize)newSize;


+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize withSourceImage:(UIImage *)sourceImage;
/**
 *  生成二维码图片
 *
 *  @param QRString  二维码内容
 *  @param sizeWidth 图片size（正方形）
 *  @param color     填充色
 *
 *  @return  二维码图片
 */
+(UIImage *)createQRimageString:(NSString *)QRString sizeWidth:(CGFloat)sizeWidth fillColor:(UIColor *)color;

+ (UIImage *)imageWithBorderW:(CGFloat)borderW borderColor:(UIColor *)color image:(UIImage *)image;

+ (UIImage *)image:(UIImage *)image byScalingToSize:(CGSize)targetSize;


///压缩图片
+ (UIImage *)imageCompressToImage:(UIImage *)image;
@end
