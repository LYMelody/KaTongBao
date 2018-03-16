//
//  AuthPhotoVC.m
//  wujieNew
//
//  Created by rongfeng on 15/12/23.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "AuthPhotoVC.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
#import "TDViewsCell.h"
#import "CertifyCell.h"

@implementation AuthPhotoVC {
    
    UIImageView *FootView;
    UITableView *table;
    NSInteger imgtag;
    UIImageView *PhotoImgOne;
    UIImageView *PhotoImgTwo;
    UIImageView *PhotoImgThird;
    UIImageView *PhotoImgFour;
    BOOL IsFirst;
    BOOL IsSecond;
    BOOL IsThird;
    BOOL IsFour;
    UIButton *deliverBtn;
}

- (void)viewDidLoad {
    
    self.title = @"信息审核";
    self.view.backgroundColor = [UIColor whiteColor];
    
    IsFirst = NO;
    IsSecond = NO;
    IsThird = NO;
    IsFour = NO;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight + 50) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.showsVerticalScrollIndicator = NO;
    
    //尾视图
    FootView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 426.5)];
    FootView.backgroundColor = LightGrayColor;
    FootView.userInteractionEnabled = YES;
    //相片
//    [self AddImgWithWidth:16 height:15];
//    [self AddImgWithWidth:165 height:15];
//    [self AddImgWithWidth:16 height:140.5];
//    [self AddImgWithWidth:165 height:140.5];
//    [self addLabelWithWidth:16 height:110.5 msg:@"身份证正面范例"];
//    [self addLabelWithWidth:165 height:110.5 msg:@"身份证反面范例"];
//    [self addLabelWithWidth:16 height:236 msg:@"银行卡正面范例"];
//    [self addLabelWithWidth:165 height:236 msg:@"银行卡反面范例"];
    UITapGestureRecognizer *TakePhotoGrOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TakePhoto:)];
    TakePhotoGrOne.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TakePhotoGrTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TakePhoto:)];
    TakePhotoGrOne.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TakePhotoGrThird = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TakePhoto:)];
    TakePhotoGrOne.numberOfTapsRequired = 1;
    UITapGestureRecognizer *TakePhotoGrFour = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TakePhoto:)];
    TakePhotoGrOne.numberOfTapsRequired = 1;
    
    PhotoImgOne = [[UIImageView alloc] init];
    PhotoImgOne.userInteractionEnabled = YES;
    PhotoImgOne.backgroundColor = [UIColor whiteColor];
    PhotoImgOne.tag = 1001;
    [PhotoImgOne addGestureRecognizer:TakePhotoGrOne];
    [FootView addSubview:PhotoImgOne];
    PhotoImgOne.sd_layout.leftSpaceToView(FootView,16).topSpaceToView(FootView,15).widthIs(139).heightIs(86.5);
    
    PhotoImgTwo = [[UIImageView alloc] init];
    PhotoImgTwo.userInteractionEnabled = YES;
    PhotoImgTwo.backgroundColor = [UIColor whiteColor];
    PhotoImgTwo.tag = 1002;
    [PhotoImgTwo addGestureRecognizer:TakePhotoGrTwo];
    [FootView addSubview:PhotoImgTwo];
    PhotoImgTwo.sd_layout.leftSpaceToView(FootView,165).topSpaceToView(FootView,15).widthIs(139).heightIs(86.5);
    
    PhotoImgThird = [[UIImageView alloc] init];
    PhotoImgThird.userInteractionEnabled = YES;
    PhotoImgThird.backgroundColor = [UIColor whiteColor];
    PhotoImgThird.tag = 1003;
    [PhotoImgThird addGestureRecognizer:TakePhotoGrThird];
    [FootView addSubview:PhotoImgThird];
    PhotoImgThird.sd_layout.leftSpaceToView(FootView,16).topSpaceToView(FootView,140.5).widthIs(139).heightIs(86.5);
    
    PhotoImgFour = [[UIImageView alloc] init];
    PhotoImgFour.userInteractionEnabled = YES;
    PhotoImgFour.backgroundColor = [UIColor whiteColor];
    PhotoImgFour.tag = 1004;
    [PhotoImgFour addGestureRecognizer:TakePhotoGrFour];
    [FootView addSubview:PhotoImgFour];
    PhotoImgFour.sd_layout.leftSpaceToView(FootView,165).topSpaceToView(FootView,140.5).widthIs(139).heightIs(86.5);

    UILabel *LabelOne = [[UILabel alloc] init];
    LabelOne.text = @"身份证正面范例";
    LabelOne.font = [UIFont systemFontOfSize:15];
    LabelOne.textAlignment = NSTextAlignmentCenter;
    [FootView addSubview:LabelOne];
    LabelOne.sd_layout.leftSpaceToView(FootView,16).topSpaceToView(FootView,110.5).widthIs(139).heightIs(21);
    
    UILabel *LabelTwo = [[UILabel alloc] init];
    LabelTwo.text = @"身份证反面范例";
    LabelTwo.font = [UIFont systemFontOfSize:15];
    LabelTwo.textAlignment = NSTextAlignmentCenter;
    [FootView addSubview:LabelTwo];
    LabelTwo.sd_layout.leftSpaceToView(FootView,165).topSpaceToView(FootView,110.5).widthIs(139).heightIs(21);
    
    UILabel *LabelThird = [[UILabel alloc] init];
    LabelThird.text = @"银行卡正面范例";
    LabelThird.font = [UIFont systemFontOfSize:15];
    LabelThird.textAlignment = NSTextAlignmentCenter;
    [FootView addSubview:LabelThird];
    LabelThird.sd_layout.leftSpaceToView(FootView,16).topSpaceToView(FootView,236).widthIs(139).heightIs(21);
    
    UILabel *LabelFour = [[UILabel alloc] init];
    LabelFour.text = @"银行卡反面范例";
    LabelFour.font = [UIFont systemFontOfSize:15];
    LabelFour.textAlignment = NSTextAlignmentCenter;
    [FootView addSubview:LabelFour];
    LabelFour.sd_layout.leftSpaceToView(FootView,165).topSpaceToView(FootView,236).widthIs(139).heightIs(21);
    //推荐人手机
    UILabel *leftLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 38)];
    leftLab.text = @"推荐人手机号";
    //leftLab.textColor = Color(100, 100, 100);
    leftLab.font = [UIFont systemFontOfSize:16];
    leftLab.backgroundColor = [UIColor whiteColor];
    leftLab.textAlignment = NSTextAlignmentCenter;
    UITextField *BankFld = [[UITextField alloc] init];
    BankFld.backgroundColor = [UIColor whiteColor];
    BankFld.delegate = self;
    BankFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    BankFld.leftViewMode = UITextFieldViewModeAlways;
    BankFld.placeholder = @"输入手机号";
    BankFld.leftView = leftLab;
    BankFld.layer.cornerRadius = 3;
    BankFld.font = [UIFont systemFontOfSize:15];
    BankFld.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    BankFld.keyboardType = UIKeyboardTypeNumberPad;
    [FootView addSubview:BankFld];
    BankFld.sd_layout.leftSpaceToView(FootView,16).topSpaceToView(FootView,281).rightSpaceToView(FootView,16).heightIs(38);
    //提交审核
    deliverBtn = [[UIButton alloc] init];
    [deliverBtn setTitle:@"提交审核信息" forState:UIControlStateNormal];
    deliverBtn.backgroundColor = RedColor;
    deliverBtn.layer.cornerRadius = 3;
    deliverBtn.layer.masksToBounds = YES;
    [deliverBtn addTarget:self action:@selector(deliver) forControlEvents:UIControlEventTouchUpInside];
    [FootView addSubview:deliverBtn];
    deliverBtn.sd_layout.leftSpaceToView(FootView,16).topSpaceToView(FootView,369).widthIs(288).heightIs(44);
    
    table.tableFooterView = FootView;
    [self.view addSubview:table];
}
//
- (void)TakePhoto:(UITapGestureRecognizer *)sender {
    UIImageView *ImgView = (UIImageView *)[sender view];
    imgtag = ImgView.tag;
    NSLog(@"%d",imgtag);
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:picker animated:YES];
        
    }else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头" delegate:nil cancelButtonTitle:@"知道" otherButtonTitles:nil];
        [alert show];
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //    image = [self imageWithImage:image scaledToSize:imagesize];
    
    [self dismissModalViewControllerAnimated:YES];
    switch (imgtag) {
            
        case 1001:
            [PhotoImgOne setImage:image];
            IsFirst = YES;
            break;
        case 1002:
            [PhotoImgTwo setImage:image];
            IsSecond = YES;
            break;
        case 1003:
            [PhotoImgThird setImage:image];
            IsThird = YES;
            break;
        case 1004:
            [PhotoImgFour setImage:image];
            IsFour = YES;
            break;
        default:
            break;
    }
    if (IsFirst&&IsSecond&&IsThird&&IsFour) {
        deliverBtn.enabled = YES;
    }

    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    table.contentOffset = CGPointMake(0, 230);
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    table.contentOffset = CGPointMake(0, 120);
}
//提交
- (void)deliver {
    
    NSLog(@"*******");
    
}
////四张图片
//- (UIImageView *)AddImgWithWidth:(CGFloat)width height:(CGFloat)height{
//    
//    UIImageView *PhotoImgOne = [[UIImageView alloc] init];
//    PhotoImgOne.userInteractionEnabled = YES;
//    PhotoImgOne.backgroundColor = [UIColor whiteColor];
//    [FootView addSubview:PhotoImgOne];
//    PhotoImgOne.sd_layout.leftSpaceToView(FootView,width).topSpaceToView(FootView,height).widthIs(139).heightIs(86.5);
//    return PhotoImgOne;
//}
////图片label
//- (UILabel *)addLabelWithWidth:(CGFloat)width height:(CGFloat)height msg:(NSString *)msg {
//    UILabel *LabelOne = [[UILabel alloc] init];
//    LabelOne.text = msg;
//    LabelOne.font = [UIFont systemFontOfSize:15];
//    LabelOne.textAlignment = NSTextAlignmentCenter;
//    [FootView addSubview:LabelOne];
//    LabelOne.sd_layout.leftSpaceToView(FootView,width).topSpaceToView(FootView,height).widthIs(139).heightIs(21);
//    return LabelOne;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 15;
    }
    if (indexPath.row == 6) {
        return 0;
    }else {
        return 45;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            TDViewsCell *Cell = [[TDViewsCell alloc] init];
            cell = Cell;
        }
        if (indexPath.row == 1) {
            
            CertifyCell *Cell = [[CertifyCell alloc] init];
            Cell.Llabel.text = @"商户姓名";
            Cell.Fld.placeholder = @"请输入真实姓名";
            cell = Cell;
        }
        if (indexPath.row == 2) {
            CertifyCell *Cell = [[CertifyCell alloc] init];
            Cell.Llabel.text = @"身份证";
            Cell.Fld.placeholder = @"请输入身份证号";
            cell = Cell;
        }
        if (indexPath.row == 3) {
            CertifyCell *Cell = [[CertifyCell alloc] init];
            Cell.Llabel.text = @"收款借记卡号";
            Cell.Fld.placeholder = @"请输入借记卡号";
            cell = Cell;
        }
        if (indexPath.row == 3) {
            CertifyCell *Cell = [[CertifyCell alloc] init];
            Cell.Llabel.text = @"收款借记卡号";
            Cell.Fld.placeholder = @"请输入借记卡号";
            cell = Cell;
        }
        if (indexPath.row == 4) {
            CertifyCell *Cell = [[CertifyCell alloc] init];
            Cell.Llabel.text = @"借记卡开户行";
            Cell.Fld.placeholder = @"请输入开户行";
            cell = Cell;
        }
        if (indexPath.row == 5) {
            CertifyCell *Cell = [[CertifyCell alloc] init];
            Cell.Llabel.text = @"商户地址";
            Cell.Fld.hidden = YES;
            cell = Cell;
        }
        if (indexPath.row == 6) {
            TDViewsCell *Cell = [[TDViewsCell alloc] init];
            cell = Cell;
        }
    }
    return cell;
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//    
//}
@end
