//
//  OrderModel.h
//  JingXuan
//
//  Created by wj on 16/5/26.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderReqTime;
@property (nonatomic, strong) NSString *orderStatus;
@property (nonatomic, strong) NSString *orderType;
@property (nonatomic, strong) NSString *payBankName;
@property (nonatomic, strong) NSString *payBankNo;

@property (nonatomic, strong) NSDictionary *dataDic;

- (void)initWithDic:(NSDictionary *)dic;
@end
