//

//  UIComboBox.h

//  UICommboBoxDemo

//

//  Created by luoge on 11-8-10.

//  Copyright 2011年 __MyCompanyName__. All rights reserved.

//

#import <UIKit/UIKit.h>

typedef enum
{    
    UIComboBoxBtnActionType_ClearInput = 0,    
    UIComboBoxBtnActionType_DropDown,    
    UIComboBoxBtnActionType_Reset    
}UIComboBoxBtnActionType;

@class UIComboBox;
@protocol UIComboBoxDelegate
- (void)comboBoxChange:(UIComboBox*)comboBox;
@end
@interface UIComboBox : UIView
<UITableViewDelegate,UITableViewDataSource>
{    
    CGRect              originFrame;            //原始frame    
    UITextField         *_inputTextField;       //接受用户输入部分
    UIButton            *_actionButton;         //操作按钮 删除输入|下拉显示|关闭下拉
    
    UIComboBoxBtnActionType btnActionType;      //操作类型
    BOOL                bShowHistoryTable;      //显示历史记录
    NSMutableArray      *_historyArray;         //历史记录    
    UITableView         *_historyTableView;     //历史选择
    NSObject<UIComboBoxDelegate> *delegate;
    
}

@property (assign) NSObject<UIComboBoxDelegate> *delegate;
@property (copy, nonatomic) NSString            *text;
@property (nonatomic, retain) NSMutableArray        *historyArray;
@property (assign) UITextField *inputTextField;

- (void) addHistory:(NSString *) strInput;
- (void)setInput:(BOOL)canInput;
- (void) setTip:(NSString *)tip;
- (void)setHint:(NSString*)hint;
- (void) hiddenTableView;

@end
