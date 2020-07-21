//
//  TXHRrettyRuler.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//  withCount:(NSUInteger)count average:(NSUInteger)average

#import "TXHRrettyRuler.h"

#define SHEIGHT 8 // 中间指示器顶部闭合三角形高度
#define INDICATORCOLOR [UIColor redColor].CGColor // 中间指示器颜色

@implementation TXHRrettyRuler {
    TXHRulerScrollView * rulerScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        rulerScrollView = [self rulerScrollView];
        rulerScrollView.rulerHeight = frame.size.height;
        rulerScrollView.rulerWidth = frame.size.width;
        
        //添加上划线
        UIView *upLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        upLine.backgroundColor = UIColor.grayColor;
        upLine.alpha = 0.3;
        [self addSubview:upLine];
        
        UIView *downLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-11, frame.size.width, 1)];
        downLine.backgroundColor = UIColor.grayColor;
        downLine.alpha = 0.3;
        [self addSubview:downLine];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, frame.size.height)];
        leftView.backgroundColor = UIColor.whiteColor;
        leftView.alpha = 0.5;
        [self addSubview:leftView];
        
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - leftView.frame.size.width, 0, 50, frame.size.height)];
        rightView.backgroundColor = UIColor.whiteColor;
        rightView.alpha = 0.5;
        [self addSubview:rightView];
        
    }
    return self;
}

- (void)showRulerScrollViewWithCount:(NSUInteger)count
                             average:(NSNumber *)average
                        currentValue:(CGFloat)currentValue
                           smallMode:(BOOL)mode {
    NSAssert(rulerScrollView != nil, @"***** 调用此方法前，请先调用 initWithFrame:(CGRect)frame 方法初始化对象 rulerScrollView\n");
    NSAssert(currentValue < [average floatValue] * count, @"***** currentValue 不能大于直尺最大值（count * average）\n");
    rulerScrollView.rulerAverage = average;
    rulerScrollView.rulerCount = count;
    rulerScrollView.rulerValue = currentValue;
    rulerScrollView.mode = mode;
    
    [rulerScrollView drawRuler];
//    [self inser:rulerScrollView];
    [self insertSubview:rulerScrollView atIndex:0];
    [self drawRacAndLine];
}

- (TXHRulerScrollView *)rulerScrollView {
    TXHRulerScrollView * rScrollView = [TXHRulerScrollView new];
    rScrollView.delegate = self;
    rScrollView.showsHorizontalScrollIndicator = NO;
    return rScrollView;
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(TXHRulerScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
    CGFloat ruleValue = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
    if (ruleValue < 0.f) {
        return;
    } else if (ruleValue > scrollView.rulerCount * [scrollView.rulerAverage floatValue]) {
        return;
    }
    if (self.rulerDeletate) {
        if (!scrollView.mode) {
            scrollView.rulerValue = ruleValue;
        }
        scrollView.mode = NO;
        [self.rulerDeletate txhRrettyRuler:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(TXHRulerScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(TXHRulerScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}

- (void)animationRebound:(TXHRulerScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - DISTANCELEFTANDRIGHT;
    CGFloat oX = (offSetX / DISTANCEVALUE) * [scrollView.rulerAverage floatValue];
#ifdef DEBUG
    NSLog(@"ago*****************ago:oX:%f",oX);
#endif
    if ([self valueIsInteger:scrollView.rulerAverage]) {
        oX = [self notRounding:oX afterPoint:0];
    }
    else {
        oX = [self notRounding:oX afterPoint:1];
    }
#ifdef DEBUG
    NSLog(@"after*****************after:oX:%.1f",oX);
#endif
    CGFloat offX = (oX / ([scrollView.rulerAverage floatValue])) * DISTANCEVALUE + DISTANCELEFTANDRIGHT - self.frame.size.width / 2;
    [UIView animateWithDuration:.2f animations:^{
        scrollView.contentOffset = CGPointMake(offX, 0);
    }];
}

- (void)drawRacAndLine {
    // 红色指示器
//    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
//    shapeLayerLine.strokeColor = [UIColor redColor].CGColor;
//    shapeLayerLine.fillColor = INDICATORCOLOR;
//    shapeLayerLine.lineWidth = 2.0f;
//    shapeLayerLine.lineCap = kCALineCapSquare;
//
//    CGMutablePathRef pathLine = CGPathCreateMutable();
//    CGPathMoveToPoint(pathLine, NULL, self.frame.size.width / 2, 31);
//    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, 54);
//    shapeLayerLine.path = pathLine;
//    [self.layer addSublayer:shapeLayerLine];
    
//    UIImageView *upImg = [[UIImageView alloc] init];
//    upImg.image = [UIImage imageNamed:@"up_arrow"];
//    upImg.width = 40;
//    upImg.height = 50;
//    [self addSubview:upImg];
//    
//    upImg.center = self.center;
}

#pragma mark - tool method

- (CGFloat)notRounding:(CGFloat)price afterPoint:(NSInteger)position {
    NSDecimalNumberHandler*roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber*ouncesDecimal;
    NSDecimalNumber*roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc]initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [roundedOunces floatValue];
}

- (BOOL)valueIsInteger:(NSNumber *)number {
    NSString *value = [NSString stringWithFormat:@"%f",[number floatValue]];
    if (value != nil) {
        NSString *valueEnd = [[value componentsSeparatedByString:@"."] objectAtIndex:1];
        NSString *temp = nil;
        for(int i =0; i < [valueEnd length]; i++)
        {
            temp = [valueEnd substringWithRange:NSMakeRange(i, 1)];
            if (![temp isEqualToString:@"0"]) {
                return NO;
            }
        }
    }
    return YES;
}

@end
