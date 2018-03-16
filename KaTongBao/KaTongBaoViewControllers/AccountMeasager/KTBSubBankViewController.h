//
//  KTBSubBankViewController.h
//  KaTongBao
//
//  Created by rongfeng on 16/8/1.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTBSubBankViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property(nonatomic,strong)NSArray *SubBankArray;
@property(nonatomic,assign)NSInteger tag;
@end
