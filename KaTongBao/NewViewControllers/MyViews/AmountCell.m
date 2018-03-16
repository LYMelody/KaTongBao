//
//  AmountCell.m
//  wujieNew
//
//  Created by rongfeng on 15/12/22.
//  Copyright © 2015年 rongfeng. All rights reserved.
//

#import "AmountCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation AmountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.moneyLab = [[UILabel alloc] init];
        self.moneyLab.font = [UIFont systemFontOfSize:18];
        self.moneyLab.textColor = Color(255, 147, 42);
        self.moneyLab.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.moneyLab];
        self.moneyLab.sd_layout.leftSpaceToView(self.contentView,78.5).topSpaceToView(self.contentView,22.5).widthIs(163).heightIs(18);
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
}
@end
