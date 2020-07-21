//
//  UITableView+ShowView.m
//  TraderGem
//
//  Created by 熊伟 on 2019/4/24.
//  Copyright © 2019年 熊伟. All rights reserved.
//

#import "UITableView+ShowView.h"
#import "UIView+Extension.h"
#import "AppConstants.h"
#import "CommUtils.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation UITableView (ShowView)

-(void)showNoData:(NSString *) message withYValue:(CGFloat) yValue{
    
    UIView *noView = [[UIView alloc] init];
    noView.width = SCREEN_WIDTH;
    noView.height = 200 + yValue * 2;
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"no_icon"];
    iconImg.width = iconImg.image.size.width;
    iconImg.height = iconImg.image.size.height;
    iconImg.centerX = noView.centerX;
    iconImg.centerY = noView.centerY - 30;
    iconImg.contentMode = UIViewContentModeCenter;
    [noView addSubview:iconImg];
    
    UILabel *desLa = [[UILabel alloc] init];
    desLa.textAlignment = NSTextAlignmentCenter;
    desLa.textColor = UIColor.grayColor;
    desLa.font = [UIFont systemFontOfSize:14];
    desLa.alpha = 0.8;
    desLa.width = SCREEN_WIDTH;
    desLa.height = 40;
    desLa.text = message;
    desLa.numberOfLines = 0;
    desLa.centerX = iconImg.centerX;
    desLa.centerY = iconImg.centerY + iconImg.image.size.height/2 + 20;
    [noView addSubview:desLa];

    self.tableFooterView = noView;
    
}

-(void)showNoDataRefresh:(NSString *)message withYValue:(CGFloat) yValue callBack:(void(^)(void)) callBack{
    
    UIView *noView = [[UIView alloc] init];
    noView.width = SCREEN_WIDTH;
    noView.height = 200 + yValue * 2;
    
    UIImageView *iconImg = [[UIImageView alloc] init];
    iconImg.image = [UIImage imageNamed:@"no_icon"];
    iconImg.width = iconImg.image.size.width;
    iconImg.height = iconImg.image.size.height;
    iconImg.centerX = noView.centerX;
    iconImg.centerY = noView.centerY - 30;
    iconImg.contentMode = UIViewContentModeCenter;
    [noView addSubview:iconImg];
    
    UILabel *desLa = [[UILabel alloc] init];
    desLa.textAlignment = NSTextAlignmentCenter;
    desLa.textColor = [CommUtils colorWithHexString:@"#6A6B6E"];
    desLa.font = [UIFont systemFontOfSize:14];
    desLa.width = SCREEN_WIDTH;
    desLa.height = 20;
    desLa.text = message;
    desLa.centerX = iconImg.centerX;
    desLa.centerY = iconImg.centerY + iconImg.image.size.height/2 + 20;
    [noView addSubview:desLa];
    
    UIButton *tradeBtn = [[UIButton alloc] init];
    tradeBtn.width = 125;
    tradeBtn.height = 36;
    [tradeBtn setTitle:@"历史交易记录" forState:UIControlStateNormal];
    tradeBtn.centerX = iconImg.centerX;
    tradeBtn.centerY = desLa.centerY + 60;
    tradeBtn.layer.borderColor = [CommUtils colorWithHexString:@"#6A6B6E"].CGColor;
    tradeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [tradeBtn setTitleColor:[CommUtils colorWithHexString:@"#e6e6e6"] forState:UIControlStateNormal];
    tradeBtn.layer.borderWidth = 1;
    tradeBtn.layer.cornerRadius = tradeBtn.height/2;
    [noView addSubview:tradeBtn];
    [[tradeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        callBack();
    }];
    
    self.tableFooterView = noView;
    
}

-(void)showMoreTradeView:(void(^)(void)) callBack{
    
    UIView *mView = [[UIView alloc] init];
    mView.width = SCREEN_WIDTH;
    mView.height = 60;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.width = SCREEN_WIDTH - 40;
    lineView.x = 20;
    lineView.y = mView.height/2;
    lineView.height = 1;
    lineView.backgroundColor = [CommUtils colorWithHexString:@"#6A6B6E"];
    [mView addSubview:lineView];
    
    UIButton *tradeBtn = [[UIButton alloc] init];
    tradeBtn.width = 125;
    tradeBtn.height = 36;
    [tradeBtn setTitle:@"历史交易记录" forState:UIControlStateNormal];
    tradeBtn.centerX = lineView.centerX;
    tradeBtn.y = (60 - 36)/2;
    tradeBtn.layer.borderColor = [CommUtils colorWithHexString:@"#6A6B6E"].CGColor;
    tradeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [tradeBtn setTitleColor:[CommUtils colorWithHexString:@"#e6e6e6"] forState:UIControlStateNormal];
//    tradeBtn.backgroundColor = VIEW_COLOR;

    [mView addSubview:tradeBtn];
    [[tradeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        callBack();
    }];
    
    self.tableFooterView = mView;
}

-(void)dissShowNoData{
    self.tableFooterView = [[UIView alloc] init];
}

@end
