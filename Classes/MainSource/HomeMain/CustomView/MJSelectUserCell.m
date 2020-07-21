//
//  MJSelectUserCell.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/7.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJSelectUserCell.h"
#import "UIView+Extension.h"

@implementation MJSelectUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.avatarImg.isRaidus = YES;
    
}

-(void)configCellData:(RelationUserItem *)userItem{
    
    self.nameLa.text = [NSString stringWithFormat:@"%@（%@）",userItem.relativesNickName,userItem.relativesWithName];
    self.desLa.text = @"上次测量：--";
    
    if([userItem.isSelect isEqualToString:@"1"]){
        self.selImg.image = [UIImage imageNamed:@"h_select_y"];
    }else{
        self.selImg.image = [UIImage imageNamed:@"h_select_n"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
