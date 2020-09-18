//
//  CMTools.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMTools : NSObject
/**
*  版本号
*
*  @return <#return value description#>
*/
+ (NSString *)getAPPVersion;
/**
*  时间戳
*
*  @return <#return value description#>
*/
+ (NSString *)timeSp;
@end

NS_ASSUME_NONNULL_END
