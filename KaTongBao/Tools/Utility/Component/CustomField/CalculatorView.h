//
//  ViewController.h
//  Calculator
//
//  Created by Mark Glagola on 5/14/12.
//  Copyright (c) 2012 Independent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CalculatorViewDelegate <NSObject>

- (void)valueChanged:(NSString *)value;

@end

@interface CalculatorView : UIView
{
    //Where all the calculations are shown
    NSString *mainLabelText;
    
    //Stores the last known value before an operand is pressed
    double lastKnownValue;
    
    NSString *operand;
    
    BOOL isMainLabelTextTemporary;
    
}
- (IBAction)clearPressed:(id)sender;
- (IBAction)numberButtonPressed:(id)sender;
- (IBAction)decimalPressed:(id)sender;
- (IBAction)operandPressed:(id)sender;
- (IBAction)equalsPressed:(id)sender;
- (IBAction)sinalPressed:(id)sender;

@property(nonatomic, assign) id<CalculatorViewDelegate> delegate;
@property(nonatomic, copy) NSString *mainLabelText;
@end
