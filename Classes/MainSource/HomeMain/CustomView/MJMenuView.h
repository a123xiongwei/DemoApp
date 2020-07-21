//
//  MJMenuView.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MJMenuView : UIView

@property (nonatomic,strong) IBOutlet UIButton *subBtn;
@property (nonatomic,strong) IBOutlet UIImageView *mebgImg;
@property (nonatomic,strong) IBOutlet UILabel *nameLa;
@property (nonatomic,strong) IBOutlet UILabel *desLa;
@property (nonatomic,strong) DeviceTypeItem *typeItem;
@property (nonatomic,strong) IBOutlet UIImageView *openImg;

-(void)configViewData:(DeviceTypeItem *) typeItem;

@end

NS_ASSUME_NONNULL_END
