//
//  TDAccountCell.m
//  POS
//
//  Created by syd on 15/11/26.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDAccountCell.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
@implementation TDAccountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.ImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.ImageView];
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.label];
        self.ImageView.sd_layout.leftSpaceToView(self.contentView,17).centerYEqualToView(self.contentView).widthIs(30).heightIs(30);
        self.label.sd_layout.leftSpaceToView(self.contentView,58).centerYEqualToView(self.contentView).widthIs(220).heightIs(22);
        
        UIImageView *LineImg = [[UIImageView alloc] init];
        LineImg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:LineImg];
        LineImg.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(0.5);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

@end
