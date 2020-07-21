//
//  ScaleDetailsCell.h
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RelationDetailsCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIView *conView;
@property (nonatomic, strong) IBOutlet UILabel *heightLa;
@property (nonatomic, strong) IBOutlet UILabel *weightLa;
@property (nonatomic, strong) IBOutlet UILabel *bmiLa;
@property (nonatomic, strong) IBOutlet UILabel *bmiVaLa;
@property (nonatomic, strong) IBOutlet UILabel *timeLa;


-(void)configCellData:(RelationRecordItem *) reocrdItem;

@end

NS_ASSUME_NONNULL_END
