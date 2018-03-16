//
//  KTBOrderDetailViewController.h
//  KaTongBao
//
//  Created by rongfeng on 16/6/21.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JieSuanModel.h"
@interface KTBOrderDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) JieSuanModel *model;
@end
