//
//  GSRadioButtonSetController.h
//  RadioButtonTest
//
//  Created by Simon Whitaker on 18/07/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GSRadioButtonSetControllerDelegate;

@interface GSRadioButtonSetController : NSObject

@property (nonatomic, assign) NSArray *buttons;
@property (nonatomic, assign) id<GSRadioButtonSetControllerDelegate> delegate;

@property (nonatomic) NSUInteger selectedIndex;

@end

@protocol GSRadioButtonSetControllerDelegate <NSObject>
- (void)radioButtonSetController:(GSRadioButtonSetController *)controller
          didSelectButtonAtIndex:(NSUInteger)selectedIndex;
@end