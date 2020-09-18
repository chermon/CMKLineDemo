//
//  CMHttpManager.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import "CMHttpManager.h"
#import "CMUUIDTools.h"
#import "AFNetworking.h"
#import "AppDelegate.h"
#import "CMUrlsManager.h"
@implementation CMHttpManager

+ (void)getSymbolHistoryWithParam:(NSDictionary *)param success:(void(^)(id result))successBlock failureL:(void(^)(id error))failureBlock
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:param];
//    if ([GITUserStoreInfo getInstance].trade_account_id!=nil&&[GITUserStoreInfo getInstance].trade_account_id.length!=0) {
//        [params setValue:[GITUserStoreInfo getInstance].trade_account_id forKey:@"mt4_id"];
//    }
//    if ([GITUserStoreInfo getInstance].trade_system_type!=nil&&[GITUserStoreInfo getInstance].trade_system_type.length!=0) {
//        [params setValue:[GITUserStoreInfo getInstance].trade_system_type forKey:@"trade_system_type"];
//    }
    [self getAFHttpNetworkWithParam:params url:[CMUrlsManager QuoteHistoryUrl] success:^(id  _Nonnull result) {
        if (successBlock) {
            successBlock(result);
        }
    }failureL:^(id  _Nonnull error, NSString * _Nonnull message) {
        if (failureBlock) {
            failureBlock(message);
        }
    }];
}

#pragma mark 所有外汇品种
+ (void)symbolsListWithParam:(NSDictionary *)param success:(void(^)(id result))successBlock failureL:(void(^)(id error))failureBlock
{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:param];
//    if ([GITUserStoreInfo getInstance].trade_account_id!=nil&&[GITUserStoreInfo getInstance].trade_account_id.length!=0) {
//        [params setValue:[GITUserStoreInfo getInstance].trade_account_id forKey:@"mt4_id"];
//    }
    [self getAFHttpNetworkWithParam:params url:[CMUrlsManager SymbolsUrl] success:^(id _Nonnull result) {
        if (successBlock) {
            successBlock(result);
        }
    } failureL:^(id  _Nonnull error, NSString * _Nonnull message) {
        if (failureBlock) {
            failureBlock(message);
        }
    }];
}
#pragma mark GET请求

+ (void)getAFHttpNetworkWithParam:(id)param url:(NSString *)url success:(void(^)(id result))successBlock failureL:(void(^)(id error, NSString *message))failureBlock {
    NSString * uuid= [CMUUIDTools getUUID];

    NSString *lang = @"cn";
    NSString *world_code = @"CN";
    NSString *userCode = @""; //[NXUserStoreInfo getInstance].userInfo.user_code!=nil?[NXUserStoreInfo getInstance].userInfo.user_code:@""
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *token = @"";//[NXUserStoreInfo getInstance].token;
    NSString *newUrl = [[NSString stringWithFormat:@"%@?user_id=%@&token=%@&uuid=%@&os=%@&version=%@&lang=%@&world_code=%@",url,userCode,token!=nil?token:@"",uuid,@"iOS",[CMTools getAPPVersion],lang,world_code] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet
    URLFragmentAllowedCharacterSet]];
    AFHTTPSessionManager *manager = [app sharedHTTPSession];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"%@",param);
    NSLog(@"%@",newUrl);
    //设置缓存策略
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:newUrl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (![[obj emptyObjectForKey:@"is_succ"] isEqualToString:@"1"]) {
            NSInteger code = [[obj emptyObjectForKey:@"code"] integerValue];
            if (code>=100100&&code<=100104) {
//                if ([NXUserStoreInfo getInstance].loginState == UserLoginState_Logged) {
//                    [NXUserStoreInfo getInstance].loginState = UserLoginState_Logout;
//                    [MBProgressHUD showError:@"登录已过期，请重新登录"];
//                    return ;
//                }
                
            }
        }
        if (successBlock) {
            successBlock(obj);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSInteger statusCode = [error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] statusCode];
        if (statusCode == 401) {
            [[NSNotificationCenter defaultCenter] postNotificationName:UnLogin401 object:nil];
        }
        else {
            if (failureBlock) {
                failureBlock(error, [self errorMessageWithStatusCode:statusCode]);
            }
        }
    }];
}

#pragma mark - 提示

+ (NSString *)errorMessageWithStatusCode:(NSInteger)statusCode {
    NSString *message = @"";
    if (statusCode == 400) {
        message = SERVERERROR_400;
    }
    else if (statusCode == 404) {
        message = SERVERERROR_404;
    }
    else if (statusCode == 444) {
        message = SERVERERROR_444;
    }
    else if (statusCode == 500) {
        message = SERVERERROR_500;
    }
    else if (statusCode == 502) {
        message = SERVERERROR_502;
    }
    else if (statusCode == 504) {
        message = SERVERERROR_504;
    }
    else {
        message = NONETWORK;
    }
    return message;
}

@end
