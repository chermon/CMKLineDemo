//
//  UIFont+sysfont.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (sysfont)
+ (UIFont *)fontCnMediumWithSize:(CGFloat)size;
+ (UIFont *)fontCnRegularWithSize:(CGFloat)size;
+ (UIFont *)fontCnLightWithSize:(CGFloat)size;

+ (UIFont *)fontEnLightWithSize:(CGFloat)size;
+ (UIFont *)fontEnRegularWithSize:(CGFloat)size;
+ (UIFont *)fontEnThinWithSize:(CGFloat)size;
+ (UIFont *)fontEnMediumWithSize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
