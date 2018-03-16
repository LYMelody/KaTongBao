//
//  JXWuKaPayViewController.h
//  JingXuan
//
//  Created by rongfeng on 16/6/2.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXWuKaPayViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, copy) NSString *recodeOne;
@property (nonatomic, copy) NSString *recodeTwo;
@property (nonatomic, copy) NSString *recodeThire;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) NSInteger tag;
@end
