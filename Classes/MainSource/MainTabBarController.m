//
//  MainTabBarController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/5.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeMainController.h"
#import "AppConstants.h"
#import "SetMainController.h"
#import <IotLinkKit/IotLinkKit.h>
#import "SetMainModel.h"
#import "CommUtils.h"
#import "NSBundleUtils.h"

@interface MainTabBarController ()<LinkkitChannelListener>

@property (nonatomic, strong) SetMainModel *setModel;

@end


@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.setModel = [[SetMainModel alloc] init];
    
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColor.redColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
    HomeMainController *homeCon1 = (HomeMainController *)[NSBundleUtils buildViewController:[HomeMainController class]];
    SetMainController *homeCon2 = (SetMainController *)[NSBundleUtils buildViewController:[SetMainController class]];
    self.viewControllers = @[homeCon1,homeCon2];
    
    self.tabBar.tintColor = [CommUtils colorWithHexString:@"#00ADEF"];
     
    
    [self initIotLink];
    
    [self initFetchMyDeviceListData];

    
}

/**
 * 获取我的设备列表
 */
-(void)initFetchMyDeviceListData{
    
    [[self.setModel fetchMyDeviceList] subscribeError:^(NSError *error) {
        
    } completed:^{
        
    }];
    
}

/**
 * 初始化阿里物联
 */
-(void)initIotLink{
    
    [[LinkKitEntry sharedKit] registerChannelListener:self];
    
    LinkkitChannelConfig *linkConfig = [[LinkkitChannelConfig alloc] init];
    linkConfig.productKey = @"a1LUEsftwNq";
    linkConfig.deviceName = @"h6k2jqihABJjlWXRoDci";
    linkConfig.deviceSecret = @"QD1kAl61fPLLbOHO9dt67Yn525m2KRAz";
    linkConfig.cleanSession = YES;
    
    LinkkitSetupParams *linkParams = [[LinkkitSetupParams alloc] init];
    linkParams.appVersion = @"";
    linkParams.channelConfig = linkConfig;
    
    [[LinkKitEntry sharedKit] setup:linkParams resultBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"-----初始化成功-----");
//          [self initIotLinkSendMessage:params];
        }else{
            NSLog(@"-----初始化失败-----");
        }
    }];
    
}

/**
 * 销毁阿里物联
 */
-(void)destoryIotLink{
    
    [[LinkKitEntry sharedKit] destroy:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded){
            NSLog(@"----去初始化成功----");
            
        }else{
            NSLog(@"----去初始化失败----");
        }
        
    }];
    
}

/**
 * 发送上行消息
 */
-(void)initIotLinkSendMessage:(NSMutableDictionary *) paramsData{
    
    NSString *topic = @"/sys/a1LUEsftwNq/h6k2jqihABJjlWXRoDci/thing/event/property/post";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:paramsData forKey:@"detectData"];
    
    NSMutableDictionary *conParams = [NSMutableDictionary dictionary];
    [conParams setObject:@"547834662" forKey:@"id"];
    [conParams setObject:@"thing.event.property.post" forKey:@"method"];
    [conParams setObject:@"1.0" forKey:@"version"];
    [conParams setObject:params forKey:@"params"];
    
    NSString *content = [BlueDataUtils convertDictionyToString:conParams]; //@"{"id":"547834662","method":"thing.event.property.post","params":{"detectData":"88888888"},"version":"1.0"}";
    NSLog(@"---%@---",content);
    int iqos = 1;
    
    [[LinkKitEntry sharedKit] publish:topic data:[content dataUsingEncoding:NSUTF8StringEncoding] qos:iqos resultBlock:^(BOOL succeeded, NSError * _Nullable error) {

        if(succeeded){
            NSLog(@"----上行消息发送成功----");
        }else{
            NSLog(@"----上行消息发送失败----");
        }

    }];
    
}

#pragma LinkkitChannelListener

-(void)onConnectStateChange:(NSString *)connectId state:(LinkkitChannelConnectState)state{
    
    NSString *connectTip = nil;
    if(state == LinkkitChannelStateConnected){
        connectTip = @"已连接";
    }else if(state == LinkkitChannelStateDisconnected){
        connectTip = @"未连接";
    }else{
        connectTip = @"连接中";
    }
    NSLog(@"---%@----",connectTip);
    
}

-(void)onNotify:(NSString *)connectId topic:(NSString *)topic data:(id)data{
    NSString * downData = [NSString stringWithFormat:@"收到下推，topic : %@ \r\n", topic];
    downData = [downData stringByAppendingString:[NSString stringWithFormat:@"\r\n数据 : %@", data]];
    NSLog(@"-----收到下行数据：%@",downData);
}

- (BOOL)shouldHandle:(nonnull NSString *)connectId topic:(nonnull NSString *)topic {
    return YES;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
