//
//  TDMartCell.m
//  POS
//
//  Created by rongfeng on 15/12/11.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDMartCell.h"
#import "UIView+SDAutoLayout.h"
@implementation TDMartCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.btnOne = [[UIButton alloc] init];
        self.btnTwo = [[UIButton alloc] init];
        self.btnThrid = [[UIButton alloc] init];
        self.btnFour = [[UIButton alloc] init];
        self.btnFive = [[UIButton alloc] init];
        [self.contentView addSubview:self.btnOne];
//        [self.contentView addSubview:self.btnTwo];
//        [self.contentView addSubview:self.btnThrid];
//        [self.contentView addSubview:self.btnFour];
//        [self.contentView addSubview:self.btnFive];
        self.btnOne.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,8).widthIs(288).heightIs(80);
//        self.btnTwo.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,96.5).widthIs(141.5).heightIs(57.5);
//        self.btnThrid.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,159).widthIs(141.5).heightIs(57.5);
//        self.btnFour.sd_layout.leftSpaceToView(self.contentView,162.5).topSpaceToView(self.contentView,96.5).widthIs(141.5).heightIs(57.5);
//        self.btnFive.sd_layout.leftSpaceToView(self.contentView,162.5).topSpaceToView(self.contentView,159).widthIs(141.5).heightIs(57.5);
        
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
