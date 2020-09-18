//
//  UIFont+sysfont.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import "UIFont+sysfont.h"

@implementation UIFont (sysfont)

+ (UIFont *)fontCnMediumWithSize:(CGFloat)size
{
//    if ([GITGlobalToos systemLanguageIsChinese]) {
        UIFont *font = [UIFont boldSystemFontOfSize:size];
        return font;
//    }
//    else{
//        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium"size:size];
//        return font;
//    }
}

+ (UIFont *)fontCnRegularWithSize:(CGFloat)size
{
//    if ([GITGlobalToos systemLanguageIsChinese]) {
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue"size:size];//这个是9.0以后自带的平方字体
        return font;
//    }
//    else{
//        UIFont *font = [UIFont fontWithName:@"HelveticaNeue"size:size];
//        return font;
//    }
}
+ (UIFont *)fontCnLightWithSize:(CGFloat)size
{
//    if ([GITGlobalToos systemLanguageIsChinese]) {
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light"size:size];//这个是9.0以后自带的平方字体
        return font;
//    }
//    else{
//        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin"size:size];
//        return font;
//    }
}

+ (UIFont *)fontEnLightWithSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light"size:size];

    return font;
}
+ (UIFont *)fontEnRegularWithSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue"size:size];

    return font;
}

+ (UIFont *)fontEnThinWithSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin"size:size];
        
    return font;
}
+ (UIFont *)fontEnMediumWithSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium"size:size];
  
    return font;
}
@end
