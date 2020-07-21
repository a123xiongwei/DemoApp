//
//  NSString+MD5.m
//  TraderBreeder
//
//  Created by 刘晓峰 on 2017/2/10.
//  Copyright © 2017年 Xiongwei. All rights reserved.
//

#import "NSString+MD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

+ (NSString *)md5Hash:(NSString *)str {
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    CC_MD5([data bytes], (CC_LONG)[data length], result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
    
}


@end
