//
//  NoCardViewController.h
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "BaseViewController.h"

@interface NoCardViewController : BaseViewController
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) void(^dataBlock)(NSString *amount, NSString *orderNo, NSString *orderTime);
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderTime;
@end
