//
//  MJWeekTrendView.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/6.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "MJWeekTrendView.h"
#import "UIView+Extension.h"
#import "CommUtils.h"
#import "AppConstants.h"
#import "NSBundleUtils.h"

@implementation MJWeekTrendView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.trendView.cornerRadiusValue = 4;
    self.width = SCREEN_WIDTH;
    self.height = 230;
    self.proView.height = self.proView.height + 50;
    
}

-(void)setWeightItem:(RelationWeightItem *)weightItem{
    
    if(weightItem){
        
        self.timeLa.text = [CommUtils convertTimeMMdd:weightItem.createTime];
        self.weightLa.text = weightItem.relativesWeight;
        
        //标准
        if([@"" isEqualToString:weightItem.bodyStatus]){
            self.trendView.backgroundColor = [CommUtils colorWithHexString:@"#00ADEF"];
            self.faceImg.image = [NSBundleUtils buildImage:[self class] imageName:@"h_face_x"];
        }else{
            self.trendView.backgroundColor = UIColor.redColor;
            self.faceImg.image = [NSBundleUtils buildImage:[self class] imageName:@"h_face_k"];
        }
        
        CGFloat weightValue = [weightItem.relativesWeight floatValue];
        CGFloat proHeight = (self.proView.height * weightValue)/self.maxValue;
        self.trendView.y = self.proView.height - proHeight;
        
    }else{
        
        self.faceImg.image = [NSBundleUtils buildImage:[self class] imageName:@"h_face_g"];
        self.timeLa.text = @"--";
        self.weightLa.text = @"--";
        self.trendView.y = self.proView.height -8;
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
