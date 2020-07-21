//
//  BindDeviceController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/7.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "BindDeviceController.h"
#import "AppConstants.h"
#import "BindDeviceModel.h"
#import "VTMesureServer.h"
#import <IotLinkKit/IotLinkKit.h>
#import "SetMainModel.h"

@interface BindDeviceController ()

@property (nonatomic, strong) IBOutlet UILabel *desLa;
@property (nonatomic, strong) IBOutlet UIButton *bindBtn;

@property (nonatomic, strong) BindDeviceModel *bindModel;
@property (nonatomic, strong) BlueDeviceItem *deviceItem;
@property (nonatomic, strong) SetMainModel *setModel;

@end

@implementation BindDeviceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.desLa.isRaidus = YES;
    self.bindBtn.isRaidus = YES;
    
    self.bindModel = [[BindDeviceModel alloc] init];
    self.setModel = [[SetMainModel alloc] init];
    
    //绑定事件方法
    [[self.bindBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    //体脂称的监听方法
    [[VTMesureServer sharedManager] addReceiveVTBlueData:^(id  _Nonnull objects, NSString * _Nonnull weightValue) {
       
        NSLog(@"绑定测量结果：%@",objects);
        
        NSString *deviceMac = [BlueDataUtils findBlueDeviceSN:objects];
        NSString *sn = [BlueDataUtils findBlueDeviceMac:objects];
        
        self.deviceItem.mac = deviceMac;
        self.deviceItem.bluetoothAddress = deviceMac;
        self.deviceItem.serialNumber = sn;
        
        [self initBindDeviceData];
        
    }];
    
    self.deviceItem = [[BlueDeviceItem alloc] init];
    self.deviceItem.productKey = self.productKey;
    
}

/**
 * 绑定蓝牙设备
 */
-(void)initBindDeviceData{
    
    [self showHUDView];
    [[self.bindModel bindDevice:self.deviceItem] subscribeError:^(NSError *error) {
        [self HUDHidden];
    } completed:^{
        
        [self initFetchMyDeviceListData];
       
    }];
    
}

/**
 * 获取我的设备列表
 */
-(void)initFetchMyDeviceListData{
    
    [[self.setModel fetchMyDeviceList] subscribeError:^(NSError *error) {
        [self HUDHidden];
    } completed:^{
        
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self HUDHidden];
            [self showMessage:@"绑定成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
    }];
    
}

/**
 * 物联网发送上行消息
 */
-(void)initIotLinkSendMessage:(NSDictionary *) params{
    
    NSString *topic = @"/sys/a1LUEsftwNq/h6k2jqihABJjlWXRoDci/thing/event/property/post";
    
    NSMutableDictionary *conParams = [NSMutableDictionary dictionary];
    [conParams setObject:@"547834662" forKey:@"id"];
    [conParams setObject:@"thing.event.property.post" forKey:@"method"];
    [conParams setObject:@"1.0" forKey:@"version"];
    [conParams setObject:params forKey:@"params"];
    
    NSString *content = [BlueDataUtils convertDictionyToString:conParams];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
