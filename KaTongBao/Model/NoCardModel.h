//
//  NoCardModel.h
//  JingXuan
//
//  Created by wj on 16/5/27.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShortcutViewController.h"
@interface NoCardModel : NSObject
@property (nonatomic, strong) NSString *cardBank;
@property (nonatomic, strong) NSString *cardCert;
@property (nonatomic, strong) NSString *cardCvv;
@property (nonatomic, strong) NSString *cardNo;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSString *cardYxq;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderTime;

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSMutableArray *array;

- (void)initWithDic:(NSDictionary *)dic;

@end
