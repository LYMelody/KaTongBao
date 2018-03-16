//
//  CustomerCenterTableViewCell.m
//  KaTongBao
//
//  Created by rongfeng on 16/8/15.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "CustomerCenterTableViewCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation CustomerCenterTableViewCell

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
        
        self.LineView = [[UIImageView alloc] init];
        self.LineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.LineView];
        
        self.LeftLabel.sd_layout.leftSpaceToView(self.contentView,16).centerYEqualToView(self.contentView).widthIs(92).heightIs(22);
        
        self.RightLabel.sd_layout.leftSpaceToView(self.LeftLabel,40).centerYEqualToView(self.contentView).widthIs(200).heightIs(20);
        self.LineView.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(0.5);
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

@end
