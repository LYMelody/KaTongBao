//
//  TDAlertViewController.m
//  YiFuKa
//
//  Created by yanlinhong on 14-3-5.
//  Copyright (c) 2014年 TangDi. All rights reserved.
//

#import "TDAlertViewController.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
#import "AFFNumericKeyboard.h"
@interface TDAlertViewController ()

@end

@implementation TDAlertViewController
@synthesize contentTable;
@synthesize alertTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contentArray:(NSArray *)array titleStr:(NSString *)titleStr tag:(int)myTag
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        contentArray = [[NSArray alloc] initWithArray:array];
        //contentArray=array;
        titleString=titleStr;
        mTag=myTag;
        
        
        UIImageView *ImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索.png"]];
        ImageView.frame = CGRectMake(5, 0, 26, 26);
        
        //ImageView.backgroundColor = [UIColor redColor];
        SearchFld = [[UITextField alloc] initWithFrame:CGRectMake(10, 9, 222, 35)];
        SearchFld.leftView = ImageView;
        SearchFld.delegate = self;
        SearchFld.keyboardType = UIKeyboardTypeNumberPad;
        SearchFld.textAlignment = NSTextAlignmentLeft;
        SearchFld.placeholder = @"请输入卡号后四位检索银行卡";
        SearchFld.font = [UIFont systemFontOfSize:13];
        SearchFld.adjustsFontSizeToFitWidth = YES;
        SearchFld.borderStyle = UITextBorderStyleRoundedRect;
        //SearchFld.backgroundColor = LightGrayColor;
        //SearchFld.contentVerticalAlignment = UIControlContentHorizontalAlignmentLeft;
        SearchFld.leftViewMode = UITextFieldViewModeAlways;
        SearchFld.hidden = YES;
        ImageView.centerY = SearchFld.centerY;
        [self.view addSubview:SearchFld];
        
        AFFNumericKeyboard *keyboard = [[AFFNumericKeyboard alloc] initWithFrame:CGRectMake(0, 200, 320, 216)];
        //AFFNumericKeyboard *K = [AFFNumericKeyboard alloc] i
        //keyboard.Tag = 1;
        SearchFld.inputView = keyboard;
        keyboard.delegate = self;
        
        if (mTag == 3) {
            alertTitle.hidden = YES;
            SearchFld.hidden = NO;
        }else {
            alertTitle.hidden = NO;
            SearchFld.hidden = YES;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    alertTitle.text=titleString;
    contentTable.delegate=self;
    contentTable.dataSource=self;
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        [contentTable  setSeparatorInset:UIEdgeInsetsZero];

    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)FinishSelect {
    
    [self EnquirySubBank:SearchFld.text];
    [SearchFld resignFirstResponder];
    
}

-(void)numberKeyboardBackspace
{
    if (SearchFld.text.length != 0)
    {
        SearchFld.text = [SearchFld.text substringToIndex:SearchFld.text.length -1];
        [self EnquirySubBank:SearchFld.text];
    }
}

-(void)numberKeyboardInput:(NSInteger)number
{
    if (SearchFld.text.length >= 4) {
      
        
    }else {

        SearchFld.text = [SearchFld.text stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)number]];
        [self EnquirySubBank:SearchFld.text];
        
    }
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [SearchFld resignFirstResponder];
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = doneButton.frame;
        rect.origin.y += 53*5;
        doneButton.frame = rect;
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *CellIdentifier = [NSString stringWithFormat:@"cell- %ld",(long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (mTag == 3) {
            cell = [[UITableViewCell alloc] init];

        }else{
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell = [[UITableViewCell alloc] init];
        }
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    if (mTag != 3) {
        NSString *string=[contentArray objectAtIndex:indexPath.row];
        cell.textLabel.text =string;
    }
    if (mTag == 3) {
        LastArray = [[NSArray alloc] init];
        
        
        if (self.MidArray == nil) {
            LastArray = contentArray;
        }else {
            
            LastArray = self.MidArray;
            
        }
        NSInteger row = 0;
        if (LastArray.count >= 5) {
            row = 5 ;
        }else {
            row = LastArray.count ;
        }
        if (indexPath.row < row) {
            //cell.textLabel.text = [[contentArray objectAtIndex:indexPath.row] objectForKey:@"cardNo"];
            UILabel *bankLab = [[UILabel alloc] init];
            bankLab.font = [UIFont systemFontOfSize:14];
            bankLab.adjustsFontSizeToFitWidth = YES;
            bankLab.text = [[LastArray objectAtIndex:indexPath.row] objectForKey:@"bankName"];
            [cell.contentView addSubview:bankLab];
            bankLab.sd_layout.leftSpaceToView(cell.contentView,12.8).topSpaceToView(cell.contentView,14.4).widthIs(71).heightIs(18);
            
            UILabel *bankNumberLab = [[UILabel alloc] init];
            bankNumberLab.font = [UIFont systemFontOfSize:14];
            bankNumberLab.text = [self rePlaceString:[[LastArray objectAtIndex:indexPath.row] objectForKey:@"bankNo"]];
            bankNumberLab.adjustsFontSizeToFitWidth = YES;
            [cell.contentView addSubview:bankNumberLab];
            bankNumberLab.sd_layout.leftSpaceToView(bankLab,10).topSpaceToView(cell.contentView,14.4).rightSpaceToView(cell.contentView,12.8).heightIs(17.5);
        }else if (indexPath.row == row){
            
            UIImageView *AddImg = [[UIImageView alloc] init];
            AddImg.image = [UIImage imageNamed:@"Line + Line Copy 4.png"];
            [cell.contentView addSubview:AddImg];
            AddImg.sd_layout.leftSpaceToView(cell.contentView,10.5).topSpaceToView(cell.contentView,16.7).widthIs(23).heightIs(23);
            UILabel *AddLab = [[UILabel alloc] init];
            AddLab.text = @"添加其他银行卡";
            AddLab.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:AddLab];
            AddLab.sd_layout.leftSpaceToView(AddImg,20).topSpaceToView(cell.contentView,19).widthIs(116.5).heightIs(17.5);
        }

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@" 数组个数 :%lu",(long)contentArray.count);
    
    if (mTag == 3) {
        
        if (self.MidArray == nil) {
            if ([contentArray count] >= 5) {
                NSLog(@"数组大于5：%lu",(long)contentArray.count);
                return 5 + 1;
            }else {
                NSLog(@"数组小于5：%lu",(long)contentArray.count);
                return [contentArray count] + 1;
            }

        }else {
            NSLog(@"MidArray个数:%lu",(long)self.MidArray.count);
            return self.MidArray.count + 1;
        }
    }else {
        
        return [contentArray count];
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       if (self.delegate && [self.delegate respondsToSelector:@selector(tableViewSelect:tag:selectNum:)]) {
        [self.delegate tableViewSelect:self tag:mTag selectNum:indexPath.row];
    }
}

-(NSString*)rePlaceString:(NSString*)string{
    if (![string isKindOfClass:[NSString class]]) {
        return @"";
    }else{
        NSMutableString *mutString = [NSMutableString stringWithString:string];
        NSInteger length = [mutString length];
        if (length>=6) {
            [mutString replaceCharactersInRange:NSMakeRange(4, length-8) withString:@"********"];
        }else{
           
        }
        
        return (NSString*)mutString;
    }

}

#define mark - TextFiledDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.font = [UIFont systemFontOfSize:17];
    textField.placeholder = @"";
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.font = [UIFont systemFontOfSize:13];
    textField.placeholder = @"请输入卡号后四位检索银行卡";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    [self EnquirySubBank:textField.text];
    return YES;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.location >= 4) {
        return NO;
    }else {
        return YES;
    }
}

- (void)EnquirySubBank:(NSString *)str {
    
    self.MidArray = [[NSMutableArray alloc] init];
    NSString *Card = nil;
    NSString *LastFour = nil;
    for (NSInteger i = 0; i < [contentArray count]; i++) {
        Card = [contentArray[i] objectForKey:@"bankNo"];
        LastFour = [Card substringFromIndex:Card.length - 4];
        NSLog(@"后4位:%@",LastFour);
        if ([LastFour hasPrefix:str]) {
            [self.MidArray addObject:contentArray[i]];
        }else if ([str isEqualToString:@""]) {
            [self.MidArray addObject:contentArray[i]];
        }
    }
    
    [contentTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [alertTitle release];
    [contentTable release];
    
    [super dealloc];
}

- (void)viewDidUnload {
    [self setAlertTitle:nil];
    [self setContentTable:nil];
    [super viewDidUnload];
}
@end
