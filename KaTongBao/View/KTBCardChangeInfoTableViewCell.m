//
//  KTBCardChangeInfoTableViewCell.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/2.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "KTBCardChangeInfoTableViewCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation KTBCardChangeInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.TimeLab = [[UILabel alloc] init];
        _TimeLab.textAlignment = NSTextAlignmentLeft;
        _TimeLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_TimeLab];
        _TimeLab.sd_layout.leftSpaceToView(self.contentView,5).topSpaceToView(self.contentView,5).widthIs(200).heightIs(15);
        
        _BankLab = [[UILabel alloc] init];
        _BankLab.textAlignment = NSTextAlignmentRight;
        _BankLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_BankLab];
        _BankLab.sd_layout.rightSpaceToView(self.contentView,5).topSpaceToView(self.contentView,5).widthIs(130).heightIs(15);
        
        _BankNumberLab = [[UILabel alloc] init];
        _BankNumberLab.textAlignment = NSTextAlignmentLeft;
        _BankNumberLab.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_BankNumberLab];
        _BankNumberLab.sd_layout.leftSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5).widthIs(180).heightIs(15);
        
        _StatusLab = [[UILabel alloc] init];
        _StatusLab.textAlignment = NSTextAlignmentRight;
        _StatusLab.font = [UIFont systemFontOfSize:14];
        _StatusLab.textColor = Green58;
        [self.contentView addSubview:_StatusLab];
        _StatusLab.sd_layout.rightSpaceToView(self.contentView,5).bottomSpaceToView(self.contentView,5).widthIs(80).heightIs(15);
    
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

@end
