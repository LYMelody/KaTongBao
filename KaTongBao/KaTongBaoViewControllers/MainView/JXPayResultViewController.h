//
//  JXPayResultViewController.h
//  JingXuan
//
//  Created by rongfeng on 16/6/3.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXPayResultViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign)NSInteger tag;
@property (nonatomic,copy)NSString *failMsg;
@property (nonatomic,copy)NSString *settleNo;
@property (nonatomic,assign)BOOL IsJieSuan;
@end
