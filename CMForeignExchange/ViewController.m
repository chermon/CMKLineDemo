//
//  ViewController.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/9.
//  Copyright © 2020 梦. All rights reserved.
//

#import "ViewController.h"
#import "CMKLineChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CMKLineChartView *chartView = [[CMKLineChartView alloc] initWithFrame:CGRectMake(0, 100, GITSCREEN_WIDTH, 600)];
    [chartView setSymbols_en:@"CADCHF" symbols_cn:@"加元瑞郎"];
    [self.view addSubview: chartView];
}


@end
