//
//  MesureReportCell.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/13.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MesureReportCell.h"
#import "AppConstants.h"
#import "NSBundleUtils.h"

@implementation MesureReportCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.statusLa.isRaidus = YES;
    
}

-(void)configCellData:(IndexSubItem *) subItem{
    
    self.indexImg.image = [NSBundleUtils buildImage:[self class] imageName:subItem.icon];
    self.indexNameLa.text = subItem.name;
    self.inValueLa.text = [NSString stringWithFormat:@"%@%@",subItem.value,subItem.unit];
    self.targetLa.text = [BlueDataUtils findStandarSpaceByName:subItem.standardName withStandar:subItem.standard];
    self.statusLa.text = subItem.level;
//    self.statusLa.backgroundColor = [BlueDataUtils findIndexColorValueByName:subItem.level];
    NSString *bgName = [BlueDataUtils findIndexColorValueByName:subItem.level];
    self.statusBg.image = [NSBundleUtils buildImage:[self class] imageName:bgName];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
