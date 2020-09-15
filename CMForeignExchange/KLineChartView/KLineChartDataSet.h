//
//  KLineChartDataSet.h
//  TigerWit
//
//  Created by TigerWit on 2017/6/7.
//  Copyright © 2017年 TigerWit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KLineChartBelowViewType) {
    KLineChartBelowViewTypeVolume = 1,
    KLineChartBelowViewTypeMACD,
    KLineChartBelowViewTypeRSI,
    KLineChartBelowViewTypeKDJ
};

typedef NS_ENUM(NSInteger, KLineChartCandleViewType) {
    KLineChartCandleViewTypeNot,
    KLineChartCandleViewTypeMA,
    KLineChartCandleViewTypeBOLL
};

typedef NS_ENUM(NSInteger, KLineChartShowPriceType) {
    KLineChartShowPriceTypeLeft = 1,
    KLineChartShowPriceTypeRight
};

typedef NS_ENUM(NSInteger, KLineChartTimeType) {
    KLineChartTimeTypeHour = 1,
    KLineChartTimeTypeDay,
    KLineChartTimeTypeWeek,
    KLineChartTimeTypeMonth
};

@interface KLineChartDataSet : NSObject

//背景
@property (nonatomic, strong) UIColor *backgroundColor;  //背景颜色
@property (nonatomic, assign) CGFloat candleContentTop;  //K线图顶部间距
@property (nonatomic, assign) CGFloat candleContentBottom;  //K线图底部间距
@property (nonatomic, assign) CGFloat candleContentRight;  //K线图右边间距
@property (nonatomic, assign) CGFloat candleBelowTop;  //第二个图表顶部间距
@property (nonatomic, assign) CGFloat candleBelowBottom;  //第二个图表底部间距
@property (nonatomic, assign) CGFloat candleLeftRightMargin;  //左右间距
@property (nonatomic, strong) UIColor *candleBorderColor;  //边框颜色
@property (nonatomic, assign) CGFloat candleBorderTBWidth;  //上下边框宽度
@property (nonatomic, assign) CGFloat candleBorderLRWidth;  //左右边框宽度
@property (nonatomic, strong) UIColor *candleBoxLineColor;  //中框直线颜色
@property (nonatomic, assign) CGFloat candleBoxLineWidth;  //中框直线宽度
@property (nonatomic, assign) BOOL showCandleBoxVerticalLine;  //是否显示中框竖线
@property (nonatomic, assign) NSInteger candlePriceLineCount;  //价格横线个数(不包括最高和最低的横线)
@property (nonatomic, assign) NSInteger candlePriceCount;  //显示价格个数
@property (nonatomic, assign) BOOL showCandleHighPrice;  //是否显示最高的价格
@property (nonatomic, assign) NSInteger candleBetweenTimeNumber;  //时间之间个数
@property (nonatomic, strong) UIColor *activityColor;  //菊花颜色
//文字
@property (nonatomic, strong) UIColor *candlePriceColor;  //价格颜色
@property (nonatomic, strong) UIFont *candlePriceFont;  //价格字体
@property (nonatomic, strong) UIColor *candleTimeColor;  //时间颜色
@property (nonatomic, strong) UIFont *candleTimeFont;  //时间字体
@property (nonatomic, assign) BOOL candleInternationalTime;  //时间格式
@property (nonatomic, assign) KLineChartShowPriceType candleShowPriceType;  //报价显示左边还是右边
@property (nonatomic, copy) NSString *candleVolumeName;  //成交量单位名称
@property (nonatomic, assign) CGFloat candleTopMarkHeight;  //顶部标注高度
@property (nonatomic, assign) CGFloat candleBottomMarkHeight;  //底部标注高度
@property (nonatomic, assign) NSTextAlignment candleMarkAlignment;  //标注位置
@property (nonatomic, assign) BOOL showCandleMark;  //是否显示标注
@property (nonatomic, strong) UIColor *candleMarkColor;  //标注颜色
@property (nonatomic, strong) UIFont *candleMarkFont;  //标注字体
//蜡烛
@property (nonatomic, strong) UIColor *candleRiseColor;  //上涨颜色
@property (nonatomic, strong) UIColor *candleFallColor;  //下跌颜色
@property (nonatomic, strong) UIImage *candleRiseAcrImage;  //上涨光晕图片
@property (nonatomic, strong) UIImage *candleFallAcrImage;  //下跌光晕图片
@property (nonatomic, assign) CGFloat candleWidth;  //蜡烛宽度
@property (nonatomic, assign) CGFloat candleMinWidth;  //蜡烛最小宽度
@property (nonatomic, assign) CGFloat candleMaxWidth;  //蜡烛最大宽度
@property (nonatomic, assign) CGFloat candleLineWidth;  //蜡烛影线宽度
@property (nonatomic, assign) CGFloat candleSpace;  //蜡烛间距
@property (nonatomic, assign) NSInteger candleNotShowLeftCount;  //不显示最左边的蜡烛数量
@property (nonatomic, assign) KLineChartTimeType candleTimeType;  //选择时间
@property (nonatomic, assign) CGFloat candleViewHightScale;  //K线图高度比例
@property (nonatomic, strong) UIColor *candleMA5Color;  //MA5线颜色
@property (nonatomic, strong) UIColor *candleMA10Color;  //MA10线颜色
@property (nonatomic, strong) UIColor *candleMA20Color;  //MA20线颜色
@property (nonatomic, strong) UIColor *candleMIDColor;  //BOLL-中轨线颜色
@property (nonatomic, strong) UIColor *candleUPPERColor;  //BOLL-上轨线颜色
@property (nonatomic, strong) UIColor *candleLOWERColor;  //BOLL-下轨线颜色
@property (nonatomic, strong) UIColor *candleDIFFColor;  //DIFF线颜色
@property (nonatomic, strong) UIColor *candleDEAColor;  //DEA线颜色
@property (nonatomic, strong) UIColor *candleRSI6Color;  //RSI6线颜色
@property (nonatomic, strong) UIColor *candleRSI12Color;  //RSI12线颜色
@property (nonatomic, strong) UIColor *candleRSI24Color;  //RSI24线颜色
@property (nonatomic, strong) UIColor *candleKColor;  //KDJ(K)线颜色
@property (nonatomic, strong) UIColor *candleDColor;  //KDJ(D)线颜色
@property (nonatomic, strong) UIColor *candleJColor;  //KDJ(J)线颜色
@property (nonatomic, assign) KLineChartCandleViewType candleType;  //主图表类型
@property (nonatomic, assign) KLineChartBelowViewType belowType;  //底部图表类型

@end
