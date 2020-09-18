//
//  NSDictionary+empty.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (empty)
/**
 *  空返回@""
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (NSString *)emptyObjectForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
