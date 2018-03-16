//
//  JXCheckOrderViewController.h
//  JingXuan
//
//  Created by rongfeng on 16/6/3.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXCheckOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *dateStr;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderTime;
@property (nonatomic, strong) NSArray *bankArray;
@property (nonatomic, strong) NSString *qrcode; //二维码
@property (nonatomic, assign) NSInteger tag;
@end
