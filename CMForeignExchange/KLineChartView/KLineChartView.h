//
//  KLineChartView.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/15.
//  Copyright © 2020 梦. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLineChartView : UIView
@property (nonatomic, assign, getter=isFullScreen) BOOL fullScreen;
@property (nonatomic, strong) NSArray *MAArr;  //MA参数
@property (nonatomic, strong) NSArray *BOLLArr;  //BOLL参数
@property (nonatomic, strong) NSArray *MACDArr;  //MACD参数
@property (nonatomic, strong) NSArray *RSIArr;  //RSI参数
@property (nonatomic, strong) NSArray *KDJArr;  //KDJ参数
@end

NS_ASSUME_NONNULL_END
