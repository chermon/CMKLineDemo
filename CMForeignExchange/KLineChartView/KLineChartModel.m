//
//  KLineChartModel.m
//  KLineChartDome
//
//  Created by TigerWit on 2017/6/2.
//  Copyright © 2017年 bao. All rights reserved.
//

#import "KLineChartModel.h"

@implementation KLineChartModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"open" : @"open_price",
             @"volume" : @"vol"
             };
}

#pragma mark - 设置小数位数

+ (NSString *)handlePrice:(CGFloat)price digits:(NSInteger)digits isETF:(BOOL)isETF {
    if (digits != -1) {
        switch (digits) {
            case 0:
                return [NSString stringWithFormat:@"%.0f", price];
                break;
            case 1:
                return [NSString stringWithFormat:@"%.1f", price];
                break;
            case 2:
                return [NSString stringWithFormat:@"%.2f", price];
                break;
            case 3:
                return [NSString stringWithFormat:@"%.3f", price];
                break;
            case 4:
                return [NSString stringWithFormat:@"%.4f", price];
                break;
            case 5:
                return [NSString stringWithFormat:@"%.5f", price];
                break;
            case 6:
                return [NSString stringWithFormat:@"%.6f", price];
                break;
            default:
                break;
        }
    }
    if (isETF) {
#pragma mark 商鹏伟
        return [NSString stringWithFormat:@"%.6f", price];
//        return [NSString stringWithFormat:@"%.3f ",price];
    }
    return [NSString stringWithFormat:@"%.2f", price];
}

@end
