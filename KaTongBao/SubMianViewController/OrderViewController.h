//
//  OrderViewController.h
//  JingXuan
//
//  Created by wj on 16/5/13.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderViewController : BaseViewController
@property (nonatomic, retain) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSUserDefaults *user;
@property (nonatomic, strong) NSDictionary *dic;

@end
