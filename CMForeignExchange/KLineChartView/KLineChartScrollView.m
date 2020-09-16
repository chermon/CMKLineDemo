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
        [self drawLine:context startPoint:CGPointMake(rect.origin.x, self.dataSet.candleContentTop + priceLineSpace*(i+1)) stopPoint:CGPointMake(rect.origin.x + self.viewWidth, self.dataSet.candleContentTop + priceLineSpace*(i+1)) color:self.dataSet.candleBorderColor lineWidth:self.dataSet.candleBoxLineWidth];
    }
    
    //画蜡烛
    for(int i = self.minIndex; i < self.maxIndex && i < self.data.count - self.dataSet.candleNotShowLeftCount; i++){
        KLineChartModel *dataModel = [self.data objectAtIndex:i + self.dataSet.candleNotShowLeftCount];
        //转换蜡烛坐标
        CGFloat candleX = self.dataSet.candleSpace + (self.dataSet.candleWidth+self.dataSet.candleSpace)*i;
        CGFloat openScale = self.dataSet.candleContentTop + (self.maxPrice - [dataModel.open doubleValue])*self.priceCoordsScale;
        CGFloat closeScale = self.dataSet.candleContentTop + (self.maxPrice - [dataModel.close doubleValue])*self.priceCoordsScale;
        CGFloat highScale = self.dataSet.candleContentTop + (self.maxPrice - [dataModel.high doubleValue])*self.priceCoordsScale;
        CGFloat lowScale = self.dataSet.candleContentTop + (self.maxPrice - [dataModel.low doubleValue])*self.priceCoordsScale;
        //显示日期
        if(i){
            
        }
        
    }
    
    
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
@end
