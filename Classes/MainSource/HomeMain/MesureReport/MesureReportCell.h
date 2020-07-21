//
//  MesureReportCell.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/13.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MesureReportCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *indexImg;
@property (nonatomic, strong) IBOutlet UILabel *indexNameLa;
@property (nonatomic, strong) IBOutlet UILabel *targetLa;
@property (nonatomic, strong) IBOutlet UILabel *inValueLa;
@property (nonatomic, strong) IBOutlet UILabel *statusLa;
@property (nonatomic, strong) IBOutlet UIImageView *statusBg;

-(void)configCellData:(IndexSubItem *) subItem;

@end

NS_ASSUME_NONNULL_END
