//
//  DeviceManagerCell.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeviceManagerCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *conView;
@property (nonatomic, strong) IBOutlet UILabel *nameLa;
@property (nonatomic, strong) IBOutlet UILabel *desLa;
@property (nonatomic, strong) IBOutlet UIImageView *deviceImg;
@property (nonatomic, strong) IBOutlet UIImageView *arrowImg;
@property (nonatomic, strong) UIViewController *setMainCon;

-(void)configCellData:(DeviceTypeItem *) typeItem;


+(CGFloat)configCellHeightValue:(DeviceTypeItem *) typeItem;

@end

NS_ASSUME_NONNULL_END
