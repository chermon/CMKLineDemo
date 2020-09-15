//
//  ViewController.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/9.
//  Copyright © 2020 梦. All rights reserved.
//

#import "ViewController.h"
#import "KLineChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KLineChartView *chartView = [[KLineChartView alloc] initWithFrame:CGRectMake(0, 100, 300, 600)];
    [self.view addSubview: chartView];
}


@end
