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

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置背景颜色
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, self.dataSet.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
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
        _maxMACD = CGFLOAT_MIN;
        _minMACD = CGFLOAT_MAX;
        _maxRSI = CGFLOAT_MIN;
        _minRSI = CGFLOAT_MAX;
        _maxKDJ = CGFLOAT_MIN;
        _minKDJ = CGFLOAT_MAX;
        
        for(NSInteger i = self.minIndex; i < self.maxIndex && i < self.data.count - self.dataSet.candleNotShowLeftCount; i++){
             KLineChartModel *dataModel = [self.data objectAtIndex:i + self.dataSet.candleNotShowLeftCount];
            
        }
        
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
