//
//  UIView+CSH.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/14.
//  Copyright © 2020 梦. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSH)

/**
 *  设置UIView的x中心
 *
 *  @param x 中心的x坐标
 */
- (void)setViewCenterX:(CGFloat)x;

/**
 *  设置UIView的y中心
 *
 *  @param y 中心的y坐标
 */
- (void)setViewCenterY:(CGFloat)y;

/**
 *  获取UIView中心的横坐标
 *
 *  @return view中心的横坐标
 */
- (CGFloat)viewCenterX;

/**
 *  获取UIView中心的纵坐标
 *
 *  @return view中心的纵坐标
 */
- (CGFloat)viewCenterY;

/**
 *  设置UIView的坐标X
 *
 *  @param x UIView的x
 */
- (void)setViewX:(CGFloat)x;

/**
 *  设置UIView的坐标Y
 *
 *  @param y UIView的y
 */
- (void)setViewY:(CGFloat)y;

/**
 *  设置UIView的Origin
 *
 *  @param origin UIView的坐标
 */
- (void)setViewOrigin:(CGPoint)origin;

/**
 *  设置UIView的width
 *
 *  @param width UIView的width
 */
- (void)setViewWidth:(CGFloat)width;

/**
 *  设置UIView的height
 *
 *  @param height UIView的height
 */
- (void)setViewHeight:(CGFloat)height;

/**
 *  设置UIView的Size
 *
 *  @param size UIView的size
 */
- (void)setViewSize:(CGSize)size;

/**
 *  获取UIView的X坐标
 *
 *  @return 横坐标x
 */
- (CGFloat)viewX;

/**
 *  获取UIView的Y坐标
 *
 *  @return 纵坐标y
 */
- (CGFloat)viewY;

/**
 *  获取UIView的右X坐标
 *
 *  @return view最右x
 */
- (CGFloat)viewMaxX;

/**
 *  获取UIView的底Y坐标
 *
 *  @return view最下y
 */
- (CGFloat)viewMaxY;

/**
 *  获得UIView的origin
 *
 *  @return view坐标
 */
- (CGPoint)viewOrigin;

/**
 *  获取UIView的width
 *
 *  @return view的width
 */
- (CGFloat)viewWidth;

/**
 *  获取UIView的height
 *
 *  @return view的height
 */
- (CGFloat)viewHeight;

/**
 *  获得UIView的size
 *
 *  @return view的size
 */
- (CGSize)viewSize;

// 移除所有子视图
- (void)removeAllSubviews;

@end

NS_ASSUME_NONNULL_END
