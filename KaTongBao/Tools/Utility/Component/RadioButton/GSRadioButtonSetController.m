//
//  GSRadioButtonSetController.m
//  RadioButtonTest
//
//  Created by Simon Whitaker on 18/07/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import "GSRadioButtonSetController.h"

@interface GSRadioButtonSetController()
- (void)handleButtonTap:(id)sender;
@end

@implementation GSRadioButtonSetController

@synthesize buttons = _buttons;
@synthesize selectedIndex = _selectedIndex;
@synthesize delegate = _delegate;

#pragma mark - Object lifecycle

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.selectedIndex = NSNotFound;
    }
    return self;
}

- (void)dealloc
{
    // Remove this object as a target for events on self.buttons
    for (UIButton *button in self.buttons) 
    {
        [button removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];
    }
    [super dealloc];
}

#pragma mark - Custom accessors

- (void)setButtons:(NSArray *)buttons
{
    if (buttons != _buttons)
    {
        // Remove event handlers from old buttons (no-op if _buttons is nil)
        for (UIButton *button in _buttons) 
        {
            [button removeTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        }

        // Assign new buttons array
        _buttons = buttons;
        
        // Set event handlers on new buttons (no-op if _buttons is nil)
        for (UIButton *button in _buttons)
        {
            [button addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            [[button imageView] setContentMode: UIViewContentModeScaleAspectFit];
            [button setImage:[UIImage imageNamed:@"button-off.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"button-on.png"] forState:UIControlStateSelected];
            [button setImage:[UIImage imageNamed:@"button-select.png"] forState:UIControlStateHighlighted];
            button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (selectedIndex != _selectedIndex) 
    {
        _selectedIndex = selectedIndex;
        for (NSUInteger i = 0; i < [self.buttons count]; i++) 
        {
            UIButton *button = [self.buttons objectAtIndex:i];
            button.selected = i == selectedIndex;
            button.userInteractionEnabled = !button.selected;
        }
        if ([self.delegate respondsToSelector:@selector(radioButtonSetController:didSelectButtonAtIndex:)]) {
            [self.delegate radioButtonSetController:self
                             didSelectButtonAtIndex:self.selectedIndex];
        }
    }
}

#pragma mark - UI event handlers

- (void)handleButtonTap:(id)sender
{
    NSUInteger index = [self.buttons indexOfObject:sender];
    if (index != self.selectedIndex) {
        self.selectedIndex = index;
    
        for (UIButton *button in self.buttons) 
        {
            button.selected = button == sender;
        }
        
        if ([self.delegate respondsToSelector:@selector(radioButtonSetController:didSelectButtonAtIndex:)]) {
            [self.delegate radioButtonSetController:self
                             didSelectButtonAtIndex:self.selectedIndex];
        }
    }
}

@end
