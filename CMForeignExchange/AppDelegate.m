//
//  AppDelegate.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/9.
//  Copyright © 2020 梦. All rights reserved.
//

#import "AppDelegate.h"

static AFHTTPSessionManager *manager;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [CMUrlsManager sharedManager];
    [self getallSymbolsInfo];
    return YES;
}


#pragma mark - 解决AFHTTPSessionManager的内存泄漏

- (AFHTTPSessionManager *)sharedHTTPSession {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];

        manager.requestSerializer.timeoutInterval = 20;
        


    });
    return manager;
}


- (void)getallSymbolsInfo
{
    [CMHttpManager symbolsListWithParam:@{@"detail":@"1"} success:^(id result) {
        NSString *is_succ = [result emptyObjectForKey:@"is_succ"];
        if ([is_succ isEqualToString:@"1"]) {
            [self saveSymbolsInfoDic:result];
            [[NSUserDefaults standardUserDefaults] setObject:result forKey:SymbolsInfoKey];
        }
    } failureL:^(id error) {
       
    }];
}

- (void)saveSymbolsInfoDic:(NSDictionary *)symbolsDic
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *is_succ = [symbolsDic emptyObjectForKey:@"is_succ"] ;
        if ([is_succ isEqualToString:@"1"]) {
            NSArray *data = symbolsDic[@"data"];
            NSMutableDictionary *muDic = [[NSMutableDictionary alloc]init];
            for (NSDictionary *objc in data) {
                NSString *dicKey = [objc emptyObjectForKey:@"symbol"];
                [muDic setObject:objc forKey:dicKey];
            }
            [[NSUserDefaults standardUserDefaults] setObject:muDic forKey:SymbolsInfoDicKey];
            
        }
    });
}
//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
