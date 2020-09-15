//
//  KLineChartDataSet.m
//  TigerWit
//
//  Created by TigerWit on 2017/6/7.
//  Copyright © 2017年 TigerWit. All rights reserved.
//

#import "KLineChartDataSet.h"

@implementation KLineChartDataSet

- (instancetype)init {
    self = [super init];
    if (self) {
        //默认参数
        _backgroundColor = [UIColor whiteColor];
        _candleContentTop = 5;
        _candleContentBottom = 34;
        _candleContentRight = 0;
        _candleBelowTop = 5;
        _candleBelowBottom = 5;
        _candleLeftRightMargin = 16;
        _candleBorderColor = [RGB(151, 151, 151) colorWithAlphaComponent:0.1];
        _candleBorderTBWidth = 0.5;
        _candleBorderLRWidth = self.candleBorderTBWidth;
        _candleBoxLineColor = self.candleBorderColor;
        _candleBoxLineWidth = self.candleBorderTBWidth;
        _showCandleBoxVerticalLine = YES;
        _candlePriceLineCount = 4;
        _candlePriceCount = 6;
        _showCandleHighPrice = YES;
        _candleBetweenTimeNumber = 10;
        _candlePriceColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _candlePriceFont = [UIFont systemFontOfSize:9];
        _candleTimeColor = self.candlePriceColor;
        _candleTimeFont = self.candlePriceFont;
        _candleInternationalTime = YES;
        _candleShowPriceType = KLineChartShowPriceTypeLeft;
        _candleTopMarkHeight = 24;
        _candleBottomMarkHeight = 24;
        _candleMarkAlignment = NSTextAlignmentRight;
        _showCandleMark = YES;
        _candleMarkColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
        _candleMarkFont = [UIFont systemFontOfSize:9];
        _candleVolumeName = @"手";
        _candleRiseColor = [UIColor greenColor];
        _candleFallColor = [UIColor redColor];
        _candleRiseAcrImage = nil;
        _candleFallAcrImage = nil;
        _candleWidth = 5;
        _candleMinWidth = 2.5;
        _candleMaxWidth = 30;
        _candleLineWidth = 1;
        _candleSpace = 2;
        _candleNotShowLeftCount = 0;
        _candleViewHightScale = 0.78;
        _candleMA5Color = RGB(74, 144, 226);
        _candleMA10Color = RGB(245, 166, 35);
        _candleMA20Color = RGB(208, 2, 27);
        _candleMIDColor = self.candleMA5Color;
        _candleUPPERColor = self.candleMA10Color;
        _candleLOWERColor = self.candleMA20Color;
        _candleDIFFColor = self.candleMA5Color;
        _candleDEAColor = self.candleMA10Color;
        _candleRSI6Color = self.candleMA5Color;
        _candleRSI12Color = self.candleMA10Color;
        _candleRSI24Color = self.candleMA20Color;
        _candleKColor = self.candleMA5Color;
        _candleDColor = self.candleMA10Color;
        _candleJColor = self.candleMA20Color;
        _candleType = KLineChartCandleViewTypeMA;
        _belowType = KLineChartBelowViewTypeMACD;
    }
    return self;
}

@end
