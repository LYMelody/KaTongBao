
//

//  UIComboBox.m

//  UICommboBoxDemo

//

//  Created by luoge on 11-8-10.

//  Copyright 2011年 __MyCompanyName__. All rights reserved.

//

#import "UIComboBox.h"
#import <QuartzCore/QuartzCore.h>

@interface UIComboBox(private)

- (void) initControl;

- (void) inputFieldValueChanged:(id) sender;

- (void) actionBtnPress:(id) sender;

- (void) showTableView;

- (void) hiddenTableView;

- (void)setText:(NSString *)Atext;

@end

@implementation UIComboBox

@synthesize delegate;
@synthesize text;

@synthesize historyArray = _historyArray;
@synthesize inputTextField = _inputTextField;

- (id)initWithFrame:(CGRect)frame
{    
    self = [super initWithFrame:frame];
    
    if (self) {        
        // Initialization code
        
        originFrame = frame;          
        _historyArray = [[NSMutableArray alloc] initWithCapacity:20];
        
        [self initControl];
        
        [self hiddenTableView];       
        
    }
    return self;
    
}

/*
 
 // Only override drawRect: if you perform custom drawing.
 
 // An empty implementation adversely affects performance during animation.
 
 - (void)drawRect:(CGRect)rect
 
 {
 
 // Drawing code
 
 }
 
 */

- (void)dealloc
{
    
    [_inputTextField release];    
    [_actionButton release];      
    [_historyArray release];
    [_historyTableView release];    
    [super dealloc];    
}

//

#pragma mark property

- (NSString *) text
{    
    return _inputTextField.text;    
}

- (void)setText:(NSString *)Atext
{
    _inputTextField.text = Atext;
}

#pragma mark action

- (void) addHistory:(NSString *)strInput
{    
    [_historyArray addObject:strInput];    
}

#pragma mark private

- (void) initControl
{    
    //input field
    
    CGRect textFrame = self.frame;
    
    textFrame.origin.x = 0;
    
    textFrame.origin.y = 0;
    
    textFrame.size.width = self.frame.size.width;
    
    //textFrame.size.height = self.frame.size.height - 10;
    
    _inputTextField = [[UITextField alloc] initWithFrame:textFrame];
    _inputTextField.enabled = NO;
    
    [_inputTextField addTarget:self action:@selector(inputFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    _inputTextField.backgroundColor = [UIColor whiteColor];
    _inputTextField.font = [UIFont systemFontOfSize:14];
    [self addSubview:_inputTextField];    
    
    _inputTextField.clipsToBounds = YES;
    _inputTextField.layer.cornerRadius = 3.0f;
    [_inputTextField.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    //[_inputTextField.layer setBorderColor: [[UIColor grayColor] CGColor]];
    //[_inputTextField.layer setBorderWidth: 1.0];
    
    //action button
    
    CGRect actionBtnFrame;
    
    actionBtnFrame = textFrame;
    actionBtnFrame.size.width -= 10;
    
    //actionBtnFrame.size.height = 40;
    
    //actionBtnFrame.origin.x = self.frame.size.width - 40;
    
    //actionBtnFrame.origin.y = (self.frame.size.height - 40) / 2;
    
    _actionButton = [[UIButton alloc] initWithFrame:actionBtnFrame];
    _actionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    _actionButton.backgroundColor = [UIColor clearColor];
    _actionButton.titleLabel.textColor = [UIColor grayColor];
    [_actionButton setTitle:@"▼" forState:UIControlStateNormal];
    _actionButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_actionButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [_actionButton addTarget:self action:@selector(actionBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_actionButton];
    [self bringSubviewToFront:_actionButton];
    [self sendSubviewToBack:_inputTextField];
        
    _historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.2, self.frame.size.width , 0)];
    
    _historyTableView.delegate = self;
    
    _historyTableView.dataSource = self;
    
    _historyTableView.backgroundColor = [UIColor grayColor];
    _historyTableView.layer.cornerRadius=5;
    _historyTableView.layer.borderWidth = 2.0;
    _historyTableView.layer.borderColor = [UIColor redColor].CGColor;
    
    
    [self addSubview:_historyTableView];
    
}

- (void)setInput:(BOOL)canInput
{
    _inputTextField.enabled = canInput;
    
    CGRect actionBtnFrame;
    actionBtnFrame = self.frame;
    if (!canInput)
    {
        actionBtnFrame.size.width -= 10;
    }
    else
    {
        actionBtnFrame.size.width = 50;
        actionBtnFrame.size.height = 40;
        actionBtnFrame.origin.x = self.frame.size.width - 60;
        actionBtnFrame.origin.y = (self.frame.size.height - 40) / 2;        
    }
    _actionButton.frame = actionBtnFrame;
    
}


- (void) setTip:(NSString *)tip
{
    if (_inputTextField.leftView)
        [_inputTextField.leftView release];
    UILabel *label =  [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20*[tip length], 40)];
    //label.backgroundColor = [UIColor clearColor];
    label.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    //label.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    label.textColor = [UIColor blackColor];
    //label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = tip;
    
    //修改tip大小
    //label.font = [UIFont systemFontOfSize:14];
    
    
    _inputTextField.leftViewMode = UITextFieldViewModeAlways;
    _inputTextField.leftView = label;
    
    //修改选择框外观
    //_inputTextField.font = [UIFont systemFontOfSize:14];
    //[_inputTextField.layer setBackgroundColor:[[UIColor clearColor] CGColor]];
    //[_inputTextField.layer setBackgroundColor:[[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0] CGColor]];
    [_inputTextField.layer setBackgroundColor:[[UIColor whiteColor] CGColor]];
    
#if (QDFLAG == 21 || QDFLAG == 20 || QDFLAG == 1)
    //V联修改
    [_inputTextField setBackground:[UIImage imageNamed:@"bg_login"]];
   
#endif
    //[_inputTextField.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [_inputTextField.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    //[_inputTextField.layer setBorderWidth: 1.0];
/*
#if (QDFLAG == 8)  //通行宝
    [_inputTextField setBackground:[UIImage imageNamed:@"banner-pay"]];
    [_inputTextField.layer setBackgroundColor: [[UIColor clearColor] CGColor]];
    [_inputTextField.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [_inputTextField setTextColor: [UIColor whiteColor] ];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
#endif
*/
#if (QDFLAG == 17)  //百荣
    [_inputTextField setBackground:[UIImage imageNamed:@"textImg"]];
    [_inputTextField.layer setBorderColor: [[UIColor grayColor] CGColor]];
    label.textColor = [UIColor blackColor];
#endif
    
#if (QDFLAG == 15)  //aibituo
    [_inputTextField.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [_inputTextField.layer setBorderColor: [[UIColor grayColor] CGColor]];
    [_inputTextField.layer setBorderWidth: 1.0];

#endif
    

}

- (void) setHint:(NSString *)hint
{
    _inputTextField.placeholder = hint;
}

- (void) inputFieldValueChanged:(id) sender
{    
    UITextField *textField = (UITextField *)sender;    
    if ([textField.text length] == 0)        
    {       // ->
        [_actionButton setTitle:@"▼" forState:UIControlStateNormal];
        
        btnActionType = UIComboBoxBtnActionType_DropDown;        
    }    
    else        
    {        
        [_actionButton setTitle:@"X" forState:UIControlStateNormal];
        
        btnActionType = UIComboBoxBtnActionType_ClearInput;
    }
    
}

- (void) actionBtnPress:(id) sender
{
    [self.superview endEditing:NO];
    switch (btnActionType) {
            
        case UIComboBoxBtnActionType_ClearInput:
            
            _inputTextField.text = @"";
            [self inputFieldValueChanged:_inputTextField];
            
            break;
            
            
            
        case UIComboBoxBtnActionType_DropDown:
            
            [self showTableView];
            break;
            
            
            
        case UIComboBoxBtnActionType_Reset:              
            [self hiddenTableView];
            
            break;
            
        default:
            
            break;
            
    }
    
}

- (void) showTableView
{    
    [_actionButton setTitle:@"▼" forState:UIControlStateNormal];  
    
    
    btnActionType = UIComboBoxBtnActionType_Reset;
    
    bShowHistoryTable = YES;
    
    CGRect tableFrame = _historyTableView.frame;
    
    //tableFrame.size.height = 300;
    tableFrame.size.height = 35.0 * _historyArray.count;
    if (self.frame.origin.y + tableFrame.origin.y + tableFrame.size.height > 460)
        tableFrame.size.height -= (self.frame.origin.y + tableFrame.origin.y + tableFrame.size.height - 460);
    
    _historyTableView.frame = tableFrame;
    
    CGRect frame = self.frame;
    
    frame.size.height = tableFrame.origin.y + tableFrame.size.height + 10;
    
    self.frame = frame;
    
    frame = _historyTableView.frame;
    frame.origin.x = _inputTextField.leftView.frame.size.width - 8;
    frame.size.width = self.frame.size.width - frame.origin.x + 1.6;
    _historyTableView.frame = frame;
    [_historyTableView reloadData];
    NSInteger indexSelect = -1;
    for (int i=0; i<_historyArray.count; i++) {
        if ([[_historyArray objectAtIndex:i] isEqualToString:self.text])
        {
            indexSelect = i;
            break;
        }
    }
    if (indexSelect >= 0)
    {
        [_historyTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexSelect inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
 
    [self.superview bringSubviewToFront:self];
    [_inputTextField.layer setBorderColor: [[UIColor orangeColor] CGColor]];
}

- (void) hiddenTableView
{    
    [_actionButton setTitle:@"▼" forState:UIControlStateNormal];  
    
    
    btnActionType = UIComboBoxBtnActionType_DropDown;
    
    bShowHistoryTable = NO;   
    
    
    CGRect tableFrame = _historyTableView.frame;
    
    tableFrame.size.height = 0;
    
    _historyTableView.frame = tableFrame;    
    
    
    self.frame = originFrame;
    [_inputTextField.layer setBorderColor: [[UIColor grayColor] CGColor]];
}

#pragma mark table view delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    if (bShowHistoryTable)        
    {        
        return [_historyArray count];        
    }     
    return 0;    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    NSString *strCell = @"comboBoxViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    
    if (nil == cell) {        
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell] autorelease];
        
        
//        UIView *bgColorView = [[UIView alloc] init];
//        [bgColorView setBackgroundColor:[UIColor whiteColor]];
//        bgColorView.layer.cornerRadius = 10;
//        [cell setSelectedBackgroundView:bgColorView];
//        [bgColorView release];
        
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.highlightedTextColor = [UIColor blueColor];
      
    }      
    
    cell.textLabel.text = [_historyArray objectAtIndex:[indexPath row]];
   
    CGRect cellFrame = [cell frame];
    cellFrame.origin = CGPointMake(0, 0);
    cellFrame.size.height = 35;
    cellFrame.size.width = tableView.frame.size.width;
    [cell setFrame:cellFrame];
    return cell;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    _inputTextField.text = [_historyArray objectAtIndex:[indexPath row]];
    _inputTextField.font = [UIFont systemFontOfSize:14];
    [self hiddenTableView];
    
    if (delegate)
        [delegate comboBoxChange:self];
}

@end