/* Copyright (c) 2011 Andrew Armstrong <phplasma at gmail dot com>
*
*
BufferedNavigationController extends UINavigationController to automatically queue up transitions between view controllers.

This prevents you receiving errors such as:
"Finishing up a navigation transition in an unexpected state. Navigation Bar subview tree might get corrupted."

This can happen if you try to pushViewController during an existing transition.

To use, simply add the provided files to your project and change your UINavigationController class to inherit from BufferedNavigationController in Interface Builder.

*/

#import <Foundation/Foundation.h>
#import <UIKit/UINavigationController.h>

@interface BufferedNavigationController : UINavigationController <UINavigationControllerDelegate>

- (void) pushCodeBlock:(void (^)())codeBlock;
- (void) runNextBlock;
-(void)popToViewController:(UIViewController*)rootViewController
    thenPushViewController:(UIViewController*)pushViewController;

@property (nonatomic, retain) NSMutableArray* stack;
@property (nonatomic, assign) bool transitioning;

@end