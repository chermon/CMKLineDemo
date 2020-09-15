//
//  CMColorDefine.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/14.
//  Copyright © 2020 梦. All rights reserved.
//

#ifndef CMColorDefine_h
#define CMColorDefine_h

//******************************常用16进制颜色******************************

//纯黑
#define GITCOLOR_ZERO_BLACK UIColorFromRGB(0x000000)
//纯白
#define GITCOLOR_ZERO_WHITE UIColorFromRGB(0xFFFFFF)
//tableview headerview背景色 248
#define GITCOLOR_BACKGROUD_COLOR UIColorFromRGB(0xF8F8F8)

//弹框底层背景色 153 153 153
#define GITCOLOR_BOTTMALERT_COLOR RGBA(153, 153, 153, 0.5)

//字体黑色 （重）1
#define GITAUXILIARYWEIGHTCOLOR RGBA(33,44,63,1)
//字体黑色 （轻）0.5
#define GITAUXILIARYLIGHTCOLOR RGBA(33,44,63,0.5)
//字体黑色 （超轻）0.5


//tableview section header背景色   248
#define GITVIEWBACKGROUNDCOLOR UIColorFromRGB(0xF4F6F9)
////tableview线条颜色  235
//#define GITLINECOLOR UIColorFromRGB(0xEBEBEB)
//分割线颜色  235
#define GITLINECOLOR RGBA(151,151,151,0.3)

//闭市颜色
#define GITCLOSINGPRICECOLOR RGB(181,181,181)

//框内分割线
#define GITSPLITLINECOLOR RGB(211,223,239)

//提示框的背景颜色 - 米黄色
#define GITHINTBACKGROUNGCOLOR RGB(255,247,234)
//联系我们导航栏颜色
#define GITCONTACTUSNAVCOLOR RGB(62,74,89)

//白标主题色
#if TARGET_VERSION ==1
#define GITSTYLEUPCOLOR_RED UIColorFromRGB(0xF5524F)           //红色  K线图
#define GITSTYLECOLOR_RED UIColorFromRGB(0xFF605B)           //红色
#define GITSTYLECOLOR_BOTTOM_RED RGBA(245, 82, 79, 0.15)           //底部背景红色
#define GITSTYLECOLOR_GREEN UIColorFromRGB(0x11C971)           //绿色

#define GITSTYLECOLOR_BOTTOM_GREEN RGBA(75, 214, 99, 0.15)         //底部背景绿色
#define GITSTYLECOLOR_BLUE UIColorFromRGB(0x4A90E2)          //蓝色

#define GITSTYLECOLOR_ORANGE UIColorFromRGB(0xF8E71C)      //黄色
//#define GITSTYLECOLOR_ORANGE UIColorFromRGB(0xfa709a)      //黄色
#define GITBBTEXTCOLOR GITAUXILIARYWEIGHTCOLOR                   //字体颜色34
#define GITBBTEXTTITLECOLOR UIColorFromRGB(0x9F8700)        //个别标题颜色（偏黄色）
#define GITBBMASTERCOLOR UIColorFromRGB(0xFEA00A)             //高手跟单标志黄色
#define GITBBBTNTITLECOLOR GITAUXILIARYWEIGHTCOLOR      //按钮字体颜色
//#define GITBBBTNTITLECOLOR UIColorFromRGB(0xffffff)      //按钮字体颜色

#define GITSTYLELAYERBEGINCOLOR UIColorFromRGB(0xfff200)    //渐变色开始颜色
#define GITSTYLELAYERENDCOLOR UIColorFromRGB(0xffd000)    //渐变色结束颜色
//#define GITSTYLELAYERBEGINCOLOR UIColorFromRGB(0xfee140)    //渐变色开始颜色
//#define GITSTYLELAYERENDCOLOR UIColorFromRGB(0xfa709a)    //渐变色结束颜色
#define GITBORDERSELECTEDORANGECOLOR  RGBA(255, 213, 33, 1) //边框选中黄
#define GITTWARNINGORANGECOLOR  RGBA(245, 166, 35, 1) //警告橘色



#elif TARGET_VERSION ==3
#define GITSTYLEUPCOLOR_RED UIColorFromRGBA(0xc81527,1)           //红色  K线图
#define GITSTYLECOLOR_RED UIColorFromRGBA(0xc81527,0.8)           //红色->红色-80%
#define GITSTYLECOLOR_GREEN UIColorFromRGB(0x06ba82)           //绿色->绿色-100%
#define GITSTYLECOLOR_BLUE UIColorFromRGB(0xb48f3c)          //蓝色->黄色-100%
#define GITSTYLECOLOR_ORANGE UIColorFromRGB(0xd7000f)      //黄色->红色—100%
#define GITBBTEXTCOLOR GITCOLOR_ZERO_WHITE                           //字体颜色34->纯白色
#define GITBBTEXTTITLECOLOR GITCOLOR_ZERO_WHITE                     //个别标题颜色（偏黄色）->纯白色
#define GITBBMASTERCOLOR UIColorFromRGB(0xc52922)           //高手跟单标志黄色->深黄色
#define GITBBBTNTITLECOLOR UIColorFromRGB(0xFFFFFF)

#elif TARGET_VERSION ==4
#define GITSTYLEUPCOLOR_RED UIColorFromRGBA(0xc81527,1)           //红色  K线图
#define GITSTYLECOLOR_RED UIColorFromRGBA(0xc81527,0.8)           //红色->红色-80%
#define GITSTYLECOLOR_BOTTOM_RED RGBA(245, 82, 79, 0.15)           //底部背景红色
#define GITSTYLECOLOR_GREEN UIColorFromRGB(0x06ba82)           //绿色->绿色-100%
#define GITSTYLECOLOR_BOTTOM_GREEN RGBA(75, 214, 99, 0.15)         //底部背景绿色

#define GITSTYLECOLOR_BLUE UIColorFromRGB(0x414bb4)          //蓝色->黄色-100%
#define GITSTYLECOLOR_ORANGE UIColorFromRGB(0x4555cd)      //黄色->红色—100%
#define GITBBTEXTCOLOR UIColorFromRGB(0x2C2C2C)                          //字体颜色34->纯白色
#define GITBBTEXTTITLECOLOR UIColorFromRGB(0x9F8700) //GITCOLOR_ZERO_WHITE                     //个别标题颜色（偏黄色）->纯白色
#define GITBBMASTERCOLOR UIColorFromRGB(0xc81527)           //高手跟单标志黄色->深黄色
#define GITBBBTNTITLECOLOR UIColorFromRGB(0xFFFFFF)
#define GITSTYLELAYERBEGINCOLOR UIColorFromRGB(0x51bdf2)    //渐变色开始颜色
#define GITSTYLELAYERENDCOLOR UIColorFromRGB(0x4555cd)    //渐变色结束颜色
#endif


//*********************************颜色转换********************************

/**
 *  16进制颜色转10进制颜色（无alpha）
 *
 *  @param rgbValue 16进制
 *
 *  @return UIColor
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/**
 *  16进制颜色转10进制颜色（带alpha）
 *
 *  @param rgbValue 16进制
 *  @param a        alpha
 *
 *  @return UIColor
 */
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/**
 *  带有RGBA的颜色设置
 *
 *  @param R <#R description#>
 *  @param G <#G description#>
 *  @param B <#B description#>
 *  @param A <#A description#>
 *
 *  @return <#return value description#>
 */
#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
/**
 *  带有RGB的颜色设置
 *
 *  @param r <#r description#>
 *  @param g <#g description#>
 *  @param b <#b description#>
 *
 *  @return <#return value description#>
 */
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]


/**
 *  清除背景色
 *
 *  @return clearColor
 */
#define CLEARCOLOR [UIColor clearColor]

#endif /* CMColorDefine_h */
