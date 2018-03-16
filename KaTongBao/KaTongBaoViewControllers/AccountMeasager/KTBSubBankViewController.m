//
//  KTBSubBankViewController.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/1.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBSubBankViewController.h"
#import "Common.h"
#import "macro.h"
#import "BusiIntf.h"
#import "UIView+SDAutoLayout.h"
@interface KTBSubBankViewController ()

@end

@implementation KTBSubBankViewController {
    NSMutableArray *SubArray;
    NSMutableArray *MidMutableArr;
    UITableView *SubBankTable;
    UITextField *QureText;
}

-(void)viewWillAppear:(BOOL)animated
{
    //不隐藏导航栏
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    //隐藏工具栏
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.navigationController.navigationBar.barTintColor = NavBack;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择支行";
    
    UIImageView *CheckImg = [[UIImageView alloc] init];
    CheckImg.backgroundColor = LightGrayColor;
    CheckImg.userInteractionEnabled = YES;
    [self.view addSubview:CheckImg];
    CheckImg.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,0).heightIs(80);
    
    QureText = [[UITextField alloc] init];
    QureText.placeholder = @"请输入支行名查询";
    QureText.textAlignment = NSTextAlignmentCenter;
    QureText.borderStyle = UITextBorderStyleRoundedRect;
    QureText.font = [UIFont systemFontOfSize:15];
    QureText.keyboardType = UIKeyboardTypeWebSearch;
    QureText.delegate = self;
    [CheckImg addSubview:QureText];
    QureText.sd_layout.leftSpaceToView(CheckImg,6).topSpaceToView(CheckImg,6).rightSpaceToView(CheckImg,6).heightIs(40);
    
    UILabel *TipsLab = [[UILabel alloc] init];
    TipsLab.text = @"不确定具体支行，可致电发卡行查询";
    TipsLab.font = [UIFont systemFontOfSize:15];
    TipsLab.textColor = [UIColor redColor];
    TipsLab.textAlignment = NSTextAlignmentLeft;
    [CheckImg addSubview:TipsLab];
    TipsLab.sd_layout.leftSpaceToView(CheckImg,6).topSpaceToView(QureText,0).rightSpaceToView(CheckImg,6).heightIs(30);
    
    SubBankTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, KscreenWidth, KscreenHeight - 64 - 80)];
    SubBankTable.delegate = self;
    SubBankTable.dataSource = self;
    [self.view addSubview:SubBankTable];
    
    UITapGestureRecognizer *TapHiddenKayBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HiddenKeyBoayd)];
    TapHiddenKayBoard.numberOfTouchesRequired = 1;
    TapHiddenKayBoard.cancelsTouchesInView = NO;
    [CheckImg addGestureRecognizer:TapHiddenKayBoard];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (MidMutableArr == nil ) {
//        if (self.SubBankArray.count > 0) {
//            return _SubBankArray.count;
//        }else {
//            return 1;
//        }
        return _SubBankArray.count;
    }else {
        return MidMutableArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        NSString *cityName = @"";
        if (MidMutableArr == nil ) {
            if (self.SubBankArray.count > 0) {
                cityName = [self.SubBankArray[indexPath.row] objectForKey:@"bankName"];
            }else {
                
            }
        }else {
            cityName = [MidMutableArr[indexPath.row] objectForKey:@"bankName"];
        }
        
        cell.textLabel.text = cityName;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (MidMutableArr == nil ) {
        [BusiIntf curPayOrder].SubBankName = [self.SubBankArray[indexPath.row] objectForKey:@"bankName"];
        [BusiIntf curPayOrder].BankCode = [self.SubBankArray[indexPath.row] objectForKey:@"bankCode"];
    }else {
        [BusiIntf curPayOrder].SubBankName = [MidMutableArr[indexPath.row] objectForKey:@"bankName"];
        [BusiIntf curPayOrder].BankCode = [MidMutableArr[indexPath.row] objectForKey:@"bankCode"];
    }
    
    if (self.tag == 2) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -3)] animated:YES];
    }
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:([self.navigationController.viewControllers count] -4)] animated:YES];
}

#define mark textFiledDeleage
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self EnquirySubBank:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self EnquirySubBank:textField.text];
    [textField resignFirstResponder];
    return YES;

}
#define  mark Enquiry
- (void)EnquirySubBank:(NSString *)str {
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",str];
    SubArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < _SubBankArray.count; i++) {
        NSDictionary *dic = [_SubBankArray[i] objectForKey:@"bankName"];
        [SubArray addObject:dic];
    }
    NSArray *MidArray = [SubArray filteredArrayUsingPredicate:pred];
    MidMutableArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < MidArray.count; i++) {
        for (NSInteger j = 0; j < _SubBankArray.count; j++) {
            if ([[_SubBankArray[j] objectForKey:@"bankName"] isEqualToString:[MidArray[i] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ) {
                [MidMutableArr addObject:_SubBankArray[j]];
            }
        }
    }
    if ([str isEqualToString:@""]) {
        MidMutableArr = nil;
        for (NSInteger i = 0; i < _SubBankArray.count; i++) {
            [MidMutableArr addObject:_SubBankArray[i]];
        }
    }
    [SubBankTable reloadData];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}
- (void)HiddenKeyBoayd {
    [QureText resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
/*

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
