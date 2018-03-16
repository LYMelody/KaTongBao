//
//  JXRegistViewController.h
//  JingXuan
//
//  Created by rongfeng on 16/6/2.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXRegistViewController : UIViewController

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *verifyLabel;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *verifyTextField;
@property (nonatomic, strong) UITextField *pswTextField;
@property (nonatomic, strong) UITextField *notarizePswTF;

@end
