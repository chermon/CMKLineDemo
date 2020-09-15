//
//  KLineChartModel.h
//  KLineChartDome
//
//  Created by TigerWit on 2017/6/2.
//  Copyright © 2017年 bao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLineChartModel : NSObject

@property (nonatomic, copy) NSString *low;  //最低价
@property (nonatomic, copy) NSString *high;  //最高价
@property (nonatomic, copy) NSString *open;  //开盘价
@property (nonatomic, copy) NSString *close;  //收盘价
@property (nonatomic, assign) CGFloat ma5;  //MA5均线
@property (nonatomic, assign) CGFloat ma10;  //MA10均线
@property (nonatomic, assign) CGFloat ma20;  //MA20均线
@property (nonatomic, assign) CGFloat volume;  //成交量
@property (nonatomic, assign) CGFloat md;  //BOLL-标准差
@property (nonatomic, assign) CGFloat mb;  //BOLL-中轨线
@property (nonatomic, assign) CGFloat up;  //BOLL-上轨线
@property (nonatomic, assign) CGFloat dn;  //BOLL-下轨线
@property (nonatomic, assign) CGFloat emas;  //ema短期
@property (nonatomic, assign) CGFloat emal;  //ema长期
@property (nonatomic, assign) CGFloat diff;  //差离值
@property (nonatomic, assign) CGFloat dea;  //差离平均值
@property (nonatomic, assign) CGFloat macd;  //MACD柱状
@property (nonatomic, assign) CGFloat rsi6;  //6相对强弱指数
@property (nonatomic, assign) CGFloat rsi12;  //12相对强弱指数
@property (nonatomic, assign) CGFloat rsi24;  //24相对强弱指数
@property (nonatomic, assign) CGFloat k;  //KDJ(K)
@property (nonatomic, assign) CGFloat d;  //KDJ(D)
@property (nonatomic, assign) CGFloat j;  //KDJ(J)
@property (nonatomic, copy) NSString *time;  //时间
@property (nonatomic, assign, getter=isNewPrice) BOOL newPrice;  //是否添加实时报价

+ (NSString *)handlePrice:(CGFloat)price digits:(NSInteger)digits isETF:(BOOL)isETF;

@end
