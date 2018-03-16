//
//  ViewController.m
//  Calculator
//
//  Created by Mark Glagola on 5/14/12.
//  Copyright (c) 2012 Independent. All rights reserved.
//

#import "CalculatorView.h"
#import "CustomButton.h"

@interface CalculatorView ()
{
	CustomButton *button1;
	CustomButton *button2;
	CustomButton *button3;
	CustomButton *button4;
	CustomButton *button5;
	CustomButton *button6;
	CustomButton *button7;
	CustomButton *button8;
	CustomButton *button9;
	CustomButton *button0;
	CustomButton *buttonPoint;
	CustomButton *buttonSignal;    
	
	CustomButton *buttonPlus;
	CustomButton *buttonMinus;
	CustomButton *buttonDivide;
	CustomButton *buttonMultiply;
	CustomButton *buttonClear;
	CustomButton *buttonEquals;
	CustomButton *buttonBackKey;
	
    
	NSMutableArray *buttons;
}

@end

@implementation CalculatorView
@synthesize mainLabelText;

-(void)initCalView{
    self.mainLabelText = @"";
    //self.backgroundColor = [UIColor grayColor];
    
	//background
	UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bg_calc.png"]];
	self.backgroundColor = background;
	[background release];
	
	CGFloat height=50;
	CGFloat width=80;
	CGFloat col1=0;
	CGFloat row1=60;
	CGFloat row0=5;
	
	CGFloat spacingy=3;
	CGFloat row2=row1+height+spacingy;
	CGFloat row3=row2+height+spacingy;
	CGFloat row4=row3+height+spacingy;
	CGFloat spacingx=0;
	CGFloat col2=col1+width+spacingx;
	CGFloat col3=col2+width+spacingx;
	CGFloat col4=col3+width+spacingx;
	
	
	button7 = [[[CustomButton alloc] initWithText:@"7" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button7.frame = CGRectMake(col1,row1, width, height);
	button8 = [[[CustomButton alloc] initWithText:@"8" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button8.frame = CGRectMake(col2,row1, width, height);
	button9 = [[[CustomButton alloc] initWithText:@"9" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button9.frame = CGRectMake(col3,row1, width, height);
	button4 = [[[CustomButton alloc] initWithText:@"4" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button4.frame = CGRectMake(col1,row2, width, height);
	button5 = [[[CustomButton alloc] initWithText:@"5" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button5.frame = CGRectMake(col2,row2, width, height);
	button6 = [[[CustomButton alloc] initWithText:@"6" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button6.frame = CGRectMake(col3,row2, width, height);
	button1 = [[[CustomButton alloc] initWithText:@"1" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button1.frame = CGRectMake(col1,row3, width, height);
	button2 = [[[CustomButton alloc] initWithText:@"2" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button2.frame = CGRectMake(col2,row3, width, height);
	button3 = [[[CustomButton alloc] initWithText:@"3" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button3.frame = CGRectMake(col3,row3, width, height);
	button0 = [[[CustomButton alloc] initWithText:@"0" target:self selector:@selector(numberButtonPressed:)] autorelease];
	button0.frame = CGRectMake(col1,row4, width, height);
    buttonSignal = [[[CustomButton alloc] initWithText:@"±" target:self selector:@selector(signalPressed:)] autorelease];
	buttonSignal.frame = CGRectMake(col2,row4, width, height);
	buttonPoint = [[[CustomButton alloc] initWithText:@"." target:self selector:@selector(decimalPressed:)] autorelease];
	buttonPoint.frame = CGRectMake(col3,row4, width, height);
    
	buttonEquals = [[[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(equalsPressed:) hue:0.075f saturation:0.9f brightness:0.96f] autorelease];
	buttonEquals.frame = CGRectMake(col4,row3, width, height*2);
    
	buttonPlus = [[[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(operandPressed:) hue:0.058f saturation:0.26f brightness:0.42f] autorelease];
	buttonPlus.frame = CGRectMake(col4,row2, width, height);
	buttonMinus = [[[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(operandPressed:) hue:0.058f saturation:0.26f brightness:0.42f] autorelease];
	buttonMinus.frame = CGRectMake(col4,row1, width, height);
	buttonMultiply = [[[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(operandPressed:) hue:0.058f saturation:0.26f brightness:0.42f] autorelease];
	buttonMultiply.frame = CGRectMake(col4,row0, width, height);
    
	buttonDivide = [[[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(operandPressed:) hue:0.058f saturation:0.26f brightness:0.42f] autorelease];
	buttonDivide.frame = CGRectMake(col3,row0, width, height);
	buttonBackKey = [[[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(backPressed:) hue:0.058f saturation:0.26f brightness:0.42f] autorelease];
	buttonBackKey.frame = CGRectMake(col2,row0, width, height);
	buttonClear = [[[CustomButton alloc] initWithTextAndHSB:@"" target:self selector:@selector(clearPressed:) hue:0.058f saturation:0.26f brightness:0.42f] autorelease];
	buttonClear.frame = CGRectMake(col1,row0, width, height);
    
	[buttonClear setLabelWithText:@"C" andSize:18.0f andVerticalShift:0.0f];
	[buttonMinus setLabelWithText:@"−" andSize:24.0f andVerticalShift:-2.0f];
	[buttonMultiply setLabelWithText:@"×" andSize:24.0f andVerticalShift:-2.0f];
	[buttonPlus setLabelWithText:@"+" andSize:24.0f andVerticalShift:-2.0f];
	[buttonDivide setLabelWithText:@"÷" andSize:24.0f andVerticalShift:-2.0f];
	[buttonBackKey setLabelWithText:@"◄" andSize:24.0f andVerticalShift:-2.0f];
    
	[buttonEquals setLabelWithText:@"=" andSize:24.0f andVerticalShift:22.0f];
    
	buttonPlus.toggled=YES;
	
	buttons = [NSMutableArray arrayWithObjects:
                    button1,
                    button2,
                    button3,
					button4,
					button5,
					button6,
					button7,
					button8,
					button9,
					button0,
                    buttonSignal,
					buttonPoint,
					buttonPlus,
					buttonEquals,
					buttonMinus,
					buttonMultiply,
					buttonClear,
					buttonBackKey,
					buttonDivide,
					
                    
                    nil];
	 
    
    for (CustomButton *button in buttons) {
        [self addSubview:button];
    }
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
		[self initCalView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		[self initCalView];
	}
	return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) 
    {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    else 
    {
        return YES;
    }
}

- (IBAction)clearPressed:(id)sender
{
    lastKnownValue = 0;
    self.mainLabelText = @"";
    isMainLabelTextTemporary = NO;
    operand = @"";
    [self.delegate valueChanged:self.mainLabelText];
}

- (BOOL)doesStringContainDecimal:(NSString*) string
{
    NSString *searchForDecimal = @".";
    NSRange range = [self.mainLabelText rangeOfString:searchForDecimal];
    
    //If we find a decimal return YES. Otherwise, NO
    if (range.location != NSNotFound)
        return YES;
    return NO;
}

- (IBAction)numberButtonPressed:(id)sender
{
    //Resets label after calculations are shown from previous operations
    if (isMainLabelTextTemporary)
    {
        self.mainLabelText = @"0";
        isMainLabelTextTemporary = NO;
    }
    
    //Get the string from the button label and main label
    NSString *numString = ((CustomButton*)sender).label.text;
    NSString *mainLabelString = self.mainLabelText;

    //If mainLabel = 0 and does not contain a decimal then remove the 0
    if ([mainLabelString doubleValue] == 0 && [self doesStringContainDecimal:mainLabelString] == NO)
        mainLabelString = @"";
        
    //Combine the two strings together
    self.mainLabelText = [mainLabelString stringByAppendingString:numString];
    [self.delegate valueChanged:self.mainLabelText];
}

- (IBAction)decimalPressed:(id)sender
{
    //Only add a decimal if the string doesnt already contain one.
    if ([self doesStringContainDecimal:self.mainLabelText] == NO) 
        self.mainLabelText = [self.mainLabelText stringByAppendingFormat:@"."];
    [self.delegate valueChanged:self.mainLabelText];
}

- (IBAction)signalPressed:(id)sender
{
    double currentValue = -[self.mainLabelText doubleValue];
    self.mainLabelText = [NSString stringWithFormat:@"%g",currentValue];

    [self.delegate valueChanged:self.mainLabelText];
}

- (IBAction)backPressed:(id)sender
{
    if (self.mainLabelText.length > 0) {
        self.mainLabelText = [self.mainLabelText substringToIndex:self.mainLabelText.length-1];
    }
    [self.delegate valueChanged:self.mainLabelText];
}

- (void)calculate
{
    //Get the current value on screen
    double currentValue = [self.mainLabelText doubleValue];
    
    // If we already have a value stored and the current # is not 0 , add/subt/mult/divide the values
    if (currentValue != 0)
    {
        if ([operand isEqualToString:@"+"])
            lastKnownValue += currentValue;
        else if ([operand isEqualToString:@"−"])
            lastKnownValue -= currentValue;
        else if ([operand isEqualToString:@"×"])
            lastKnownValue *= currentValue;
        else if ([operand isEqualToString:@"÷"])
        {
            //You can't divide by 0! 
            if (currentValue == 0)
                [self clearPressed:nil];
            else
                lastKnownValue /= currentValue;
        }
        else{
            lastKnownValue = currentValue;
            [(UITextField*)self.delegate resignFirstResponder];
        }
    }
    else
        lastKnownValue = currentValue;
    
    //Set the new value to the main label 
    self.mainLabelText = [NSString stringWithFormat:@"%g",lastKnownValue];
    [self.delegate valueChanged:self.mainLabelText];
        
    //Make the main label text temp, so we can erase when the next value is entered 
    isMainLabelTextTemporary = YES;
}

- (IBAction)operandPressed:(id)sender
{
    //Calculate from previous operand
    [self calculate];
    
    //Get the NEW operand from the button pressed
    operand= ((CustomButton*)sender).label.text;
}

- (IBAction)equalsPressed:(id)sender
{
    [self calculate];
    
    //reset operand;
    operand = @"";
}

@end
