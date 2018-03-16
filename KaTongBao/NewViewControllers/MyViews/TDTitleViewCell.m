//
//  TDTitleViewCell.m
//  POS
//
//  Created by rongfeng on 15/12/10.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDTitleViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
@implementation TDTitleViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textColor = Gray147;
        [self.contentView addSubview:self.label];
        self.label.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10).widthIs(100).heightIs(15.5);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

@end
