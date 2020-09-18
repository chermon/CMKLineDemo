//
//  NSDictionary+empty.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import "NSDictionary+empty.h"

@implementation NSDictionary (empty)
- (NSString *)emptyObjectForKey:(NSString *)key
{

    if (![self isKindOfClass:[NSDictionary class]]) {
        NSLog(@"------ %@   %d",[NSDictionary class], [self isKindOfClass:[NSDictionary class]]);
        return @"";
    }
    NSString *string = self[key];
    
    // 转换空串
    if ([string isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if (string==nil){
        return @"";
    }
    else
        return [NSString stringWithFormat:@"%@",string];
}
@end
