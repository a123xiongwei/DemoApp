//
//  ScaleTrendController.m
//  MJScaleSDKApp
//
//  Created by 熊伟 on 2020/7/8.
//  Copyright © 2020 熊伟. All rights reserved.
//

#import "ScaleTrendController.h"
#import "ORLineChartView.h"
#import "AppConstants.h"
#import "CommUtils.h"

@interface ScaleTrendController ()<ORLineChartViewDelegate,ORLineChartViewDataSource>

@property (nonatomic, strong) ORLineChartView *lineChartView;
@property (nonatomic, strong) NSMutableArray *dataItems;

@end

@implementation ScaleTrendController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mjTitle = @"添加身高";
    
    self.dataItems = [NSMutableArray array];
    [self.dataItems addObject:@"4"];
    [self.dataItems addObject:@"5.5"];
    [self.dataItems addObject:@"7.5"];
    [self.dataItems addObject:@"8"];
    [self.dataItems addObject:@"10"];
    [self.dataItems addObject:@"12"];
    [self.dataItems addObject:@"15"];
    [self.dataItems addObject:@"16"];
    [self.dataItems addObject:@"18"];
    
    self.lineChartView = [[ORLineChartView alloc] initWithFrame:CGRectMake(20, 150, SCREEN_WIDTH - 40, 250)];
    self.lineChartView.config.chartLineColor = [CommUtils colorWithHexString:@"#00ADEF"];
    self.lineChartView.config.showVerticalBgline = NO;
    self.lineChartView.config.showShadowLine = NO;
    self.lineChartView.config.leftWidth = 20;
    self.lineChartView.config.bottomLabelWidth = 40;
    self.lineChartView.config.chartLineWidth = 3;
    self.lineChartView.config.contentMargin = 0;
    self.lineChartView.config.bottomInset = 20;
    self.lineChartView.config.topInset = -30;
    self.lineChartView.config.animateDuration = 0.5;
    self.lineChartView.config.indicatorCircleWidth = 10;
    self.lineChartView.config.style = ORLineChartStyleControl;
    
    self.lineChartView.config.gradientColors = @[[[CommUtils colorWithHexString:@"#00ADEF"] colorWithAlphaComponent:0.5], [UIColor.whiteColor colorWithAlphaComponent:1]];
    
    
    self.lineChartView.dataSource = self;
    self.lineChartView.delegate = self;
    
    
    [self.view addSubview:self.lineChartView];
}

#pragma mark - ORLineChartViewDataSource
- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView {
    return self.dataItems.count;
}

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index {
    
    return [self.dataItems[index] floatValue];
}

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView {
    return 5;
}

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index {
//   NSAttributedString *string = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"value: 30"]];
    
    NSString *stringValue = [NSString stringWithFormat:@"value:%@",self.dataItems[index]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:stringValue];
    [string addAttribute:NSForegroundColorAttributeName
                      value:[UIColor whiteColor]
                      range:NSMakeRange(0, stringValue.length)];
    return string;
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [CommUtils colorWithHexString:@"#343434"]};
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [CommUtils colorWithHexString:@"#00ADEF"]};
}

- (NSString *)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index{
    
    
    return @"4-1";
}

//////custom left values
//- (CGFloat)chartView:(ORLineChartView *)chartView valueOfVerticalSeparateAtIndex:(NSInteger)index {
//    NSArray *number1 = @[@(0),@(0.2),@(0.4),@(0.6),@(0.8),@(0.10)];
//    return 50;
//}

#pragma mark - ORLineChartViewDelegate
- (void)chartView:(ORLineChartView *)chartView didSelectValueAtIndex:(NSInteger)index {
    NSLog(@"did select index %ld and value  is", index);
}

- (void)chartView:(ORLineChartView *)chartView indicatorDidChangeValueAtIndex:(NSInteger)index {
    NSLog(@"indicater did change index %ld and value  is", index);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
