//
//  JieSuanCell.m
//  wujieNew
//
//  Created by rongfeng on 16/1/6.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "JieSuanCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation JieSuanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.Typelab = [[UILabel alloc] init];
        self.Typelab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.Typelab];
        self.Typelab.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,8.5).widthIs(40).heightIs(17.5);
        self.TimeLab = [[UILabel alloc] init];
        self.TimeLab.textColor = TextColor;
        self.TimeLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.TimeLab];
        self.TimeLab.sd_layout.leftSpaceToView(self.contentView,16).bottomSpaceToView(self.contentView,7).widthIs(160).heightIs(17.5);
        self.CashLab = [[UILabel alloc] init];
        self.CashLab.font = [UIFont systemFontOfSize:14];
        self.CashLab.text = @"金额:";
        [self.contentView addSubview:self.CashLab];
        self.CashLab.sd_layout.rightSpaceToView(self.contentView,76).topSpaceToView(self.contentView,10.5).widthIs(42).heightIs(17.5);
        self.MoneyLab = [[UILabel alloc] init];
        self.MoneyLab.text = @"10.00元";
        self.MoneyLab.font = [UIFont systemFontOfSize:14];
        self.MoneyLab.textAlignment = NSTextAlignmentLeft;
        self.MoneyLab.textColor = [UIColor colorWithRed:227/255.0 green:49/255.0 blue:49/255.0 alpha:1];
        [self.contentView addSubview:self.MoneyLab];
        self.MoneyLab.sd_layout.leftSpaceToView(self.CashLab,10).topSpaceToView(self.contentView,10.5).widthIs(80).heightIs(17.5);
        self.StatusLab = [[UILabel alloc] init];
        self.StatusLab.text = @"状态:";
        self.StatusLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StatusLab];
        self.StatusLab.sd_layout.rightSpaceToView(self.contentView,76).bottomSpaceToView(self.contentView,7).widthIs(42).heightIs(17.5);
        self.StatusDetailLab = [[UILabel alloc] init];
        self.StatusDetailLab.text = @"支付成功";
        self.StatusDetailLab.font = [UIFont systemFontOfSize:14];
        self.StatusDetailLab.textColor = TextColor;
        self.StatusDetailLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.StatusDetailLab];
        self.StatusDetailLab.sd_layout.rightSpaceToView(self.contentView,16).bottomSpaceToView(self.contentView,7).widthIs(60).heightIs(17.5);
        self.Line = [[UIImageView alloc] init];
        self.Line.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.Line];
        self.Line.sd_layout.leftSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0.5).widthIs(KscreenWidth).heightIs(0.5);
        
}
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}
@end
