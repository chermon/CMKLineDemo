//
//  CMTools.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import "CMTools.h"

@implementation CMTools
+ (NSString *)getAPPVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}

+ (NSString *)timeSp{
//    NSDate *datenow =[NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:datenow];
//    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    NSString *timeSp = [NSString stringWithFormat:@"%zd", (long)[[NSDate date] timeIntervalSince1970]];
    //    NXLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
}
@end
