//
//  TDCustomMegCell.m
//  POS
//
//  Created by syd on 15/11/27.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDCustomMegCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation TDCustomMegCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.LeftLabel = [[UILabel alloc] init];
        self.LeftLabel.textAlignment = NSTextAlignmentLeft;
        self.LeftLabel.font = [UIFont systemFontOfSize:15];
        
        [self.contentView addSubview:self.LeftLabel];
        self.RightLabel = [[UILabel alloc] init];
        self.RightLabel.textAlignment = NSTextAlignmentLeft;
        
        self.RightLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.RightLabel];
        
        self.LeftLabel.sd_layout.leftSpaceToView(self.contentView,20).centerYEqualToView(self.contentView).widthIs(80).heightIs(22);
        self.RightLabel.sd_layout.leftSpaceToView(self.contentView,160).widthIs(100).heightIs(22).centerYEqualToView(self.contentView);
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
