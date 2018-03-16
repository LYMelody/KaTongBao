//
//  BasicCustomView.m
//  JingXuan
//
//  Created by wj on 16/5/18.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "BasicCustomView.h"
#import "macro.h"
#import "BusiIntf.h"
@implementation BasicCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    if (self) {
        
        [self initCheckView];
        
        [self initInformationView];
        
        [self initPhotoView];
        
        self.Sendbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.Sendbutton.frame = CGRectMake(10, (KscreenWidth/2-10)/16*9+40 + 260, KscreenWidth - 20, 50);
        [self.Sendbutton setTitle:@"下一步" forState:UIControlStateNormal];
        self.Sendbutton.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
        self.Sendbutton.userInteractionEnabled = YES;
        //self.Sendbutton.tag = self.tag - 100;
        [self.Sendbutton addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        self.Sendbutton.clipsToBounds = YES;
        self.Sendbutton.layer.cornerRadius = 3;
        [self addSubview:self.Sendbutton];
        
//        self.img = [[UIImageView alloc] initWithFrame:CGRectMake(10, (KscreenWidth/2-10)/16*9+40 + 260, KscreenWidth - 20, 50)];
//        self.img.backgroundColor = [UIColor clearColor];
//        self.img.userInteractionEnabled = YES;
//        [self addSubview:self.img];
//        
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnEvent:)];
//        
//        tap.numberOfTapsRequired =1;
//        [self.img addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)initCheckView {
    UIView *checkBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth, 100)];
    checkBGView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    checkBGView.userInteractionEnabled = YES;
    [self addSubview:checkBGView];
    
    self.checkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KscreenWidth-20, 50)];
//    NSString *shopStatus = nil;
//    if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"10"]) {
//        shopStatus = @"初始化";
//    } else if([[BusiIntf curPayOrder].shopStatus isEqualToString:@"11"]){
//        shopStatus = @"待审核";
//    }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"12"]) {
//        shopStatus = @"审核驳回";
//    }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"19"]) {
//        shopStatus = @"初审通过";
//    }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"20"]) {
//        shopStatus = @"审核通过";
//    }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"30"]) {
//        shopStatus = @"系统风控";
//    }else if ([[BusiIntf curPayOrder].shopStatus isEqualToString:@"99"]) {
//        shopStatus = @"停用删除";
//    }else {
//        
//    }
    self.checkLabel.numberOfLines = 0;
    if (![[BusiIntf curPayOrder].showMsg isEqualToString:@""]) {
        self.checkLabel.text = [BusiIntf curPayOrder].showMsg;
    }else {
        self.checkLabel.text = @"请填写您的个人信息";
    }
    
    self.checkLabel.textColor = [UIColor redColor];
    [checkBGView addSubview:self.checkLabel];
    
    self.informationLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, KscreenWidth-20, 50)];
    self.informationLab.text = @"账户信息";
    [checkBGView addSubview:self.informationLab];
    
}

- (void)initInformationView {
    
    self.informationBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, KscreenWidth, 100)];
    self.informationBGView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.informationBGView];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KscreenWidth/4-10, 50)];
    self.nameLabel.text = @"姓名";
    [self.informationBGView addSubview:self.nameLabel];
    
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(KscreenWidth/4, 0, KscreenWidth/4*3, 50)];
    self.nameTF.borderStyle = UITextBorderStyleNone;
    self.nameTF.placeholder = @"请输入姓名";
    [self.informationBGView addSubview:self.nameTF];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KscreenWidth, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.informationBGView addSubview:lineView];
    
    self.informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, KscreenWidth/4-10, 50)];
    self.informationLabel.text = @"身份证";
    [self.informationBGView addSubview:self.informationLabel];
    self.numberTF = [[UITextField alloc]initWithFrame:CGRectMake(KscreenWidth/4, 50, KscreenWidth/4*3, 50)];
    self.numberTF.placeholder = @"请输入身份证号";
    self.numberTF.borderStyle = UITextBorderStyleNone;
    [self.informationBGView addSubview:self.numberTF];
    
    self.photoLabelView = [[UIView alloc]initWithFrame:CGRectMake(0, 200, KscreenWidth, 50)];
    self.photoLabelView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self addSubview:self.photoLabelView];
    self.photoLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, KscreenWidth, 50)];
    self.photoLabel.text = @"身份证照片";
    [self.photoLabelView addSubview:self.photoLabel];
}

- (void) initPhotoView {
    self.photoView = [[UIView alloc]initWithFrame:CGRectMake(0, 250, KscreenWidth, (KscreenWidth/2-10)/16*9+40)];
    self.photoView.backgroundColor = [UIColor whiteColor];
    self.photoView.userInteractionEnabled = YES;
    [self addSubview:self.photoView];
    for (int i = 0; i < 2; i++) {
        self.choosePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.choosePhotoButton.frame = CGRectMake(10 + KscreenWidth/2 *i, 10, KscreenWidth/2-20, (KscreenWidth/2-10)/16*9);
        [self.choosePhotoButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.choosePhotoButton setBackgroundImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
//        [self.choosePhotoButton setImage:[UIImage imageNamed:@"点击上传.png"] forState:UIControlStateNormal];
        self.choosePhotoButton.tag = 9999 + i;
        [self.photoView addSubview:self.choosePhotoButton];
    }
    self.frontLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (KscreenWidth/2-10)/16*9 + 10, KscreenWidth/2, 30)];
    self.frontLabel.text = @"身份证正面照片";
    self.frontLabel.textAlignment = NSTextAlignmentCenter;
    [self.photoView addSubview:self.frontLabel];
    
    self.reverseSideLabel = [[UILabel alloc]initWithFrame:CGRectMake(KscreenWidth/2, (KscreenWidth/2-10)/16*9 + 10, KscreenWidth/2, 30)];
    self.reverseSideLabel.textAlignment = NSTextAlignmentCenter;
    self.reverseSideLabel.text = @"身份证反面照片";
    self.reverseSideLabel.numberOfLines = 0;
    [self.photoView addSubview:self.reverseSideLabel];
}

-(void)buttonClick:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnClickWith:)]) {
        [self.delegate btnClickWith:sender.tag];
        
    }
}

-(void)btnEvent:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(btnClick:)]) {
        [self.delegate btnClick:sender.tag];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endEditing:YES];
    [self.nameTF resignFirstResponder];
    [self.numberTF resignFirstResponder];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

