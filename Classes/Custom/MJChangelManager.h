//
//
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>


/**
 *  通知信号管理类
 */
@interface MJChangelManager : NSObject

@property (nonatomic, strong) RACChannel *channel;

+(instancetype)sharedManager;

/**
 *  添加监听通知信号的方法
 *
 *  @param callBack 回调语句
 */
-(void)addObserverFunction:(void(^)(NSInteger observerValue))callBack;

/**
 *  发送一个登录成功的信号方法
 */
-(void)sendLoginSuccessSignel;


@end
