//
//  MyDotField.h
//  CustTextField
//
//  Created by yangmx on 13-4-20.
//  Copyright (c) 2013年 Ymx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZenKeyboardView.h"

@interface MyDotField : UITextField<ZenKeyboardViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) ZenKeyboardView *keyboardView;
@end
