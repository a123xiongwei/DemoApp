//
//  CommDataUtils.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/8.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "BlueDataUtils.h"

@implementation BlueDataUtils

+(NSDictionary *)converStringToDictionary:(NSString *)jsonValue{
    
    NSData *data = [jsonValue dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *resultData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    return resultData;
    
}

@end
