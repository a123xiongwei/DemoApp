//
//  ScaleDetailsCell.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "RelationDetailsCell.h"
#import "AppConstants.h"
#import "CommUtils.h"

@implementation RelationDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.conView.cornerRadiusValue = 11;
    self.conView.layer.borderColor = [CommUtils colorWithHexString:@"#ECECEC"].CGColor;
    self.conView.layer.borderWidth = 1;
    
}


-(void)configCellData:(RelationRecordItem *) recordItem{
    
    self.bmiVaLa.text = recordItem.relativesBmi;
    self.bmiLa.text = [NSString stringWithFormat:@"BMI (%@)",recordItem.bmiStatusName];
    self.heightLa.text = recordItem.relativesHeight;
    self.weightLa.text = recordItem.relativesWeight;
    self.timeLa.text = recordItem.createTime;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
