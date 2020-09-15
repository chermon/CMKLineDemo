//
//  UIView+CSH.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/14.
//  Copyright © 2020 梦. All rights reserved.
//

#import "UIView+CSH.h"

@implementation UIView (CSH)
- (void)setViewCenterX:(CGFloat)x
{
    CGPoint viewCenter = self.center;
    viewCenter.x = x;
    [self setCenter:viewCenter];
}

- (void)setViewCenterY:(CGFloat)y
{
    CGPoint viewCenter = self.center;
    viewCenter.y = y;
    [self setCenter:viewCenter];
}

- (CGFloat)viewCenterX
{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)viewCenterY
{
    return CGRectGetMidY(self.frame);
}

// 设置UIView的X
- (void)setViewX:(CGFloat)x
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.x = x;
    [self setFrame:viewFrame];
}

// 设置UIView的Y
- (void)setViewY:(CGFloat)y
{
    CGRect viewFrame = self.frame;
    viewFrame.origin.y = y;
    [self setFrame:viewFrame];
}

// 设置UIView的Origin
- (void)setViewOrigin:(CGPoint)origin
{
    CGRect viewFrame = self.frame;
    viewFrame.origin = origin;
    [self setFrame:viewFrame];
}

// 设置UIView的width
- (void)setViewWidth:(CGFloat)width
{
    CGRect viewFrame = self.frame;
    viewFrame.size.width = width;
    [self setFrame:viewFrame];
}

// 设置UIView的height
- (void)setViewHeight:(CGFloat)height
{
    
    if (isnan(height)) {
        height = 0;
    }
    CGRect viewFrame = self.frame;
    viewFrame.size.height = height;
    [self setFrame:viewFrame];
}

// 设置UIView的Size
- (void)setViewSize:(CGSize)size
{
    CGRect viewFrame = self.frame;
    viewFrame.size = size;
    [self setFrame:viewFrame];
}

// 获取UIView的X坐标
- (CGFloat)viewX
{
    return CGRectGetMinX(self.frame);
}

// 获取UIView的Y坐标
- (CGFloat)viewY
{
    return CGRectGetMinY(self.frame);
}

// 获取UIView的右X坐标
- (CGFloat)viewMaxX
{
    return CGRectGetMaxX(self.frame);
}

// 获取UIView的底Y坐标
- (CGFloat)viewMaxY
{
    return CGRectGetMaxY(self.frame);
}

// 获得UIView的origin
- (CGPoint)viewOrigin
{
    return self.frame.origin;
}

// 获取UIView的width
- (CGFloat)viewWidth
{
    return CGRectGetWidth(self.frame);
}

// 获取UIView的height
- (CGFloat)viewHeight
{
    return CGRectGetHeight(self.frame);
}

// 获得UIView的size
- (CGSize)viewSize
{
    return self.frame.size;
}

- (void)removeAllSubviews
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
