//
//  JXPayWithOrderViewController.h
//  JingXuan
//
//  Created by rongfeng on 16/6/3.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeModel.h"
@interface JXPayWithOrderViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)CodeModel *model;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,assign)NSInteger tag;

@end
