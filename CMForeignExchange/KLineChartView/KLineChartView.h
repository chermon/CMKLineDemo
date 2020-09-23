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
@property (nonatomic, strong, readonly) NSArray *defaultMAArr;  //MA默认参数
@property (nonatomic, strong, readonly) NSArray *defaultBOLLArr;  //BOLL默认参数
@property (nonatomic, strong) NSArray *MAArr;  //MA参数
@property (nonatomic, strong) NSArray *BOLLArr;  //BOLL参数
@property (nonatomic, strong) NSArray *MACDArr;  //MACD参数
@property (nonatomic, strong) NSArray *RSIArr;  //RSI参数
@property (nonatomic, strong) NSArray *KDJArr;  //KDJ参数
@property (nonatomic, assign) id<KLineChartViewDelegate> delegate;
@property (nonatomic, assign) BOOL haveMoreData;//还可以加载更多
@property (nonatomic, copy) NSString *timeType;  //时间类型
@property (nonatomic, assign) NSInteger digits;  //小数位数
- (instancetype)initWithFrame:(CGRect)frame dataSet:(KLineChartDataSet *)dataSet;
-(void)reload:(BOOL)moreData;
- (void)addDataFromArray:(NSMutableArray *)array;
- (void)removeArray;

- (void)setDefaultMAWithCycle1:(NSInteger)cycle1 cycle2:(NSInteger)cycle2 cycle3:(NSInteger)cycle3;
- (void)setDefaultBOLLWithCycle:(NSInteger)cycle offset:(NSInteger)offset;
@end

NS_ASSUME_NONNULL_END
