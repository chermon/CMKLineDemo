//
//  AppDelegate.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/9.
//  Copyright © 2020 梦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
- (AFHTTPSessionManager *)sharedHTTPSession;
@end

