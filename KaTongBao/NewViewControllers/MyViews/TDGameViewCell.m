//
//  TDGameViewCell.m
//  POS
//
//  Created by rongfeng on 15/12/11.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDGameViewCell.h"
#import "UIView+SDAutoLayout.h"
@implementation TDGameViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.btnOne = [[UIButton alloc] init];
        self.btnTwo = [[UIButton alloc] init];
        self.btnThid = [[UIButton alloc] init];
        self.btnFour = [[UIButton alloc] init];
        [self.contentView addSubview:self.btnOne];
        [self.contentView addSubview:self.btnTwo];
        [self.contentView addSubview:self.btnThid];
        [self.contentView addSubview:self.btnFour];
        self.btnOne.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,7).widthIs(288).heightIs(81);
        self.btnTwo.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,98).widthIs(92.5).heightIs(92.5);
        self.btnThid.sd_layout.leftSpaceToView(self.contentView,113.5).topSpaceToView(self.contentView,98).widthIs(92.5).heightIs(92.5);
        self.btnFour.sd_layout.leftSpaceToView(self.contentView,211).topSpaceToView(self.contentView,98).widthIs(92.5).heightIs(92.5);
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}

@end
