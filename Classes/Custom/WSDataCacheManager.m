//
//  JJDataCacheManager.m
//  JingJing
//
//  Created by 熊伟 on 16/3/18.
//  Copyright © 2017年 熊伟. All rights reserved.
//
#import "MJDataCacheManager.h"

@implementation MJDataCacheManager

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static MJDataCacheManager *shared;
    dispatch_once(&onceToken, ^{
        shared = [[MJDataCacheManager alloc] init];
        
    });
    return shared;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.commDB = [LevelDB databaseInLibraryWithName:@"AppCommon"];
    }
    return self;
}

-(BOOL)isLogin{
    BOOL isLogin = NO;
    
    return isLogin;
}


//-(void)saveUserLocationCityName:(NSString *)cityName{
//    [self.commDB setObject:cityName forKey:@"LOCATION_CITYNAME"];
//}
//
//
//-(NSString *)findUserLocationCityName{
//    NSString *cityName = [self.commDB objectForKey:@"LOCATION_CITYNAME"];
//    if(![cityName isKindOfClass:[NSString class]]){
//        cityName = @"";
//    }
//    return cityName;
//}



@end
