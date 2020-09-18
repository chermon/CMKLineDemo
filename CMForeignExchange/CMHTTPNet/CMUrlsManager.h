//
//  CMUrlsManager.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMUrlsManager : NSObject
+ (instancetype)sharedManager;
+ (NSString *)QuoteHistoryUrl;
+ (NSString *)SymbolsUrl;
@end

NS_ASSUME_NONNULL_END
