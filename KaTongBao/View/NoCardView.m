//
//  NoCardView.m
//  JingXuan
//
//  Created by wj on 16/5/12.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "NoCardView.h"
#import "UIView+SDAutoLayout.h"
#import "macro.h"
#import "ShortcutViewController.h"
@implementation NoCardView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self init_UI];
    }
    return self;
}
- (void)init_UI {
    
    UIView *backView = [[UIView alloc] init];
    backView.layer.borderWidth = 1;
    backView.clipsToBounds = YES;
    backView.layer.cornerRadius = 3;
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    backView.sd_layout.topSpaceToView(self,84).leftSpaceToView(self,20).widthIs(KscreenWidth - 40).heightIs(Cell-20);
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = @"金额";
    lable.font = [UIFont systemFontOfSize:19];
    [backView addSubview:lable];
    lable.sd_layout.topSpaceToView(backView,20).leftSpaceToView(backView,20).widthIs(40).heightIs(40);
    
    _textField = [[UITextField alloc] init];
    _textField.placeholder = @"填写金额";
    _textField.textAlignment = NSTextAlignmentRight;
    [backView addSubview:_textField];
    _textField.sd_layout.topSpaceToView(backView,20).leftSpaceToView(lable,20).widthIs(140).heightIs(40);
    
    UILabel *reminderLable = [[UILabel alloc] init];
    reminderLable.textColor = [UIColor grayColor];
    reminderLable.textAlignment = NSTextAlignmentLeft;
    reminderLable.lineBreakMode = NSLineBreakByWordWrapping;
    reminderLable.numberOfLines = 3;
    reminderLable.font = [UIFont systemFontOfSize:15];
    [self addSubview:reminderLable];
    reminderLable.sd_layout.topSpaceToView(backView,20).leftEqualToView(backView).widthIs(320).heightIs(80);
    reminderLable.center = self.center;
    NSMutableAttributedString *mutableAttString = [[NSMutableAttributedString alloc] initWithString:@"注:1:交易限额:单笔最低10元，最高500000元 \n     2:交易时间:2:00-24:00"];
    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(13, 3)];
    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(19, 7)];
    [mutableAttString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:51.0/255.0 green:149.0/255.0 blue:216.0/255.0 alpha:1] range:NSMakeRange(40, 10)];
    reminderLable.attributedText = mutableAttString;

    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"快捷收款" forState:UIControlStateNormal];
    [leftButton setBackgroundColor:[UIColor colorWithRed:0/255.0 green:102.0/255.0 blue:176.0/255.0 alpha:1]];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:19];
    leftButton.tag = 3000;
    leftButton.clipsToBounds = YES;
    leftButton.layer.cornerRadius = 3;
    [leftButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftButton];
    leftButton.sd_layout.topSpaceToView(reminderLable,80).leftSpaceToView(self,20).widthIs(KscreenWidth/2).heightRatioToView(self,0.1);
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"普通收款" forState:UIControlStateNormal];
    [rightButton setBackgroundColor:[UIColor colorWithRed:230/255.0 green:177.0/255.0 blue:104.0/255.0 alpha:1]];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:19];
    rightButton.tag = 2000;
    rightButton.clipsToBounds = YES;
    rightButton.layer.cornerRadius = 3;
    [rightButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightButton];
    rightButton.sd_layout.topSpaceToView(reminderLable,80).xIs(KscreenWidth/2).rightEqualToView(backView).heightRatioToView(self,0.1);
}
- (void)buttonClick:(UIButton *)sender {
    self.block(_textField.text);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
