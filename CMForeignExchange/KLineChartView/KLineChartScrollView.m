//
//  KLineChartScrollView.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/15.
//  Copyright © 2020 梦. All rights reserved.
//

#import "KLineChartScrollView.h"

@interface KLineChartScrollView ()

@property (nonatomic, strong) KLineChartDataSet *dataSet;

@end

@implementation KLineChartScrollView

-(instancetype)initWithFrame:(CGRect)frame dataSet:(KLineChartDataSet *)dataSet{
    if (!self) {
        self = [super initWithFrame:frame];
        _dataSet = dataSet;
        _fullScreen = false;
        _candleHight = self.viewHeight;
        
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
    }
    return self;
}

#pragma mark - 重绘
- (void)drawWiew{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (!self.data || self.data.count - self.dataSet.candleNotShowLeftCount <= 0) {
        return;
    }
    
    //设置最高价格和最低价格
    [self setMaxAndMinPrice];
    //将价格转换为坐标
    self.priceCoordsScale = (self.candleHight - self.dataSet.candleContentTop - self.dataSet.candleContentBottom)/(self.maxPrice - self.minPrice);
    
    // - 绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置背景颜色
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, self.dataSet.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    //边框
    //左边框
    [self drawLine:context startPoint:CGPointMake(rect.origin.x + self.dataSet.candleBorderLRWidth/2, self.dataSet.candleContentTop) stopPoint:CGPointMake(rect.origin.x + self.dataSet.candleBorderLRWidth/2, self.candleHight - self.dataSet.candleContentBottom) color:self.dataSet.candleBorderColor lineWidth:self.dataSet.candleBorderLRWidth];
    //右边框
    [self drawLine:context startPoint:CGPointMake(rect.origin.x + self.viewWidth - self.dataSet.candleBorderLRWidth/2, self.dataSet.candleContentTop) stopPoint:CGPointMake(rect.origin.x + self.viewWidth - self.dataSet.candleBorderLRWidth/2, self.candleHight - self.dataSet.candleContentBottom) color:self.dataSet.candleBorderColor lineWidth:self.dataSet.candleBorderLRWidth];
    //上边框
    [self drawLine:context startPoint:CGPointMake(rect.origin.x + self.dataSet.candleBorderLRWidth/2, self.dataSet.candleContentTop) stopPoint:CGPointMake(rect.origin.x + self.viewWidth - self.dataSet.candleBorderLRWidth/2, self.dataSet.candleContentTop) color:self.dataSet.candleBorderColor lineWidth:self.dataSet.candleBorderTBWidth];
    //下边框
    [self drawLine:context startPoint:CGPointMake(rect.origin.x + self.dataSet.candleBorderLRWidth/2, self.candleHight - self.dataSet.candleContentBottom) stopPoint:CGPointMake(rect.origin.x + self.viewWidth - self.dataSet.candleBorderLRWidth/2, self.candleHight - self.dataSet.candleContentBottom) color:self.dataSet.candleBorderColor lineWidth:self.dataSet.candleBorderTBWidth];
    
    //价格横线
    CGFloat priceLineSpace = (self.candleHight - self.dataSet.candleContentTop - self.dataSet.candleContentBottom)/(self.dataSet.candlePriceLineCount+1);
    for (int i = 0; i < self.dataSet.candlePriceLineCount; i++) {
        [self drawLine:context startPoint:CGPointMake(rect.origin.x, self.dataSet.candleContentTop + priceLineSpace*(i+1)) stopPoint:CGPointMake(rect.origin.x + self.viewWidth, self.dataSet.candleContentTop + priceLineSpace*(i+1)) color:self.dataSet.candleBoxLineColor lineWidth:self.dataSet.candleBoxLineWidth];
    }
    
    //最高、最低价格位置
    CGFloat maxHighScale = CGFLOAT_MAX;
    CGFloat maxHighX = 0;
    CGFloat minLowScale = CGFLOAT_MIN;
    CGFloat minLowX = 0;
    
    //画蜡烛
    for(NSInteger i = self.minIndex; i < self.maxIndex && i < self.data.count - self.dataSet.candleNotShowLeftCount; i++){
        KLineChartModel *dataModel = [self.data objectAtIndex: self.dataSet.candleNotShowLeftCount + i];
        //转换蜡烛坐标
        CGFloat candleX = self.dataSet.candleSpace + (self.dataSet.candleWidth+self.dataSet.candleSpace)*i;
        CGFloat openScale = self.dataSet.candleContentTop + (self.maxPrice - [dataModel.open doubleValue])*self.priceCoordsScale;
        CGFloat closeScale = self.dataSet.candleContentTop + (self.maxPrice - [dataModel.close doubleValue])*self.priceCoordsScale;
        CGFloat highScale = self.dataSet.candleContentTop + (self.maxPrice - [dataModel.high doubleValue])*self.priceCoordsScale;
        CGFloat lowScale = self.dataSet.candleContentTop + (self.maxPrice - [dataModel.low doubleValue])*self.priceCoordsScale;
        //记录最高点和最低点的Y值，和蜡烛的位置坐标
        if (highScale < maxHighScale) {
            maxHighScale = highScale;
            maxHighX = candleX;
        }
        if (lowScale > minLowScale) {
            minLowScale = lowScale;
            minLowX = candleX;
        }
        //1.显示日期
        if(i%self.dataSet.candlePriceCount == 0){
            //价格线
            if (self.dataSet.showCandleBoxVerticalLine) {
                [self drawLine:context startPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, self.dataSet.candleContentTop) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, self.candleHight - self.dataSet.candleContentBottom) color:self.dataSet.candleBoxLineColor lineWidth:self.dataSet.candleBoxLineWidth];
            }

            //价格Lable
            NSString *priceTime = [self transformStandardWithTimestamp: dataModel.time];
            NSMutableAttributedString *dateStrAtt = [[NSMutableAttributedString alloc] initWithString: priceTime attributes:@{NSFontAttributeName: self.dataSet.candleTimeFont, NSForegroundColorAttributeName: self.dataSet.candleTimeColor}];
            CGSize dateStrAttSize = [dateStrAtt size];
            [self drawLabel:context attributesText:dateStrAtt rect:CGRectMake(candleX+self.dataSet.candleWidth/2 - dateStrAttSize.width/2, self.candleHight - self.dataSet.candleContentBottom + (self.dataSet.candleContentBottom - dateStrAttSize.height)/2, dateStrAttSize.width, dateStrAttSize.height)];
        }
        
        //2.显示蜡烛
        //上涨（开仓价格小于闭市价格）
        if (openScale > closeScale) {
            [self drawFill:context rect:CGRectMake(candleX, closeScale, self.dataSet.candleWidth, openScale - closeScale) color:self.dataSet.candleRiseColor];
            [self drawLine:context startPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, highScale) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, lowScale) color:self.dataSet.candleRiseColor lineWidth:self.dataSet.candleLineWidth];
        }
        //下跌（开仓价格大于闭市价格）
        else if(openScale < closeScale){
            [self drawFill:context rect:CGRectMake(candleX, openScale, self.dataSet.candleWidth, closeScale - openScale) color:self.dataSet.candleFallColor];
            [self drawLine:context startPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, highScale) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, lowScale) color:self.dataSet.candleFallColor lineWidth:self.dataSet.candleLineWidth];
        }
        else{//开仓价格等于闭市价格
            UIColor *candleColor = self.dataSet.candleRiseColor;
            if (i > 0) {
                KLineChartModel *lastDataModel = [self.data objectAtIndex: self.dataSet.candleNotShowLeftCount + i - 1];
                if(lastDataModel.close > dataModel.close){
                    candleColor = self.dataSet.candleFallColor;
                }
            }
            [self drawFill:context rect:CGRectMake(candleX, openScale, self.dataSet.candleWidth, 1) color:candleColor];
            [self drawLine:context startPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, highScale) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, lowScale) color:candleColor lineWidth:self.dataSet.candleLineWidth];
        }
        
        //3.指标线
        if(self.dataSet.candleType == KLineChartCandleViewTypeMA && i > 0){
            KLineChartModel *lastDataModel = [self.data objectAtIndex: self.dataSet.candleNotShowLeftCount + i - 1];
            CGFloat lastMaX = candleX - self.dataSet.candleSpace - self.dataSet.candleWidth/2;
            if (dataModel.ma5 > 0) {
                CGFloat MA5Y = self.dataSet.candleContentTop + (self.maxPrice - dataModel.ma5) * self.priceCoordsScale;
                CGFloat lastMA5Y = self.dataSet.candleContentTop + (self.maxPrice - lastDataModel.ma5) * self.priceCoordsScale;
                [self drawLine:context startPoint:CGPointMake(lastMaX, lastMA5Y) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, MA5Y) color:self.dataSet.candleMA5Color lineWidth:self.dataSet.candleBoxLineWidth];
            }
            if (dataModel.ma10 > 0) {
                CGFloat MA10Y = self.dataSet.candleContentTop + (self.maxPrice - dataModel.ma10) * self.priceCoordsScale;
                CGFloat lastMA10Y = self.dataSet.candleContentTop + (self.maxPrice - lastDataModel.ma10) * self.priceCoordsScale;
                [self drawLine:context startPoint:CGPointMake(lastMaX, lastMA10Y) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, MA10Y) color:self.dataSet.candleMA10Color lineWidth:self.dataSet.candleBoxLineWidth];
            }
            if (dataModel.ma20 > 0) {
                CGFloat MA20Y = self.dataSet.candleContentTop + (self.maxPrice - dataModel.ma20) * self.priceCoordsScale;
                CGFloat lastMA20Y = self.dataSet.candleContentTop + (self.maxPrice - lastDataModel.ma20) * self.priceCoordsScale;
                [self drawLine:context startPoint:CGPointMake(lastMaX, lastMA20Y) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, MA20Y) color:self.dataSet.candleMA20Color lineWidth:self.dataSet.candleBoxLineWidth];
            }
        }
        else if (self.dataSet.candleType == KLineChartCandleViewTypeBOLL && i > 0){
            KLineChartModel *lastDataModel = [self.data objectAtIndex: self.dataSet.candleNotShowLeftCount + i - 1];
            CGFloat lastBOLLX = candleX - self.dataSet.candleSpace - self.dataSet.candleWidth/2;
            if (dataModel.mb > 0) {
                //中轨线
                CGFloat MBY = self.dataSet.candleContentTop + (self.maxPrice - dataModel.mb) * self.priceCoordsScale;
                CGFloat lastMBY = self.dataSet.candleContentTop + (self.maxPrice - lastDataModel.mb) * self.priceCoordsScale;
                [self drawLine:context startPoint:CGPointMake(lastBOLLX, lastMBY) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, MBY) color:self.dataSet.candleMIDColor lineWidth:self.dataSet.candleBoxLineWidth];
                //上轨线
                CGFloat UPY = self.dataSet.candleContentTop + (self.maxPrice - dataModel.up) * self.priceCoordsScale;
                CGFloat lastUPY = self.dataSet.candleContentTop + (self.maxPrice - lastDataModel.up) * self.priceCoordsScale;
                [self drawLine:context startPoint:CGPointMake(lastBOLLX, lastUPY) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, UPY) color:self.dataSet.candleUPPERColor lineWidth:self.dataSet.candleBoxLineWidth];
                //下轨线
                CGFloat DNY = self.dataSet.candleContentTop + (self.maxPrice - dataModel.dn) * self.priceCoordsScale;
                CGFloat lastDNY = self.dataSet.candleContentTop + (self.maxPrice - lastDataModel.dn) * self.priceCoordsScale;
                [self drawLine:context startPoint:CGPointMake(lastBOLLX, lastDNY) stopPoint:CGPointMake(candleX+self.dataSet.candleWidth/2, DNY) color:self.dataSet.candleLOWERColor lineWidth:self.dataSet.candleBoxLineWidth];
            }
        }
    }
    
    //显示价格
    for (int i = 0; i < self.dataSet.candlePriceCount; i++) {
        NSMutableAttributedString *priceAttStr = [[NSMutableAttributedString alloc] initWithString:[KLineChartModel handlePrice:[self getPriceWithRow:i] digits:self.digits isETF:self.isETF] attributes:@{NSFontAttributeName:self.dataSet.candlePriceColor, NSForegroundColorAttributeName:self.dataSet.candlePriceFont}];
        CGSize priceAttStrSize = [priceAttStr size];
        if (self.dataSet.candleShowPriceType == KLineChartShowPriceTypeRight) {
            [self drawLabel:context attributesText:priceAttStr rect:CGRectMake(self.viewWidth - self.dataSet.candleContentRight, self.dataSet.candleContentTop + priceLineSpace*i - priceAttStrSize.height/2 - self.dataSet.candleBoxLineWidth, priceAttStrSize.width, priceAttStrSize.height)];
        }
    }
    
    //显示最低点和最高点的价格
    // - 当前k线图最高点的价格
    NSString *maxPriceStr = [KLineChartModel handlePrice:self.maxPrice - (maxHighScale - self.dataSet.candleContentTop)/self.priceCoordsScale digits:self.digits isETF:self.isETF];
    NSString *showMaxPriceStr;
    BOOL showPriceToLeft;
    if (maxHighX > rect.origin.x + self.viewWidth/2) {
        showMaxPriceStr = [NSString stringWithFormat:@"%@->", maxPriceStr];
        showPriceToLeft = true;
    }else{
        showMaxPriceStr = [NSString stringWithFormat:@"<-%@", maxPriceStr];
        showPriceToLeft = false;
    }
    NSMutableAttributedString *maxPriceAttStr = [[NSMutableAttributedString alloc] initWithString:showMaxPriceStr attributes:@{NSFontAttributeName:self.dataSet.candlePriceFont, NSForegroundColorAttributeName:self.dataSet.candleMarkColor}];
    CGSize maxPriceAttSize = [maxPriceAttStr size];
    [self drawLabel:context attributesText:maxPriceAttStr rect:CGRectMake((showPriceToLeft ? maxHighX - maxPriceAttSize.width : maxHighX + self.dataSet.candleWidth), maxHighScale - maxPriceAttSize.height/2, maxPriceAttSize.width, maxPriceAttSize.height)];
    
    // - 当前k线图最低点的价格
    NSString *minPriceStr = [KLineChartModel handlePrice:self.maxPrice - (minLowScale - self.dataSet.candleContentTop)/self.priceCoordsScale digits:self.digits isETF:self.isETF];
    NSString *showMinPriceStr;
    BOOL showMinPriceToLeft;
    if (minLowX > rect.origin.x + self.viewWidth/2) {
        showMinPriceStr = [NSString stringWithFormat:@"%@->", minPriceStr];
        showMinPriceToLeft = true;
    }else{
        showMinPriceStr = [NSString stringWithFormat:@"<-%@", minPriceStr];
        showMinPriceToLeft = false;
    }
    NSMutableAttributedString *minPriceAttStr = [[NSMutableAttributedString alloc] initWithString:showMinPriceStr attributes:@{NSFontAttributeName:self.dataSet.candlePriceFont, NSForegroundColorAttributeName:self.dataSet.candleMarkColor}];
    CGSize minPriceAttSize = [minPriceAttStr size];
    [self drawLabel:context attributesText:minPriceAttStr rect:CGRectMake((showMinPriceToLeft ? minLowX - minPriceAttSize.width : minLowX + self.dataSet.candleWidth), minLowScale - minPriceAttSize.height/2, minPriceAttSize.width, minPriceAttSize.height)];
}

#pragma mark - 设置K线图宽度
- (void)setLineChartViewWidth {
    CGFloat count = self.data.count - self.dataSet.candleNotShowLeftCount;
    CGFloat totalW = count*self.dataSet.candleWidth + self.dataSet.candleSpace * (count + 1);
    if (totalW <= self.viewWidth - self.dataSet.candleContentRight) {
        totalW = self.viewWidth - self.dataSet.candleContentRight + 1;
    }
    self.contentSize = CGSizeMake(totalW, 0);
}

#pragma mark 获取价格

- (CGFloat)getPriceWithRow:(NSInteger)row {
    CGFloat price = self.maxPrice - (self.maxPrice - self.minPrice)/(self.dataSet.candlePriceCount - 1)*row;
    
    if (isinf(price) || isnan(price)) {
        price = 0;
    }
    return price;
}
#pragma mark - 获取报价范围
-(void)setMaxAndMinPrice{
    if (self.data && self.data.count - self.dataSet.candleNotShowLeftCount > 0) {
        _maxPrice = CGFLOAT_MIN;
        _minPrice = CGFLOAT_MAX;
        for(NSInteger i = self.minIndex; i < self.maxIndex && i < self.data.count - self.dataSet.candleNotShowLeftCount; i++){
             KLineChartModel *dataModel = [self.data objectAtIndex:i + self.dataSet.candleNotShowLeftCount];
            _maxPrice = _maxPrice > [dataModel.high doubleValue] ? _maxPrice: [dataModel.high doubleValue];
            _minPrice = _minPrice < [dataModel.low doubleValue] ? _minPrice: [dataModel.low doubleValue];
            if (self.dataSet.candleType == KLineChartCandleViewTypeMA) {
                if (dataModel.ma5 > 0) {
                    _maxPrice = _maxPrice > dataModel.ma5 ? _maxPrice : dataModel.ma5;
                    _minPrice = _minPrice < dataModel.ma5 ? _minPrice : dataModel.ma5;
                }
                if (dataModel.ma10 > 0) {
                    _maxPrice = _maxPrice > dataModel.ma10 ? _maxPrice : dataModel.ma10;
                    _minPrice = _minPrice < dataModel.ma10 ? _minPrice : dataModel.ma10;
                }
                if (dataModel.ma20 > 0) {
                    _maxPrice = _maxPrice > dataModel.ma20 ? _maxPrice : dataModel.ma20;
                    _minPrice = _minPrice < dataModel.ma20 ? _minPrice : dataModel.ma20;
                }
            }
            else if (self.dataSet.candleType == KLineChartCandleViewTypeBOLL){
                if (dataModel.md > 0) {
                    _maxPrice = _maxPrice > dataModel.up ? _maxPrice : dataModel.up;
                    _minPrice = _minPrice < dataModel.up ? _minPrice : dataModel.up;
                    _maxPrice = _maxPrice > dataModel.dn ? _maxPrice : dataModel.dn;
                    _minPrice = _minPrice < dataModel.dn ? _minPrice : dataModel.dn;
                }
            }
        }
        //预留K线图上下间距
        CGFloat scale = (self.maxPrice - self.minPrice)*0.1;
        self.maxPrice = self.maxPrice + scale;
        self.minPrice = self.minPrice - scale;
    }
}

#pragma mark - 绘制

#pragma mark 方块
- (void)drawFill:(CGContextRef)context rect:(CGRect)rect color:(UIColor *)color{
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
}

#pragma mark 直线
- (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint stopPoint:(CGPoint)stopPoint color:(UIColor *)color lineWidth:(CGFloat)lineWidth{
    
    //设置线宽
    CGContextSetLineWidth(context, lineWidth);
    //设置路径颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    //设置路径
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, stopPoint.x, stopPoint.y);
    CGContextStrokePath(context);
}

#pragma mark 虚线
- (void)drawDashLine:(CGContextRef)context startPoint:(CGPoint)startPoint stopPoint:(CGPoint)stopPoint color:(UIColor *)color lineWidth:(CGFloat)lineWidth{
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    
    CGContextBeginPath(context);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {3,1};
    //参数2：表示开头的点如果绘制，eg:参数2如果等于2，则先绘制1个点（即3-2），然后跳过1个点，再绘制3个点，然后跳过1个点...反复绘制。
    //参数4：表示数组的长度。
    CGContextSetLineDash(context, 0, arr, 2);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, stopPoint.x, stopPoint.y);
    CGContextStrokePath(context);
}

#pragma mark 文字
- (void)drawLabel:(CGContextRef)context attributesText:(NSAttributedString *)attributesText rect:(CGRect)rect {
    [attributesText drawInRect:rect];
}

#pragma mark - 时间戳

- (NSString *)transformStandardWithTimestamp:(NSString *)timestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (self.dataSet.candleTimeType == KLineChartTimeTypeHour) {
        [formatter setDateFormat:@"HH:mm"];
    }
    else {
        [formatter setDateFormat:@"MM-dd"];
    }
    
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timestamp integerValue]];
    return [formatter stringFromDate:date];
}

@end
