//
//  KLineChartView.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/15.
//  Copyright © 2020 梦. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLineChartDataSet.h"

NS_ASSUME_NONNULL_BEGIN
@protocol KLineChartViewDelegate <NSObject>

@optional
- (void)KLineChartViewForReload;  //重新加载
- (void)KLineChartViewForMoreData;  //更多加载
@end

@interface KLineChartView : UIView
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
@property (nonatomic, strong) NSArray *MAArr;  //MA参数
@property (nonatomic, strong) NSArray *BOLLArr;  //BOLL参数
@property (nonatomic, strong) NSArray *MACDArr;  //MACD参数
@property (nonatomic, strong) NSArray *RSIArr;  //RSI参数
@property (nonatomic, strong) NSArray *KDJArr;  //KDJ参数
@property (nonatomic, assign) id<KLineChartViewDelegate> delegate;
@property (nonatomic, assign) BOOL moreData;//还可以加载更多
@property (nonatomic, copy) NSString *timeType;  //时间类型
@property (nonatomic, assign) NSInteger digits;  //小数位数
- (instancetype)initWithFrame:(CGRect)frame dataSet:(KLineChartDataSet *)dataSet;
- (void)addDataFromArray:(NSMutableArray *)array;
@end

NS_ASSUME_NONNULL_END
