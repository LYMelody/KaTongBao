//
//  UISaveCardPay.h
//  wujie
//
//  Created by rongfeng on 15/11/20.
//  Copyright © 2015年 ND. All rights reserved.
//


#import "CodeModel.h"
@interface UISaveCardPay : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)CodeModel *model;
@property(nonatomic,copy)NSString *orderNo;
@property(nonatomic,assign)NSInteger tag;
@end
