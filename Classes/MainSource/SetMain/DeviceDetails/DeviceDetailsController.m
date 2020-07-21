//
//  DeviceDetailsController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "DeviceDetailsController.h"
#import "UIView+Extension.h"
#import "MJDeleteView.h"
#import "AppConstants.h"
#import "DeviceDetailsModel.h"

@interface DeviceDetailsController ()

@property (nonatomic, strong) IBOutlet UIButton *deleBtn;
@property (nonatomic, strong) IBOutlet UILabel *snLa;
@property (nonatomic, strong) IBOutlet UILabel *macLa;

@property (nonatomic, strong) DeviceDetailsModel *detailsModel;
@property (nonatomic, strong) BlueDeviceItem *deviceItem;

@end

@implementation DeviceDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mjTitle = @"麦咭智能体脂秤";
    self.deleBtn.isRaidus = YES;
    
    self.detailsModel = [[DeviceDetailsModel alloc] init];
    
    [[self.deleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        MJDeleteView *deleteView = (MJDeleteView *)[MJDeleteView findMainBundleByClassName:NSStringFromClass([MJDeleteView class]) owner:self];
        
        //设备删除事件
        [[deleteView.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            
            [self initUnBindDeviceData];
            
        }];
    }];
    
    [self initFindBindDeviceInfo];
    
    
}

/**
 * 去获取绑定设备信息
 */
-(void)initFindBindDeviceInfo{
    
    [[self.detailsModel findDeviceDetailsById:self.goodsId] subscribeCompleted:^{
        
        [self configBindViewData:self.detailsModel.deviceItem];
        
    }];
    
}

/**
 * 设备解绑
 */
-(void)initUnBindDeviceData{
    
    if(self.deviceItem){
        
        [self showHUDView];
        [[self.detailsModel unBindDeviceById:self.deviceItem.userDeviceId] subscribeError:^(NSError *error) {
            [self HUDHidden];
        } completed:^{
            [self HUDHidden];
            
            //发送一个刷新我的设备列表信号
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
    }
   
}

/**
 * 设置绑定设备信息
 */
-(void)configBindViewData:(BlueDeviceItem *) deviceItem{
    
    if(deviceItem){
        self.macLa.text = deviceItem.mac;
        self.snLa.text = deviceItem.serialNumber;
    }
    self.deviceItem = deviceItem;

}

-(void)viewWillAppear:(BOOL)animated{
    
//    //设置代理
//    self.navigationController.interactivePopGestureRecognizer.delegate =(id)self;
//    //启用系统自带的滑动手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

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
