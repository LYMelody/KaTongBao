//
//  ModificationPswView.m
//  JingXuan
//
//  Created by wj on 16/5/17.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "ModificationPswView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
@implementation ModificationPswView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    return self;
}
- (void)init_UI {
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    backView.layer.borderWidth = 0.5;
    [self addSubview:backView];
    backView.sd_layout.topSpaceToView(self,20).leftSpaceToView(self,0).widthIs(KscreenWidth).heightIs(180);
    
    UILabel *primevalPswLabel = [[UILabel alloc] init];
    primevalPswLabel.text = @"原登录密码：";
    [backView addSubview:primevalPswLabel];
    primevalPswLabel.sd_layout.topSpaceToView(backView,10).leftSpaceToView(backView,10).widthIs(120).heightIs(40);
    
    _primevalPswTF = [[UITextField alloc] init];
    _primevalPswTF.placeholder = @"请输入原始登录密码";
    [backView addSubview:_primevalPswTF];
    _primevalPswTF.sd_layout.topSpaceToView(backView,10).leftSpaceToView(primevalPswLabel,0).widthIs(200).heightIs(40);
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view];
    view.sd_layout.topSpaceToView(primevalPswLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(0.5);
    
    UILabel*_newPswLabel = [[UILabel alloc] init];
    _newPswLabel.text = @"新登录密码：";
    [backView addSubview:_newPswLabel];
    _newPswLabel.sd_layout.topSpaceToView(primevalPswLabel,20).leftSpaceToView(backView,10).widthIs(120).heightIs(40);
    
    _passTF = [[UITextField alloc] init];
    _passTF.placeholder = @"请输入新登录密码";
    [backView addSubview:_passTF];
    _passTF.sd_layout.topSpaceToView(_primevalPswTF,20).leftSpaceToView(_newPswLabel,0).widthIs(180).heightIs(40);
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:view1];
    view1.sd_layout.topSpaceToView(_newPswLabel,10).leftSpaceToView(self,0).rightSpaceToView(self,0).widthIs(KscreenWidth).heightIs(0.5);
    
    UILabel *pswLabel = [[UILabel alloc] init];
    pswLabel.text = @"新登录密码：";
    [backView addSubview:pswLabel];
    pswLabel.sd_layout.topSpaceToView(_newPswLabel,20).leftSpaceToView(backView,10).widthIs(120).heightIs(40);
    
    _conPassTF = [[UITextField alloc] init];
    _conPassTF.placeholder = @"请在次输入新登录密码";
    [backView addSubview:_conPassTF];
    _conPassTF.sd_layout.topSpaceToView(_passTF,20).leftSpaceToView(pswLabel,0).widthIs(180).heightIs(40);
    
    UILabel *notarizePswLabel = [[UILabel alloc] init];
    notarizePswLabel.text = @"支付密码由长度为六位数字组成，不能为空格。";
    notarizePswLabel.font = [UIFont systemFontOfSize:14];
    notarizePswLabel.textColor = [UIColor lightGrayColor];
    [backView addSubview:notarizePswLabel];
    notarizePswLabel.sd_layout.topSpaceToView(pswLabel,20).leftSpaceToView(backView,20).widthIs(300).heightIs(40);
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmButton.backgroundColor = NavBack;
    _confirmButton.tintColor = [UIColor whiteColor];
    _confirmButton.clipsToBounds = YES;
    _confirmButton.layer.cornerRadius = 3;
    [_confirmButton setTitle:@"确认修改" forState:UIControlStateNormal];
//    [_confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmButton];
    _confirmButton.sd_layout.bottomSpaceToView(self,140).leftSpaceToView(self,20).widthIs(KscreenWidth-40).heightRatioToView(self,0.09);
    
    
}
//- (void)confirmClick:(UIButton *)sender {
//    NSLog(@"---%@---%@---%@",_primevalPswTF.text,_passTF.text,_conPassTF.text);
//    if (self.ModificationPswBlcok == NULL) { //后面使用block之前要先做判空处理
//        NSLog(@"--空--");
//        return;
//    }else {
//        self.ModificationPswBlcok(_primevalPswTF.text,_passTF.text,_conPassTF.text);
//    }
//}
    
    
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
