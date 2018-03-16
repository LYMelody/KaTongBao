//
//  KTBWeiXinPayResultViewController.h
//  KaTongBao
//
//  Created by rongfeng on 16/8/2.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTBWeiXinPayResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,strong)NSString *failMsg;
@end
