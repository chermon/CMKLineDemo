//
//  CMUrlsManager.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import "CMUrlsManager.h"

static id _instance;

NSString *const BASEURL = @"https://globaldemo.beihaiwang123.com";
NSString *const MOBILEBASEURL = @"https://globaldemo.beihaiwang123.com";
NSString *const STATICURL = BASEURL;
NSString *const BASEWEBURL = BASEURL;
//国内
NSString *const BASEQUETEURL = @"quoteone.argofx.com:7777";//@"120.131.8.8:7777";  //羽凡提供新地址 @"quoteone.argofx.com:7777";//
NSString *const BASEQUETEET6URL = @"120.131.8.8:7778";  //ET6
//Websocket URL
NSString *const BASESOCKETURL = @"ws://120.131.14.183:9308";
NSString *const BaseImgURL = @"https://demoimg.beihaiwang123.com";

NSString *NewBaseUrl;
NSString *NewBaseApiUrl;
NSString *NewBaseWebUrl;
NSString *NewBaseQuoteUrl;
NSString *NewBaseQuoteET6Url;
NSString *NewBaseStaticUrl;
NSString *NewBaseImageUrl;
NSString *NewBaseSocketUrl;

@implementation CMUrlsManager


+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self updateUrls];
    }
    return self;
}

-(void)updateUrls{
    NewBaseUrl = BASEURL;
    NewBaseWebUrl = BASEWEBURL;
    NewBaseQuoteUrl = BASEQUETEURL;
    NewBaseQuoteET6Url = BASEQUETEET6URL;
    NewBaseStaticUrl = STATICURL;
    NewBaseSocketUrl = BASESOCKETURL;
    NewBaseImageUrl = BaseImgURL;
        
    NewBaseApiUrl = [NewBaseUrl stringByAppendingString:@"/api/app"];
}

#pragma mark 历史报价

+ (NSString *)QuoteHistoryUrl {
    return [NewBaseApiUrl stringByAppendingString:@"/v3/quote/history"];
}

#pragma mark 所有外汇名称

+ (NSString *)SymbolsUrl {
    return [NewBaseApiUrl stringByAppendingString:@"/v3/symbol/list"];
}

@end
