//
//  MJBindSelectView.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/16.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJBindSelectView.h"
#import "FDAlertView.h"
#import "AppConstants.h"
#import "CommUtils.h"
#import "NSBundleUtils.h"

@implementation MJBindSelectView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.cornerRadiusValue = 11;
    
    FDAlertView *alertView = [[FDAlertView alloc] init];
    [alertView setContentView:self andHeight:0];
    [alertView show:YES];
    
    [[self.canBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if(self.subItem){
           self.subItem.isSelect = @"0";
        }
        [alertView hide];
        
    }];
    
    [[self.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if(self.subItem){
            self.subItem.isSelect = @"0";
        }
        [alertView hide];
        
    }];
    
}

-(void)initBindListData:(NSMutableArray *) bindList callBack:(void(^)(DeviceSubItem * subItem)) callBack{
    
    for (int i = 0; i < bindList.count; i++) {
        DeviceSubItem *subItem = bindList[i];
        
        UIView *devView = [[UIView alloc] init];
        devView.width =  self.width;
        devView.height = 40;
        devView.y = i * devView.height;
//        devView.backgroundColor = UIColor.redColor;
        
        UIButton *devBtn = [[UIButton alloc] init];
        devBtn.width = devView.width;
        devBtn.height = devView.height;
        [devView addSubview:devBtn];
        
        [[devBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            if(self.subItem){
                self.subItem.isSelect = @"0";
            }
            self.subItem = subItem;
            subItem.isSelect = @"1";
            [self refreshSelectStatus:bindList callBack:callBack];
        }];
        
        UILabel *nameLa = [[UILabel alloc] init];
        nameLa.width = 200;
        nameLa.height = devView.height;
        nameLa.x = 20;
        nameLa.text = subItem.goodsName;
        
        if([@"1" isEqualToString:subItem.isSelect]){
            nameLa.textColor = [CommUtils colorWithHexString:@"#00ADEF"];
        }else{
            nameLa.textColor = [CommUtils colorWithHexString:@"999999"];
        }
        
        nameLa.font = [UIFont systemFontOfSize:14];
        [devView addSubview:nameLa];
        
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
        
        if(i != bindList.count-1){
            [devView addSubview:lineView];
        }
        
        [self.conView addSubview:devView];
        
    }
    
    self.height = 130 + bindList.count * 40;
    
    
}

-(void)refreshSelectStatus:(NSMutableArray *)bindList callBack:(void(^)(DeviceSubItem * subItem)) callBack{
    
    for (UIView *subView in self.conView.subviews) {
        [subView removeFromSuperview];
    }
    
    [self initBindListData:bindList callBack:callBack];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
