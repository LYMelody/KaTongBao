//
//  TDAlertViewController.h
//  YiFuKa
//
//  Created by yanlinhong on 14-3-5.
//  Copyright (c) 2014年 TangDi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFFNumericKeyboard.h"
@protocol MyAlertViewPopupDelegate;
@interface TDAlertViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,AFFNumericKeyboardDelegate>{
    NSArray *contentArray;
    NSString *titleString;
    NSArray *SubArray;
    //NSMutableArray *MidArray;
    NSArray *LastArray;
    UIButton *doneInKeyboardButton;
    UITextField *SearchFld;
    UIButton *doneButton;
    UIView *view;
    int mTag;
}
@property (retain, nonatomic) IBOutlet UILabel *alertTitle;
@property (retain, nonatomic) IBOutlet UITableView *contentTable;
@property (retain, nonatomic) NSDictionary *dic;
@property (strong, nonatomic) NSMutableArray *MidArray;
@property (assign, nonatomic) id <MyAlertViewPopupDelegate>delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contentArray:(NSArray *)array titleStr:(NSString *)titleStr tag:(int)myTag;
@end

@protocol MyAlertViewPopupDelegate <NSObject>

-(void)tableViewSelect:(TDAlertViewController *)alertViewController tag:(int)myTag selectNum:(int )num;

@end
