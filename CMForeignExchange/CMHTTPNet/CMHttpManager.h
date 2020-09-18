//
//  CMHttpManager.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CMHttpManager : NSObject

/**
 获取报价历史
 
 @param param <#param description#>
 @param successBlock <#successBlock description#>
 @param failureBlock <#failureBlock description#>
 */
+ (void)getSymbolHistoryWithParam:(NSDictionary *)param success:(void(^)(id result))successBlock failureL:(void(^)(id error))failureBlock;
/**
*  外汇品种
*
*  @param param        <#param description#>
*  @param successBlock <#successBlock description#>
*  @param failureBlock <#failureBlock description#>
*/
+ (void)symbolsListWithParam:(NSDictionary *)param success:(void(^)(id result))successBlock failureL:(void(^)(id error))failureBlock;

@end

NS_ASSUME_NONNULL_END
