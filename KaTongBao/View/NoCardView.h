//
//  NoCardView.h
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoCardView : UIView
@property (nonatomic, copy) NSString *recodeOne;
@property (nonatomic, copy) NSString *recodeTwo;
@property (nonatomic, copy) NSString *recodeThire;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) void(^block)(NSString *str);
@end
