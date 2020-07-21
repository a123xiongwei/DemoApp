//
//  MJIndexProgressView.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/12.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJIndexProgressView.h"
#import "UIView+Extension.h"
#import "CommUtils.h"
#import "NSBundleUtils.h"
#import "AppConstants.h"

@implementation MJIndexProgressView

-(void)initSubViews{
    
    
    UIImageView *indexTag = [[UIImageView alloc] init];
    indexTag.width = 55;
    indexTag.height = 30;
    indexTag.image = [NSBundleUtils buildImage:[self class] imageName:@"r_tag_v"];
    [self addSubview:indexTag];
    self.tagImg = indexTag;
    
    UILabel *indexValueLa = [[UILabel alloc] init];
    indexValueLa.width = 55;
    indexValueLa.height = 20;
    indexValueLa.text = @"55.6kg";
    indexValueLa.textColor = UIColor.whiteColor;
    indexValueLa.font = [UIFont systemFontOfSize:12];
    indexValueLa.textAlignment = NSTextAlignmentCenter;
    [indexTag addSubview:indexValueLa];
    self.weightLa = indexValueLa;
    
    
    UIView *conView = [[UIView alloc] init];
//    conView.backgroundColor = UIColor.blackColor;
    conView.width = SCREEN_WIDTH - 90;;
    conView.height = 50;
    conView.center = CGPointMake(self.width/2, self.height/2 + 12);
    [self addSubview:conView];
    
    
    UIImageView *bgImg = [[UIImageView alloc] init];
    bgImg.image = [NSBundleUtils buildImage:[self class] imageName:@"r_weight_bg"];
    bgImg.width = conView.width;
    bgImg.height = 10;
    [conView addSubview:bgImg];
    

    float subWidth = conView.width/self.indexCounts;
    for (int i = 0; i < self.indexCounts; i++) {

//        UIView *subView = [[UIView alloc] init];
//        subView.width = subWidth;
//        subView.height = 10;
//        subView.x = i * subWidth;
//        if(i == 0){
//            subView.backgroundColor = UIColor.redColor;
//        }else if(i == 1){
//            subView.backgroundColor = UIColor.blueColor;
//        }else if(i == 2){
//            subView.backgroundColor = UIColor.grayColor;
//        }else if(i == 3){
//            subView.backgroundColor = UIColor.brownColor;
//        }else if(i == 4){
//            subView.backgroundColor = UIColor.cyanColor;
//        }
//        [proCon addSubview:subView];

        UILabel *desLa = [[UILabel alloc] init];
        desLa.textAlignment = NSTextAlignmentCenter;
        desLa.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        desLa.textColor = [CommUtils colorWithHexString:@"#343434"];
        desLa.width = subWidth;
        desLa.height = conView.height - 10;
        desLa.y = 10;
        desLa.x = i * subWidth;
        if(i == 0){
            desLa.text = @"瘦";
        }else if(i == 1){
            desLa.text = @"偏瘦";
        }else if(i == 2){
            desLa.text = @"标准";
        }else if(i == 3){
            desLa.text = @"偏胖";
        }else if(i == 4){
            desLa.text = @"胖";
        }
        [conView addSubview:desLa];

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
