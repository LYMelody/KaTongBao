//
//  TDMegCell.m
//  POS
//
//  Created by syd on 15/11/27.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDMegCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation TDMegCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.LeftLable = [[UILabel alloc] init];
        self.LeftLable.textAlignment = NSTextAlignmentLeft;
        self.LeftLable.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.LeftLable];
        self.ImageView = [[UIImageView alloc] init];
        self.ImageView.backgroundColor = Gray179;
        self.ImageView.layer.cornerRadius = 22.5;
        self.ImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.ImageView];
        self.RightLabel = [[UILabel alloc] init];
        self.RightLabel.textAlignment = NSTextAlignmentRight;
        self.RightLabel.font = [UIFont systemFontOfSize:15];
        self.RightLabel.textColor = Gray136;
        [self.contentView addSubview:self.RightLabel];
        self.LeftLable.sd_layout.leftSpaceToView(self.contentView,20).centerYEqualToView(self.contentView).widthIs(92).heightIs(22);
        self.ImageView.sd_layout.rightSpaceToView(self.contentView,16).topSpaceToView(self.contentView,9).widthIs(45).heightIs(45);
        self.RightLabel.sd_layout.rightSpaceToView(self.contentView,16).topSpaceToView(self.contentView,12.5).widthIs(100).heightIs(20);

    }
 
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
