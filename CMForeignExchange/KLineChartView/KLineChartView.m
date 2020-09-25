//
//  KLineChartView.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/15.
//  Copyright © 2020 梦. All rights reserved.
//

#import "KLineChartView.h"
#import "KLineChartScrollView.h"
#import "KLineChartModel.h"

@interface KLineChartView()<UIScrollViewDelegate>
@property (nonatomic, weak) KLineChartScrollView *lineChartScrollView;
@property (nonatomic, strong) KLineChartDataSet *dataSet;
@property (nonatomic, strong) NSMutableArray *data;  //K线图数据
@property (nonatomic, assign) CGFloat lastTotalWidth;  //加载更多前宽度
@end

@implementation KLineChartView

- (instancetype)initWithFrame:(CGRect)frame dataSet:(KLineChartDataSet *)dataSet
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化
        _dataSet = dataSet;
        _data = [NSMutableArray array];
        _fullScreen = false;
        
        
        KLineChartScrollView *lineChartScrollView = [[KLineChartScrollView alloc] initWithFrame:self.bounds dataSet:dataSet];
        lineChartScrollView.backgroundColor = dataSet.backgroundColor;
        lineChartScrollView.delegate = self;
        [self addSubview:lineChartScrollView];
        self.lineChartScrollView = lineChartScrollView;
    }
    return self;
}

//更新UI
-(void)reload:(BOOL)moreData{
    [self.lineChartScrollView setLineChartViewWidth];
    if (moreData) {//加载更多
        if (self.lineChartScrollView.contentOffset.x == 0) {//左边加载
            [self.lineChartScrollView setContentOffset:CGPointMake(self.lineChartScrollView.contentSize.width - self.lastTotalWidth, 0) animated:false];
        }
        else{//右边加载
            [self.lineChartScrollView setContentOffset:CGPointMake(self.lineChartScrollView.contentSize.width - self.viewWidth + self.dataSet.candleContentRight, 0) animated:false];
        }
    }
    else{// 初始位置
        [self.lineChartScrollView setContentOffset:CGPointMake(self.lineChartScrollView.contentSize.width - self.viewWidth + self.dataSet.candleContentRight, 0) animated:false];
    }
    _lastTotalWidth = self.lineChartScrollView.contentSize.width;
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    if (offsetX < 0) {
        offsetX = 0;
    }
    self.lineChartScrollView.minIndex = offsetX/(self.dataSet.candleWidth + self.dataSet.candleSpace);
    self.lineChartScrollView.maxIndex = ceil((offsetX+self.viewWidth)/(self.dataSet.candleWidth + self.dataSet.candleSpace));
    
    //重绘
    [self.lineChartScrollView drawWiew];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //加载更多
    if (scrollView.contentOffset.x <= -50 && self.haveMoreData) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(KLineChartViewForMoreData)]) {
            [self.delegate KLineChartViewForMoreData];
        }
    }
    //重新加载
    else if (scrollView.contentOffset.x >= self.lineChartScrollView.contentSize.width - self.viewWidth + self.dataSet.candleContentRight + 50){
        if(self.delegate && [self.delegate respondsToSelector:@selector(KLineChartViewForReload)]){
            [self.delegate KLineChartViewForReload];
        }
        
    }
}

- (void)setDigits:(NSInteger)digits{
    _digits = digits;
    self.lineChartScrollView.digits = digits;
}

//增加数据
- (void)addDataFromArray:(NSMutableArray *)array {
    for (NSInteger i = 0; i < array.count; i++) {
        [_data insertObject:array[i] atIndex:0];
    }
    
    //计算
    if (self.data.count > 0) {
        for (NSInteger i = 0; i < self.data.count; i++) {
            KLineChartModel *model = [self.data objectAtIndex:i];
            model.ma5 = [self getMA:[self.MAArr[0] integerValue] dataIndex:i];
            model.ma10 = [self getMA:[self.MAArr[1] integerValue] dataIndex:i];
            model.ma20 = [self getMA:[self.MAArr[2] integerValue] dataIndex:i];
            model.md = [self getMD:[self.BOLLArr[0] integerValue] dataIndex:i];
            model.mb = [self getMA:[self.BOLLArr[0] integerValue] dataIndex:i - 1];
            model.up = model.mb + model.md * [self.BOLLArr[1] integerValue];
            model.dn = model.mb - model.md * [self.BOLLArr[1] integerValue];
            model.emas = [self getEMAShort:[self.MACDArr[0] integerValue] dataIndex:i];
            model.emal = [self getEMALong:[self.MACDArr[1] integerValue] dataIndex:i];
            model.diff = [self getDIFF:i];
            model.dea = [self getDEA:[self.MACDArr[2] integerValue] dataIndex:i];
            model.macd = [self getMACDWithDataIndex:i];
            model.rsi6 = [self getRSI:[self.RSIArr[0] integerValue] dataIndex:i];
            model.rsi12 = [self getRSI:[self.RSIArr[1] integerValue] dataIndex:i];
            model.rsi24 = [self getRSI:[self.RSIArr[2] integerValue] dataIndex:i];
            model.k = [self getKDJForKWithCycle:[self.KDJArr[0] integerValue] KCycle:[self.KDJArr[1] integerValue] dataIndex:i];
            model.d = [self getKDJForDWithCycle:[self.KDJArr[0] integerValue] DCycle:[self.KDJArr[2] integerValue] dataIndex:i];
            model.j = [self getKDJForJ:i];
        }
    }
    
    self.lineChartScrollView.data = self.data;
}

- (void)removeArray {
    [_data removeAllObjects];
}

#pragma - 设置指标默认参数

- (void)setDefaultMAWithCycle1:(NSInteger)cycle1 cycle2:(NSInteger)cycle2 cycle3:(NSInteger)cycle3 {
    _defaultMAArr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld", (long)cycle1], [NSString stringWithFormat:@"%ld", (long)cycle2], [NSString stringWithFormat:@"%ld", (long)cycle3], nil];
    _MAArr = [NSArray arrayWithArray:self.defaultMAArr];
}

- (void)setDefaultBOLLWithCycle:(NSInteger)cycle offset:(NSInteger)offset {
    _defaultBOLLArr = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%ld", (long)cycle], [NSString stringWithFormat:@"%ld", (long)offset], nil];
    _BOLLArr = [NSArray arrayWithArray:self.defaultBOLLArr];
}
#pragma mark - 设置指标参数
#pragma mark MA

- (void)setMAArr:(NSArray *)MAArr {
    _MAArr = MAArr;
    
    for (NSInteger i = 0; i < self.data.count; i++) {
        KLineChartModel *oneModel = [self.data objectAtIndex:i];
        oneModel.ma5 = [self getMA:[MAArr[0] integerValue] dataIndex:i];
        oneModel.ma10 = [self getMA:[MAArr[1] integerValue] dataIndex:i];
        oneModel.ma20 = [self getMA:[MAArr[2] integerValue] dataIndex:i];
    }
}

#pragma mark BOLL

- (void)setBOLLArr:(NSArray *)BOLLArr {
    _BOLLArr = BOLLArr;
    
    for (NSInteger i = 0; i < self.data.count; i++) {
        KLineChartModel *oneModel = [self.data objectAtIndex:i];
        oneModel.md = [self getMD:[BOLLArr[0] integerValue] dataIndex:i];
        oneModel.mb = [self getMA:[BOLLArr[0] integerValue] dataIndex:i - 1];
        oneModel.up = oneModel.mb + oneModel.md * [BOLLArr[1] integerValue];
        oneModel.dn = oneModel.mb - oneModel.md * [BOLLArr[1] integerValue];
    }
}

#pragma mark - 计算
#pragma mark KDJ

- (CGFloat)getKDJForJ:(NSInteger)index {
    KLineChartModel *model = [self.data objectAtIndex:index];
    // J值=3*当日K值-2*当日D值
    return 3 * model.k - 2 * model.d;
}

- (CGFloat)getKDJForDWithCycle:(NSInteger)cycle DCycle:(NSInteger)DCycle dataIndex:(NSInteger)index {
    if (index == 0) {
        return 50;
    }
    else {
        KLineChartModel *lastModel = [self.data objectAtIndex:index - 1];
        KLineChartModel *model = [self.data objectAtIndex:index];
        
        // 当日D值=2/3×前一日D值+1/3×当日K值
//        return (model.k + 2 * lastModel.d) / DCycle;
        return (model.k + (DCycle - 1) * lastModel.d) / DCycle;
    }
}

- (CGFloat)getKDJForKWithCycle:(NSInteger)cycle KCycle:(NSInteger)KCycle dataIndex:(NSInteger)index {
    if (index == 0) {
        return 50;
    }
    else {
        CGFloat close = 0;
        CGFloat low = CGFLOAT_MAX;
        CGFloat high = CGFLOAT_MIN;
        for (NSInteger i = 0; i < cycle && i <= index; i++) {
            KLineChartModel *oneModel = [self.data objectAtIndex:index - i];
            if (i == 0) {
                close = [oneModel.close doubleValue];
            }
            if (low > [oneModel.low doubleValue]) {
                low = [oneModel.low doubleValue];
            }
            if (high < [oneModel.high doubleValue]) {
                high = [oneModel.high doubleValue];
            }
        }
        //RSV
        CGFloat rsv = [self RSVWithClose:close low:low high:high];
        KLineChartModel *lastModel = [self.data objectAtIndex:index - 1];
        // 当日K值=2/3×前一日K值+1/3×当日RSV
//        return (rsv + 2 * lastModel.k) / KCycle;
        return (rsv + (KCycle - 1) * lastModel.k) / KCycle;
    }
}

- (CGFloat)RSVWithClose:(CGFloat)close low:(CGFloat)low high:(CGFloat)high {
    return (close - low) / (high - low) * 100;
}

#pragma mark RSI

- (CGFloat)getRSI:(NSInteger)cycle dataIndex:(NSInteger)index {
    if (index == 0) {
        return 0;
    }
    else {
        // RS（相对强度）= N日内收盘价涨数和之均值÷N日内收盘价跌数和之均值
        CGFloat rise = 0;
        CGFloat fall = 0;
        for (NSInteger i = 0; i < cycle && i < index; i++) {
            KLineChartModel *firstModel = [self.data objectAtIndex:index - i];
            KLineChartModel *secondModel = [self.data objectAtIndex:index - i - 1];
            CGFloat number = [firstModel.close doubleValue] - [secondModel.close doubleValue];
            if (number >= 0) {
                rise += number;
            }
            else {
                fall += number * -1;
            }
        }
        return rise / (rise + fall) * 100;
    }
}

#pragma mark MACD

- (CGFloat)getMACDWithDataIndex:(NSInteger)index {
    //用（DIF-DEA）*2即为MACD柱状图
    KLineChartModel *model = [self.data objectAtIndex:index];
    return (model.diff - model.dea) * 2;
}

#pragma mark DEA

- (CGFloat)getDEA:(NSInteger)cycle dataIndex:(NSInteger)index {
    //今日DEA =（前一日DEA X 8/10 + 今日DIF X 2/10）
    if (index == 0) {
        return 0;
    }
    else {
        KLineChartModel *lastModel = [self.data objectAtIndex:index - 1];
        KLineChartModel *model = [self.data objectAtIndex:index];
        return lastModel.dea * (cycle - 1) / (cycle + 1) + model.diff * 2 / (cycle + 1);
    }
}

#pragma mark DIFF(12 26)

- (CGFloat)getDIFF:(NSInteger)index {
    //差离值（DIF）的计算：DIF = EMA（12） - EMA（26）
    KLineChartModel *model = [self.data objectAtIndex:index];
    return  model.emas - model.emal;
}

#pragma mark EMA

- (CGFloat)getEMAShort:(NSInteger)cycle dataIndex:(NSInteger)index {
    //EMA（12）= 前一日EMA（12）×11/13＋今日收盘价×2/13
    KLineChartModel *model = [self.data objectAtIndex:index];
    if (index == 0) {
        return [model.close doubleValue];
    }
    else {
        KLineChartModel *lastModel = [self.data objectAtIndex:index - 1];
        return lastModel.emas * (cycle - 1) / (cycle + 1) + [model.close doubleValue] * 2 / (cycle + 1);
    }
}

- (CGFloat)getEMALong:(NSInteger)cycle dataIndex:(NSInteger)index {
    KLineChartModel *model = [self.data objectAtIndex:index];
    if (index == 0) {
        return [model.close doubleValue];
    }
    else {
        KLineChartModel *lastModel = [self.data objectAtIndex:index - 1];
        return lastModel.emal * (cycle - 1) / (cycle + 1) + [model.close doubleValue] * 2 / (cycle + 1);
    }
}

#pragma mark 标准差

- (CGFloat)getMD:(NSInteger)cycle dataIndex:(NSInteger)index {
    if (cycle - 1 <= index) {
        CGFloat mdCount = 0;
        CGFloat ma = [self getMA:cycle dataIndex:index];
        for (NSInteger i = index - (cycle - 1); i <= index; i++) {
            KLineChartModel *model = [self.data objectAtIndex:i];
            mdCount += pow([model.close doubleValue] - ma, 2);
        }
        return sqrt(mdCount / cycle);
    }
    else {
        return 0;
    }
}

#pragma mark 均线

- (CGFloat)getMA:(NSInteger)cycle dataIndex:(NSInteger)index {
    if (cycle - 1 <= index) {
        CGFloat maCount = 0;
        for (NSInteger i = index - (cycle - 1); i <= index; i++) {
            KLineChartModel *model = [self.data objectAtIndex:i];
            maCount += [model.close doubleValue];
        }
        return maCount / cycle;
    }
    else {
        return 0;
    }
}
@end
