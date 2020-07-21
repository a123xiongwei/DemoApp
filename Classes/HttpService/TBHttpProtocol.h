//
//  RRTHttpProtocol.h
//  rrtApp
//
//  Created by yuangang on 15/3/27.
//  Copyright (c) 2015年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpCommBaseReq.h"

@interface MJHttpProtocol : NSObject


@end


@interface TBLoginMainReq : HttpCommBaseReq

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *userId;

-(void)userLoginData:(void(^)(id objects,BOOL isSuccess)) callBack;

-(void)findLoginUserData:(void(^)(id objects,BOOL isSuccess)) callBack;

@end



