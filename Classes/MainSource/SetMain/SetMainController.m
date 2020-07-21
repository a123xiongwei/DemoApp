//
//  SetMainController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/5.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "SetMainController.h"
#import "DeviceManagerCell.h"
#import "DeviceDetailsController.h"
#import "AppConstants.h"
#import "MJAppModel.h"
#import "HomeMainModel.h"
#import "SetMainModel.h"
#import <YYKit/UIImageView+YYWebImage.h>
#import "NSBundleUtils.h"

@interface SetMainController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *managerList;
@property (nonatomic, strong) IBOutlet UIImageView *avatarImg;
@property (nonatomic, strong) IBOutlet UILabel *nickNameLa;

@property (nonatomic, strong) HomeMainModel *homeModel;
@property (nonatomic, strong) SetMainModel *setModel;

@end

@implementation SetMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mjTitle = @"欢迎体验麦咭智能生活";
    self.tableView.bounces = NO;
    self.avatarImg.isRaidus = YES;
    
    self.homeModel = [[HomeMainModel alloc] init];
    self.setModel = [[SetMainModel alloc] init];
    
    self.managerList = [NSMutableArray array];
    
    [self initNativeDeviceTypeListData];
    
//  [self initFetchMyDeviceListData];
}

-(void)mjPopViewController{
    
    [self.navigationController.navigationController popViewControllerAnimated:YES];
}

/**
 * 获取本地数据列表方法
 */
-(void)initNativeDeviceTypeListData{
    
    [[self.homeModel fetchNativeDeviceTypeList] subscribeCompleted:^{
        
        self.managerList = self.homeModel.deviceList;
        [self.tableView reloadData];
        
    }];
    
}

/**
 * 获取我的设备列表
 */
-(void)initFetchMyDeviceListData{
    
    [[self.setModel fetchMyDeviceList] subscribeError:^(NSError *error) {
        
    } completed:^{
        [self initConfigData];
        [self.tableView reloadData];
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initFetchMyDeviceListData];
    [self configHeadData];
    
}

-(void)configHeadData{
    
    id objects = [MJDataCacheManager findRelationListJsonData];
    if(objects){
        
        RelationUserItem *userItem = [MJHttpDataUtils convertThisRelationUser:objects];
        UIImage *defImg = [NSBundleUtils buildImage:[self class] imageName:@"user_default"];
        [self.avatarImg setImageWithURL:[NSURL URLWithString:userItem.relativesPicUrl] placeholder:defImg];
        self.nickNameLa.text = [NSString stringWithFormat:@"%@(%@)",userItem.relativesNickName,@"成年人"];
    }

}


/**
 * 配置设备是否绑定关系
 */
-(void)initConfigData{
    
    
    for (DeviceTypeItem *typeItem in self.managerList) {
        
        for (DeviceSubItem *subItem in typeItem.goodsDtos) {
            
            subItem.isBind = @"0";
            
            for (BlueDeviceItem *deviceItem in self.setModel.myDeviceList) {
                
                if([subItem.goodsId isEqualToString:deviceItem.goodsId]){
                    subItem.isBind = @"1";
                    break;
                }
                
            }
        }
    }
    
    [self.tableView reloadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.managerList ? self.managerList.count : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeviceTypeItem *typeItem = self.managerList[indexPath.row];
    CGFloat totalHeight = [DeviceManagerCell configCellHeightValue:typeItem];
    return totalHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DeviceManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DeviceManagerCell class])];
    cell.setMainCon = self;
    DeviceTypeItem *typeItem = self.managerList[indexPath.row];
    [cell configCellData:typeItem];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self configSelectCellData:indexPath];
    
//    DeviceDetailsController *detailsCon = [SetMainSB instantiateViewControllerWithIdentifier:NSStringFromClass([DeviceDetailsController class])];
//    [self.navigationController pushViewController:detailsCon animated:YES];
    
}

/**
 * 配置选中设备列表方法
 */
-(void)configSelectCellData:(NSIndexPath *) indexPath{
    
    DeviceTypeItem *typeItem = self.managerList[indexPath.row];
    if([typeItem.isSelect isEqualToString:@"0"]){
        typeItem.isSelect = @"1";
    }else{
        typeItem.isSelect = @"0";
    }
    
    [self.tableView reloadData];
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
