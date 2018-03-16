//
//  ModificationPswView.h
//  JingXuan
//
//  Created by wj on 16/5/17.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModificationPswView : UIView

@property (nonatomic, strong) UITextField *primevalPswTF;
@property (nonatomic, strong) UITextField *passTF;
@property (nonatomic, strong) UITextField *conPassTF;
@property (nonatomic, strong) UIButton *confirmButton;
//@property (nonatomic, copy) void (^ModificationPswBlcok)(NSString *primevalPswTF, NSString *passTF, NSString *conPassTF);
@end
