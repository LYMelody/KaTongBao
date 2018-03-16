//
//  KTBCustomerCenterViewController.h
//  KaTongBao
//
//  Created by rongfeng on 16/8/15.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTBCustomerCenterViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)NSString *orgName;
@property(nonatomic,strong)NSString *orgNick;
@property(nonatomic,strong)NSString *cshName;
@property(nonatomic,strong)NSString *cshPhone;
@property(nonatomic,strong)NSString *cshTel;
@property(nonatomic,strong)NSString *cshWeixin;
@property(nonatomic,strong)NSString *cshQq;
@end
