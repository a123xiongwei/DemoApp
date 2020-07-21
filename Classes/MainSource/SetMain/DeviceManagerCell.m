//
//  DeviceManagerCell.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "DeviceManagerCell.h"
#import "UIView+Extension.h"
#import "CommUtils.h"
#import "AppConstants.h"
#import "BindDialogView.h"
#import "BindDeviceController.h"
#import "DeviceDetailsController.h"
#import "NSBundleUtils.h"

@implementation DeviceManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.conView.cornerRadiusValue = 11;
    
}

-(void)configCellData:(DeviceTypeItem *) typeItem{
    
    self.nameLa.text = typeItem.categoryName;
    self.desLa.text = typeItem.categoryNote;
    self.deviceImg.image = [NSBundleUtils buildImage:[self class] imageName:typeItem.icon];
    
    if([typeItem.isSelect isEqualToString:@"1"]){
        
        self.arrowImg.image = [NSBundleUtils buildImage:[self class] imageName:@"s_arrow_u"];
        
        for (int i = 0; i < typeItem.goodsDtos.count; i++) {
            DeviceSubItem *subItem = typeItem.goodsDtos[i];
            
            UIView *devView = [[UIView alloc] init];
            devView.width =  SCREEN_WIDTH - 24;
            devView.height = 40;
            devView.y = i * devView.height;
            
            UIButton *devBtn = [[UIButton alloc] init];
            devBtn.width = devView.width;
            devBtn.height = devView.height;
            [devView addSubview:devBtn];
            
            BOOL isBind = [subItem.isBind isEqualToString:@"1"] ? YES:NO;
            
            [[devBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
               
                if(isBind){
                    
                    BindDialogView *bindView = (BindDialogView *)[NSBundleUtils buildView:[BindDialogView class] owner:self.setMainCon];
                    [[bindView.bindBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
                        
                        DeviceDetailsController *bindCon = (DeviceDetailsController *)[NSBundleUtils buildViewController:[DeviceDetailsController class]];
                        bindCon.goodsId = subItem.goodsId;
                        [self.setMainCon.navigationController pushViewController:bindCon animated:YES];
                        
                    }];
                    
                }else{
                    
                    BindDeviceController *bindCon = (BindDeviceController *)[NSBundleUtils buildViewController:[BindDeviceController class]];
                    [self.setMainCon.navigationController pushViewController:bindCon animated:YES];
                }
                
            }];
            
            
            UILabel *nameLa = [[UILabel alloc] init];
            nameLa.width = 200;
            nameLa.height = devView.height;
            nameLa.x = 20;
            nameLa.text = subItem.goodsName;
            if(isBind){
                nameLa.textColor = [CommUtils colorWithHexString:@"#00ADEF"];
            }else{
                nameLa.textColor = [CommUtils colorWithHexString:@"999999"];
            }
            
            nameLa.font = [UIFont systemFontOfSize:14];
            [devView addSubview:nameLa];
            
            
            UILabel *bindLa = [[UILabel alloc] init];
            bindLa.textAlignment = NSTextAlignmentRight;
            bindLa.width = 100;
            bindLa.height = devView.height;
            bindLa.x = devView.width - bindLa.width - 30;
            bindLa.text = @"未绑定";
            bindLa.textColor = [CommUtils colorWithHexString:@"999999"];
            bindLa.font = [UIFont systemFontOfSize:14];
            if(!isBind){
                [devView addSubview:bindLa];
            }
            
            UIImageView *arrowImg = [[UIImageView alloc] init];
            arrowImg.contentMode = UIViewContentModeCenter;
            arrowImg.width = 20;
            arrowImg.height = 30;
            arrowImg.y = 5;
            arrowImg.x = devView.width - arrowImg.width - 10;
            arrowImg.image = [NSBundleUtils buildImage:[self class] imageName:@"s_arrow_r"];
            [devView addSubview:arrowImg];
            
            UIView *lineView = [[UIView alloc] init];
            lineView.width = devView.width-30;
            lineView.height = 1;
            lineView.y = devView.height - 1;
            lineView.x = 15;
            lineView.alpha = 0.1;
            lineView.backgroundColor = UIColor.grayColor;
            
            if(i != typeItem.goodsDtos.count-1){
                [devView addSubview:lineView];
            }
            
            [self.conView addSubview:devView];
            
        }
    }else{
        self.arrowImg.image = [NSBundleUtils buildImage:[self class] imageName:@"s_arrow_d"];
    }
    
}

-(void)prepareForReuse{
    [super prepareForReuse];
    
    for (UIView *subView in self.conView.subviews) {
        if(![subView isKindOfClass:[UIImageView class]]){
            [subView removeFromSuperview];
        } 
    }
}

+(CGFloat)configCellHeightValue:(DeviceTypeItem *) typeItem{
    
    CGFloat totalValue = 92;
    
    NSArray *deviceItems = typeItem.goodsDtos;
    
    if([typeItem.isSelect isEqualToString:@"1"]){
        totalValue = totalValue + deviceItems.count *40;
    }

    return totalValue;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
