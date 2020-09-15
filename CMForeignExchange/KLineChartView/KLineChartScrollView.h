//
//  KLineChartScrollView.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/15.
//  Copyright © 2020 梦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLineChartDataSet.h"
#import "KLineChartModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface KLineChartScrollView : UIScrollView
@property (nonatomic, strong) NSMutableArray *data;  //K线图数据
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen; //设置全屏
@property (nonatomic, assign) NSInteger digits;  //小数位数
@property (nonatomic, assign) NSInteger minIndex;  //显示最左边的位置
@property (nonatomic, assign) NSInteger maxIndex;  //显示最右边的位置
@property (nonatomic, assign, readonly) CGFloat candleHight;  //顶部图表高度

@property (nonatomic, assign) CGFloat maxPrice;  //最高报价
@property (nonatomic, assign) CGFloat minPrice;  //最低报价
@property (nonatomic, assign) CGFloat priceCoordsScale;  //报价坐标范围

@property (nonatomic, assign) CGFloat maxMACD;  //最高MACD
@property (nonatomic, assign) CGFloat minMACD;  //最低MACD
@property (nonatomic, assign) CGFloat macdCoordsScale;  //MACD坐标范围
@property (nonatomic, assign) CGFloat maxRSI;  //最高RSI
@property (nonatomic, assign) CGFloat minRSI;  //最低RSI
@property (nonatomic, assign) CGFloat rsiCoordsScale;  //RSI坐标范围
@property (nonatomic, assign) CGFloat maxKDJ;  //最高KDJ
@property (nonatomic, assign) CGFloat minKDJ;  //最低KDJ
@property (nonatomic, assign) CGFloat kdjCoordsScale;  //KDJ坐标范围

- (instancetype)initWithFrame:(CGRect)frame dataSet:(KLineChartDataSet *)dataSet;
- (void)setLineChartViewWidth;
@end

NS_ASSUME_NONNULL_END
