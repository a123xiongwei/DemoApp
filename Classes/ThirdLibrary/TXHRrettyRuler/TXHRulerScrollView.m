//
//  TXHRulerScrollView.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//

#import "TXHRulerScrollView.h"

@implementation TXHRulerScrollView

- (void)setRulerValue:(CGFloat)rulerValue {
    _rulerValue = rulerValue;
}

- (void)drawRuler {
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    CGMutablePathRef pathRef3 = CGPathCreateMutable();
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 1.f;
    shapeLayer2.lineCap = kCALineCapButt;
    
    CAShapeLayer *shapeLayer3 = [CAShapeLayer layer];
    shapeLayer3.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer3.fillColor = [UIColor clearColor].CGColor;
    shapeLayer3.lineWidth = 2.f;
    shapeLayer3.lineCap = kCALineCapButt;
    
    for (int i = 0; i <= self.rulerCount; i++) {
        UILabel *rule = [[UILabel alloc] init];
        rule.textColor = [UIColor grayColor];
        rule.text = [NSString stringWithFormat:@"%.0f",i * [self.rulerAverage floatValue]];
        CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font }];
        if (i % 10 == 0) {
            CGPathMoveToPoint(pathRef3, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM);
            CGPathAddLineToPoint(pathRef3, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height-25);
            rule.frame = CGRectMake(DISTANCELEFTANDRIGHT + DISTANCEVALUE * i - textSize.width / 2, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 20, 0, 0);
            [rule sizeToFit];
            [self addSubview:rule];
        }
        else if (i % 5 == 0) {
//            CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM + 10);
//            CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 10);
            CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM);
            CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 30);
        }
        else
        {
//            CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM + 20);
//            CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 20);
            
            CGPathMoveToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i , DISTANCETOPANDBOTTOM);
            CGPathAddLineToPoint(pathRef1, NULL, DISTANCELEFTANDRIGHT + DISTANCEVALUE * i, self.rulerHeight - DISTANCETOPANDBOTTOM - textSize.height - 40);
        }
    }
    
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    shapeLayer3.path = pathRef3;
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    [self.layer addSublayer:shapeLayer3];
    
    self.frame = CGRectMake(0, 5, self.rulerWidth, self.rulerHeight-20);
    
    // 开启最小模式
    if (_mode) {
        UIEdgeInsets edge = UIEdgeInsetsMake(0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT, 0, self.rulerWidth / 2.f - DISTANCELEFTANDRIGHT);
        self.contentInset = edge;
        self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth + (self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT), 0);
    }
    else
    {
        self.contentOffset = CGPointMake(DISTANCEVALUE * (self.rulerValue / [self.rulerAverage floatValue]) - self.rulerWidth / 2.f + DISTANCELEFTANDRIGHT, 0);
    }
    
    self.contentSize = CGSizeMake(self.rulerCount * DISTANCEVALUE + DISTANCELEFTANDRIGHT * 2.f, 0);
}

@end
