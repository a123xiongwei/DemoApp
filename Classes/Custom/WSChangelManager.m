//
//  JJChangelManager.m
//  JingJing
//
//

#import "MJChangelManager.h"

/**
 *  通知信号管理类
 */
@implementation MJChangelManager

+(instancetype)sharedManager{
    static dispatch_once_t onceToken;
    static id _shared;
    dispatch_once(&onceToken, ^{
        _shared = [[[self class] alloc] init];
    });
    return _shared;
}

-(instancetype)init{
    self = [super init];
    if(self){
        self.channel = [[RACChannel alloc] init];
    }else{
        if(!self.channel){
            self.channel = [[RACChannel alloc] init];
        }
    }
    return self;
}

/**
 *  添加监听通知信号的方法
 *
 *  @param callBack 回调语句
 */
-(void)addObserverFunction:(void(^)(NSInteger observerValue))callBack{
    
    [[self.channel.followingTerminal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        callBack([x integerValue]);
    }];
    
}

/**
 *  发送一个登录成功的信号方法
 */
-(void)sendLoginSuccessSignel{
    [self.channel.leadingTerminal sendNext:@(1)];
}


@end
