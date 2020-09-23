//
//  CMKLineChartView.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import "CMKLineChartView.h"
#import "KLineChartView.h"
#import "CMAnimalView.h"
#import "CMKLineDataModel.h"

#define defaultLimit 300

@interface CMKLineChartView()<KLineChartViewDelegate>
@property (nonatomic, weak) KLineChartView *lineChartView;  //K线图
@property (nonatomic, weak) CMAnimalView *loadView;
@property (nonatomic, strong) NSMutableArray *klineData; //K线图数据
@property (nonatomic, strong) KLineChartDataSet *dataSet; //K线图初始设置
@property (nonatomic, copy) NSString *symbols_en;
@property (nonatomic, assign) NSInteger currentOffset;
@property (nonatomic, assign) NSInteger digits;
@property (nonatomic, copy) NSString *stop_time;
@property (nonatomic, assign) NSInteger selectTimeIndex;  //选择时间
@end

@implementation CMKLineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //初始化
        _selectTimeIndex = 4;
        _klineData = [NSMutableArray array];
        _currentOffset = 0;
        
        //K线图显示设置
        _dataSet = [[KLineChartDataSet alloc] init];
        _dataSet.backgroundColor = [UIColor whiteColor];
        _dataSet.candleContentTop = 5;
        _dataSet.candleContentBottom = 34;
        _dataSet.candleBelowTop = 20;
        _dataSet.candleBelowBottom = 5;
        _dataSet.candleLeftRightMargin = 16;
        _dataSet.candleBorderColor = GITLINECOLOR;
        _dataSet.candleBorderTBWidth = 0.5;
        _dataSet.candleBorderLRWidth = self.dataSet.candleBorderTBWidth;
        _dataSet.candleBoxLineColor = GITLINECOLOR;
        _dataSet.candleBoxLineWidth = 0.5;
        _dataSet.candlePriceLineCount = 4;
        _dataSet.candlePriceCount = 6;
        _dataSet.showCandleHighPrice = YES;
        _dataSet.candleBetweenTimeNumber = 10;
        _dataSet.candlePriceColor = GITAUXILIARYLIGHTCOLOR;
        _dataSet.candlePriceFont = [UIFont fontEnRegularWithSize:9];
        _dataSet.candleTimeColor = self.dataSet.candlePriceColor;
        _dataSet.candleTimeFont = self.dataSet.candlePriceFont;
        _dataSet.candleShowPriceType = KLineChartShowPriceTypeRight;
        _dataSet.candleTopMarkHeight = 24;
        _dataSet.candleMarkAlignment = NSTextAlignmentCenter;
        _dataSet.candleMarkColor = GITAUXILIARYWEIGHTCOLOR;
        _dataSet.candleMarkFont = [UIFont fontEnRegularWithSize:9];
        _dataSet.candleVolumeName = @"手";
        _dataSet.candleRiseColor = GITSTYLECOLOR_RED;
        _dataSet.candleFallColor = GITSTYLECOLOR_GREEN;
        _dataSet.candleContentRight = 50;
        _dataSet.candleRiseAcrImage = [UIImage imageNamed:@"KLineArcShadow_red"];
        _dataSet.candleFallAcrImage =  [UIImage imageNamed:@"KLineArcShadow_green"] ;
        _dataSet.candleWidth = 5;
        _dataSet.candleMinWidth = 2.5;
        _dataSet.candleMaxWidth = 30;
        _dataSet.candleLineWidth = 1;
        _dataSet.candleSpace = 2;
        _dataSet.candleNotShowLeftCount = 0;
        _dataSet.candleViewHightScale = 0.78;
        _dataSet.candleMA5Color = RGB(74, 144, 226);
        _dataSet.candleMA10Color = RGB(245, 166, 35);
        _dataSet.candleMA20Color = RGB(208, 2, 27);
        _dataSet.candleMIDColor = self.dataSet.candleMA5Color;
        _dataSet.candleUPPERColor = self.dataSet.candleMA10Color;
        _dataSet.candleLOWERColor = self.dataSet.candleMA20Color;
        _dataSet.candleDIFFColor = self.dataSet.candleMA5Color;
        _dataSet.candleDEAColor = self.dataSet.candleMA10Color;
        _dataSet.candleRSI6Color = self.dataSet.candleMA5Color;
        _dataSet.candleRSI12Color = self.dataSet.candleMA10Color;
        _dataSet.candleRSI24Color = self.dataSet.candleMA20Color;
        _dataSet.candleKColor = self.dataSet.candleMA5Color;
        _dataSet.candleDColor = self.dataSet.candleMA10Color;
        _dataSet.candleJColor = self.dataSet.candleMA20Color;
        _dataSet.candleType = KLineChartCandleViewTypeMA;
        _dataSet.belowType = KLineChartBelowViewTypeMACD;
        
        KLineChartView *lineChartView = [[KLineChartView alloc] initWithFrame: CGRectMake(0, 0, self.viewWidth, 300) dataSet:_dataSet];
        lineChartView.delegate = self;
        [lineChartView setDefaultMAWithCycle1:5 cycle2:10 cycle3:20];
        [lineChartView setDefaultBOLLWithCycle:20 offset:2];
        [self addSubview:lineChartView];
        self.lineChartView = lineChartView;
        
        
//        //加载中动画
//        CMAnimalView *loadView = [[CMAnimalView alloc] initWithFrame: lineChartView.frame];
//        loadView.backgroundColor = GITCOLOR_ZERO_WHITE;
//        [self addSubview:loadView];
//        self.loadView = loadView;
    }
    return self;
}

#pragma mark - 设置品种

- (void)setSymbols_en:(NSString *)symbols_en symbols_cn:(NSString *)symbols_cn {
    _symbols_en = symbols_en;
    

    NSDictionary *resultSymbols = [[NSUserDefaults standardUserDefaults] objectForKey:SymbolsInfoDicKey];
    if (resultSymbols) {
        NSDictionary *dic = resultSymbols[symbols_en];
        self.digits = [[dic emptyObjectForKey:@"digits"] integerValue];
    }
    
    //获取数据
    _currentOffset = 0;
    [self reload:NO];
}

-(void)reload:(BOOL)moreData{
    _stop_time = [CMTools timeSp];
    switch (self.selectTimeIndex) {
        case 0:
            self.dataSet.candleTimeType = KLineChartTimeTypeHour;
            [self getHistoryPriceData:@"1" moreData:moreData];
            break;
        case 1:
            self.dataSet.candleTimeType = KLineChartTimeTypeHour;
            [self getHistoryPriceData:@"5" moreData:moreData];
            break;
        case 2:
            self.dataSet.candleTimeType = KLineChartTimeTypeHour;
            [self getHistoryPriceData:@"15" moreData:moreData];
            break;
        case 3:
            self.dataSet.candleTimeType = KLineChartTimeTypeHour;
            [self getHistoryPriceData:@"30" moreData:moreData];
            break;
        case 4:
            self.dataSet.candleTimeType = KLineChartTimeTypeHour;
            [self getHistoryPriceData:@"60" moreData:moreData];
            break;
        case 5:
            self.dataSet.candleTimeType = KLineChartTimeTypeHour;
            [self getHistoryPriceData:@"240" moreData:moreData];
            break;
        case 6:
            self.dataSet.candleTimeType = KLineChartTimeTypeDay;
            [self getHistoryPriceData:@"1440" moreData:moreData];
            break;
        case 7:
            self.dataSet.candleTimeType = KLineChartTimeTypeWeek;
            [self getHistoryPriceData:@"10080" moreData:moreData];
            break;
        case 8:
            self.dataSet.candleTimeType = KLineChartTimeTypeMonth;
            [self getHistoryPriceData:@"43200" moreData:moreData];
            break;
        default:
            break;
    }
}

#pragma mark KLineChartViewDelegate
//重新加载
- (void)KLineChartViewForReload{
    self.currentOffset = 0;
    [self reload:false];
}

//更多加载
- (void)KLineChartViewForMoreData{
    [self reload:true];
}

-(void)getHistoryPriceData:(NSString *)type moreData:(BOOL)moreData{
    
    NSDictionary *param = @{@"symbol":self.symbols_en, @"type":type, @"offset":[NSString stringWithFormat:@"%ld", self.currentOffset], @"limit":[NSString stringWithFormat:@"%d", defaultLimit],@"stop_time":self.stop_time};
    
    [CMHttpManager getSymbolHistoryWithParam:param success:^(id  _Nonnull result) {
        CMKLineDataModel *kLineModel = [CMKLineDataModel mj_objectWithKeyValues:result];
        if ([kLineModel.is_succ isEqualToString:@"1"] && kLineModel.data.records.count > 0) {
            if (self.currentOffset == 0) {
                self.lineChartView.digits = self.digits;
                self.lineChartView.timeType = type;
                self.klineData = kLineModel.data.records;
                [self.lineChartView removeArray];
            }
            else{
                [self.klineData addObjectsFromArray:kLineModel.data.records];
            }
            self.currentOffset = self.klineData.count;
            self.lineChartView.haveMoreData = self.klineData.count < [kLineModel.data.record_count integerValue] ? true:false;
            [self.lineChartView addDataFromArray:kLineModel.data.records];
            [self.lineChartView reload:moreData];
        }
        
    } failureL:^(id  _Nonnull error) {
        
    }];
}
@end
