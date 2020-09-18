//
//  CMKLineDataModel.h
//  CMForeignExchange
//
//  Created by 陈梦 on 2020/9/18.
//  Copyright © 2020 梦. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CMKLineDataModelForData;

@interface CMKLineDataModel : NSObject
@property (nonatomic, copy) NSString *is_succ;
@property (nonatomic, copy) NSString *error_msg;
@property (nonatomic, copy) NSString *error_code;
@property (nonatomic, strong) CMKLineDataModelForData *data;

@end
@interface CMKLineDataModelForData : NSObject

@property (nonatomic, copy) NSString *page_count;
@property (nonatomic, copy) NSString *record_count;
@property (nonatomic, strong) NSMutableArray *records;

@end
NS_ASSUME_NONNULL_END
