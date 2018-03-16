//
//  SendMegCell.m
//  wujie
//
//  Created by rongfeng on 15/11/20.
//  Copyright © 2015年 ND. All rights reserved.
//

#import "SendMegCell.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
#import "macro.h"
@implementation SendMegCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"验证码";
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        self.text = [[UITextField alloc] init];
        self.text.placeholder = @"短信验证码";
        self.text.keyboardType = UIKeyboardTypeNumberPad;
        self.text.font = [UIFont systemFontOfSize:13];
        self.text.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.text];
        _button = [[UIButton alloc] init];
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        [_button setTitle:@"免费获取" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.backgroundColor = NavBack;
        //_button.layer.cornerRadius = 3;
        [self.contentView addSubview:_button];
        
        self.reSendBtn = [[UIButton alloc] init];
        [self.reSendBtn setTitle:@"重新获取(120s)" forState:UIControlStateNormal];
        self.reSendBtn.backgroundColor = Gray179;
        //self.reSendBtn.layer.cornerRadius = 3;
        self.reSendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.reSendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.reSendBtn.hidden = YES;
        self.reSendBtn.enabled = NO;
        [self.contentView addSubview:self.reSendBtn];
        
        self.sendButton = [[UIButton alloc] init];
        self.sendButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.sendButton setTitle:@"免费获取" forState:UIControlStateNormal];
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sendButton.backgroundColor = NavBack;
        //self.sendButton.layer.cornerRadius = 3;
        self.sendButton.hidden = YES;
        [self.contentView addSubview:self.sendButton];
        
        label.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,13.5).widthIs(80).heightIs(20);
        self.text.sd_layout.leftSpaceToView(self.contentView,90).topSpaceToView(self.contentView,14.5).widthIs(100).heightIs(18.5);
        _button.sd_layout.rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).widthIs(97.5).heightIs(self.contentView.height);
        self.reSendBtn.sd_layout.rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).widthIs(97.5).heightIs(self.contentView.height);
        self.sendButton.sd_layout.rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).widthIs(97.5).heightIs(self.contentView.height);
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    

    // Configure the view for the selected state
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
    
    
}
@end
