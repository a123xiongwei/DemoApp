//
//  HomeMainCell.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/5.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "HomeMainCell.h"
#import "UIView+Extension.h"
#import "CommUtils.h"
#import <YYKit.h>

@implementation HomeMainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.conView.cornerRadiusValue = 11;
    self.avatarImg.isRaidus = YES;
    self.relationLa.isRaidus = YES;
    self.typeLa.layer.borderColor = [CommUtils colorWithHexString:@"#00ADEF"].CGColor;
    self.typeLa.layer.borderWidth = 1;
    self.typeLa.cornerRadiusValue = 4;
}

-(void)configCellData:(RelationUserItem *) userItem{
    
    self.nameLa.text = userItem.relativesNickName;
    self.relationLa.text = userItem.relativesWithName;
    
    NSString *weight = userItem.relativesWeight;
    NSString *bmi = userItem.relativesBmi;
    
    if(!weight) weight = @"-";
    if(!bmi) bmi = @"-";
    
    self.weightLa.text = [NSString stringWithFormat:@"%@ kg | BMI %@",weight,bmi];
    
    
    [self.avatarImg setImageWithURL:[NSURL URLWithString:userItem.relativesPicUrl] placeholder:[UIImage imageNamed:@"user_default"]];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
