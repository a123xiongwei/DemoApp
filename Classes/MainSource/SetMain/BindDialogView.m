//
//  BindDialogView.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/15.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "BindDialogView.h"
#import "FDAlertView.h"
#import "AppConstants.h"

@implementation BindDialogView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.cornerRadiusValue = 11;
    
    FDAlertView *alertView = [[FDAlertView alloc] init];
    [alertView setContentView:self andHeight:0];
    [alertView show:YES];
    
    [[self.bindBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [alertView hide];
    }];
    
    [[self.canBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [alertView hide];
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
