//
//  TDInputPriceViewController.h
//  CFT
//
//  Created by 李 玉清 on 15/6/15.
//  Copyright (c) 2015年 TangDi. All rights reserved.
//

//#import "CJBaseViewController.h"
//#import "LandiMPOS.h"
//#import "TYSwiperController.h"
//#import "BluetoothCommanager.h"

@interface TDInputPriceViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *moneyLabel;

@property (strong, nonatomic) NSString *rat;
//@property (strong, nonatomic) TDPayInfo * payInfo;
@property (assign,nonatomic) NSInteger tag;
@property (retain, nonatomic) IBOutlet UILabel *amtLabel;
@property (weak, nonatomic) IBOutlet UIView *MoneyView;

@property (weak, nonatomic) IBOutlet UIView *KeyBoardView;

- (IBAction)clickButton:(UIButton *)sender;
- (IBAction)clickNumberButton:(UIButton *)sender;
//@property (strong,nonatomic)LandiMPOS *manager;
//@property (assign,nonatomic) TYSwiperController *tySwiper;

@end
