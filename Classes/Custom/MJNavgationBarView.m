//
//  MJNavgationBarView.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/13.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJNavgationBarView.h"
#import "UIView+Extension.h"
#import "AppConstants.h"
#import "NSBundleUtils.h"

@implementation MJNavgationBarView


-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        [self initCreateUI];
        self.backgroundColor = UIColor.clearColor;
    }
    
    return self;
}

-(void)initCreateUI{
    
    UIImageView *navImg = [[UIImageView alloc] init];
    navImg.width = SCREEN_WIDTH;
    navImg.height = kTopHeight;
    navImg.image = [NSBundleUtils buildImage:[self class] imageName:@"nav_bg"];
    
    [self addSubview:navImg];
    
    UIButton *backBtn = [[UIButton alloc] init];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    
    UIImage *backImg = [NSBundleUtils buildImage:[self class] imageName:@"l_back"];
    [backBtn setImage:backImg forState:UIControlStateNormal];
    [backBtn setImage:backImg forState:UIControlStateHighlighted];
    backBtn.width = 200;
    backBtn.x = 15;
    backBtn.height = kTopHeight - kStatusBarHeight;
    backBtn.y = kStatusBarHeight;
    [backBtn setTitle:@"指标详情" forState:UIControlStateNormal];
    self.backBtn = backBtn;
    [self addSubview:backBtn];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
