//
//  CMLengthDefine.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#ifndef CMLengthDefine_h
#define CMLengthDefine_h

//******************************屏幕宽******************************
#define GITSCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//******************************屏幕高******************************
#define GITSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//****************************导航栏高度*****************************
#define GITNAV_HEIGHT \
({CGFloat navHeight = 44;\
if (@available(iOS 12.0, *)) {\
if (IsIpad) {\
navHeight = 50;}}\
(navHeight);})
//***************************底部导航栏高度***************************
#define GITTAB_HEIGHT \
({CGFloat tabHeight = 49;\
if (@available(iOS 12.0, *)) {\
if (IsIpad) {\
tabHeight = 50;}}\
(tabHeight);})
//**************************** 上方高度*****************************
#define GITTOP_HEIGHT \
({CGFloat statusBarHeight = 20;\
if (GITBOTTOM_HEIGHT > 0) {\
if (IsIpad) {\
statusBarHeight = 24;}\
else {\
statusBarHeight = 44;}\
}\
(statusBarHeight + GITNAV_HEIGHT);})
//**************************** 状态栏高度*****************************
//#define GITTSTATUS_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define GITTSTATUS_HEIGHT (GITTOP_HEIGHT-GITNAV_HEIGHT)
//**************************** cell高 ******************************
#define CELL_HEIGHT 52.5f
//*************** 安全区底部高度 iPhone 34 iPad 20 *******************
#define GITBOTTOM_HEIGHT \
({CGFloat bottomHeight = 0;\
if (@available(iOS 11.0, *)) {\
bottomHeight = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;\
}\
(bottomHeight);})

#endif /* CMLengthDefine_h */
