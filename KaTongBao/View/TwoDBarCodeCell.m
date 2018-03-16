//
//  TwoDBarCodeCell.m
//  KaTongBao
//
//  Created by rongfeng on 16/7/26.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "TwoDBarCodeCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation TwoDBarCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.LeftLabel = [[UILabel alloc] init];
        self.LeftLabel.textAlignment = NSTextAlignmentLeft;
        self.LeftLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.LeftLabel];
        
        
        self.RightLabel = [[UILabel alloc] init];
        self.RightLabel.textAlignment = NSTextAlignmentLeft;
        self.RightLabel.font = [UIFont systemFontOfSize:15];
        self.RightLabel.textColor = Gray136;
        [self.contentView addSubview:self.RightLabel];
        self.LeftLabel.sd_layout.leftSpaceToView(self.contentView,20).centerYEqualToView(self.contentView).widthIs(92).heightIs(22);
        
        self.RightLabel.sd_layout.leftSpaceToView(self.LeftLabel,10).topSpaceToView(self.contentView,12.5).widthIs(200).heightIs(20);
        
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}




@end
