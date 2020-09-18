//
//  CMUUIDTools.m
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import "CMUUIDTools.h"
#import "CMKeyChainStore.h"
@implementation CMUUIDTools
+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[CMKeyChainStore load:@"com.company.app.usernamepassword"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [CMKeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
        
    }
    
    return strUUID.length == 0?@"":strUUID;
}
@end
