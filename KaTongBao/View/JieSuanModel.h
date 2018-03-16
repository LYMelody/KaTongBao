//
//  JieSuanModel.h
//  wujieNew
//
//  Created by rongfeng on 16/1/6.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JieSuanModel : NSObject
@property (nonatomic,strong) NSString *amount;
@property (nonatomic,strong) NSString *free;
@property (nonatomic,strong) NSString *refound;
@property (nonatomic,strong) NSString *settleNo;
@property (nonatomic,strong) NSString *settleRate;
@property (nonatomic,strong) NSString *settleRateFee;
@property (nonatomic,strong) NSString *settleReqTime;
@property (nonatomic,strong) NSString *settleStatus;
@property (nonatomic,strong) NSString *settleStatusName;
@property (nonatomic,strong) NSString *settleType;
@property (nonatomic,strong) NSString *protect;
@property (nonatomic,strong) NSString *rate;
@property (nonatomic,strong) NSString *real;


@property (nonatomic,strong) NSString *cashAmount;
@property (nonatomic,strong) NSString *cashMeno;
@property (nonatomic,strong) NSString *linkId;
@property (nonatomic,strong) NSString *processType;
@property (nonatomic,strong) NSString *processTypeCn;
@property (nonatomic,strong) NSString *validTime;


@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *bankNo;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,strong) NSString *orderReqTime;
@property (nonatomic,strong) NSString *orderStatus;
@property (nonatomic,strong) NSString *orderStatusName;
@property (nonatomic,strong) NSString *orderType;
@end
