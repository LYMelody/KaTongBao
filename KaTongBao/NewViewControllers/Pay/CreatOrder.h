//
//  CreatOrder.h
//  wujieNew
//
//  Created by rongfeng on 15/12/21.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIComboBox.h"
#import "UPPayPluginDelegate.h"
#import "CodeModel.h"
@interface CreatOrder : UIViewController<UIComboBoxDelegate,UPPayPluginDelegate>

@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,assign)BOOL ISYinLian;
@property(nonatomic,strong)CodeModel *model;
@property(nonatomic,strong)NSString *T1Msg;
@property(nonatomic,strong)NSString *T0Msg;
@property(nonatomic,strong)NSString *UP0Msg;
@property(nonatomic,strong)NSString *HST0Msg;
@property(nonatomic,strong)NSString *ANmsg;

@property(nonatomic,strong)NSString *T1bank;
@property(nonatomic,strong)NSString *T0bank;
@property (nonatomic,strong)NSString *HST0bank;
@property(nonatomic,strong)NSString *ANbank;

- (void)comboBoxChange:(UIComboBox*)comboBox;

@end
