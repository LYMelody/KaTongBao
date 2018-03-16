//
//  OrderListCell.m
//  wujieNew
//
//  Created by rongfeng on 16/1/8.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "OrderListCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation OrderListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.TypeLab = [[UILabel alloc] init];
        self.TypeLab.font = [UIFont systemFontOfSize:14];
        self.TypeLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.TypeLab];
        self.TypeLab.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,9).widthIs(200).heightIs(20);
        self.TimeLab = [[UILabel alloc] init];
        self.TimeLab.font = [UIFont systemFontOfSize:14];
        self.TimeLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.TimeLab];
        self.TimeLab.sd_layout.rightSpaceToView(self.contentView,16).topSpaceToView(self.contentView,9).widthIs(200).heightIs(20);
        self.KindLab = [[UILabel alloc] init];
        self.KindLab.font = [UIFont systemFontOfSize:14];
        self.KindLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.KindLab];
        self.KindLab.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,30).widthIs(100).heightIs(20);
        self.MoneyLab = [[UILabel alloc] init];
        self.MoneyLab.font = [UIFont systemFontOfSize:14];
        self.MoneyLab.textAlignment  =NSTextAlignmentLeft;
        [self.contentView addSubview:self.MoneyLab];
        self.MoneyLab.sd_layout.leftSpaceToView(self.contentView,160).topSpaceToView(self.contentView,30).widthIs(50).heightIs(20);
        self.StatusLab = [[UILabel alloc] init];
        self.StatusLab.font = [UIFont systemFontOfSize:14];
        self.StatusLab.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.StatusLab];
        self.StatusLab.sd_layout.rightSpaceToView(self.contentView,20).topSpaceToView(self.contentView,30).widthIs(60).heightIs(20);
        self.Line = [[UIImageView alloc] init];
        self.Line.backgroundColor = Color(151, 151, 151);
        [self.contentView addSubview:self.Line];
        self.Line.sd_layout.leftSpaceToView(self.contentView,16).bottomSpaceToView(self.contentView,0.5).widthIs(KscreenWidth - 16).heightIs(1);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
