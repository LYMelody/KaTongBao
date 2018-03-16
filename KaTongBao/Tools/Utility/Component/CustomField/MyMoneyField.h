//
//  MyMoneyField.h
//  CustTextField
//
//  Created by yangmx on 13-4-20.
//  Copyright (c) 2013年 Ymx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorView.h"

@interface MyMoneyField : UITextField<CalculatorViewDelegate, UITextFieldDelegate>

- (void)valueChanged:(NSString *)value;
@end
