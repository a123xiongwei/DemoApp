//
//  MJMenuView.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJMenuView.h"
#import "AppConstants.h"
#import "NSBundleUtils.h"

@implementation MJMenuView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.cornerRadiusValue = 11;
    self.width = (SCREEN_WIDTH - 45)/2;
    self.height = 83;
}

-(void)configViewData:(DeviceTypeItem *) typeItem{
    
    self.nameLa.text = typeItem.categoryName;
    self.desLa.text = typeItem.categoryNote;
    self.mebgImg.image = [NSBundleUtils buildImage:[self class] imageName:typeItem.bgIcon];
    
    if([typeItem.isSelect isEqualToString:@"1"]){
        self.openImg.hidden = NO;
    }else{
        self.openImg.hidden = YES;
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
