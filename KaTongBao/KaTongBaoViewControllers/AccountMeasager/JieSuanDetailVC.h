//
//  JieSuanDetailVC.h
//  wujieNew
//
//  Created by rongfeng on 16/1/7.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JieSuanModel.h"
@interface JieSuanDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) JieSuanModel *model;
@end
