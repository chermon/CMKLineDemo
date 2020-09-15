//
//  UIScrollView+contentInset.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/15.
//  Copyright © 2020 梦. All rights reserved.
//

#import "UIScrollView+contentInset.h"

@implementation UIScrollView (contentInset)

//load和initialize方法都会在实例化对象（即init）之前调用，而load会在main函数之前调用，initialize会在main函数之后调用，load和initialize方法调用顺序都是先父类再子类，先原类，再分类。所以该分类会被最后调用
+(void)load{
    [super load];
    //方法交换(Method Swizzle)
    if (@available(iOS 11.0, *)) {
        Method originM = class_getInstanceMethod([self class], @selector(initWithFrame:));
        Method exchangeM = class_getInstanceMethod([self class], @selector(cl_initWithFrame:));
        method_exchangeImplementations(originM, exchangeM);
    }
}

//适配iOS11
-(instancetype)cl_initWithFrame:(CGRect)frame{
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
   
    return [self cl_initWithFrame:frame];
}
@end
