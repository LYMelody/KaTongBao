//
//  BankNumberVC.h
//  wujieNew
//
//  Created by rongfeng on 15/12/22.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BankNumberVC : UIViewController<UITextFieldDelegate>
@property(nonatomic,strong)NSString *t1Bank;
@property(nonatomic,strong)NSString *t0Bank;
@property(nonatomic,strong)NSString *hst0Bank;
@property(nonatomic,strong)NSString *ANbank;

//跳转属性
@property(nonatomic,strong)NSString *linkId;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *frontUrl;
@property(nonatomic,strong)NSString *backUrl;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *sign;
@end
