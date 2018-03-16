//
//  BaseViewController.h
//  ChunYa
//
//  Created by JIAN WEI ZHANG on 16/3/23.
//  Copyright © 2016年 JIAN WEI ZHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
-(void)setBaseVCAttributes:(NSString *)title
              withLeftName:(NSString *)leftName
             withRightName:(NSString *)rightName
                 withColor:(UIColor *)color;
-(void)leftEvent:(UIButton *)sender;
-(void)rightButton:(UIButton *)sender;
@end
