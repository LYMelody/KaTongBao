//
//  OrderListViewController.h
//  wujieNew
//
//  Created by rongfeng on 15/12/17.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
@interface OrderListViewController : UIViewController<UIGestureRecognizerDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)OrderModel *model;
@end
