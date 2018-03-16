//
//  TDLifeCell.m
//  POS
//
//  Created by rongfeng on 15/12/11.
//  Copyright © 2015年 TangDi. All rights reserved.
//

#import "TDLifeCell.h"
#import "UIView+SDAutoLayout.h"
#import "BusiIntf.h"
@implementation TDLifeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.btnOne = [[UIButton alloc] init];
        self.btnTwo = [[UIButton alloc] init];
        self.btnTrird = [[UIButton alloc] init];
        self.btnFour = [[UIButton alloc] init];
        self.btnFive = [[UIButton alloc] init];
        self.btnSix = [[UIButton alloc] init];
        self.btnSeven = [[UIButton alloc] init];
        self.btnEight = [[UIButton alloc] init];
        self.btnNine = [[UIButton alloc] init];
        self.btnTen = [[UIButton alloc] init];
        
        [self.contentView addSubview:self.btnOne];
        [self.contentView addSubview:self.btnTwo];
        [self.contentView addSubview:self.btnTrird];
        [self.contentView addSubview:self.btnFour];
        [self.contentView addSubview:self.btnFive];
        [self.contentView addSubview:self.btnSix];
        [self.contentView addSubview:self.btnSeven];
        [self.contentView addSubview:self.btnEight];
        [self.contentView addSubview:self.btnNine];
        [self.contentView addSubview:self.btnTen];

        if ([BusiIntf curPayOrder].IsAPPStore) {
            self.btnOne.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10.5).widthIs(86.3).heightIs(86.3);
            self.btnTwo.sd_layout.leftSpaceToView(self.contentView,115.3).topSpaceToView(self.contentView,10.5).widthIs(86.3).heightIs(86.3);
            self.btnTrird.sd_layout.rightSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10.5).widthIs(86.3).heightIs(86.3);
            
            self.btnFour.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,112.8).widthIs(86.3).heightIs(86.3);
            self.btnFive.sd_layout.centerXEqualToView(self.contentView).topSpaceToView(self.contentView,112.8).widthIs(86.3).heightIs(86.3);
            //self.btnSix.sd_layout.rightSpaceToView(self.contentView,16).topSpaceToView(self.contentView,112.8).widthIs(86.3).heightIs(86.3);
        }else {
            self.btnOne.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10.5).widthIs(68.5).heightIs(68.5);
            self.btnTwo.sd_layout.leftSpaceToView(self.contentView,89.5).topSpaceToView(self.contentView,10.5).widthIs(68.5).heightIs(68.5);
            self.btnTrird.sd_layout.leftSpaceToView(self.contentView,163).topSpaceToView(self.contentView,10.5).widthIs(68.5).heightIs(68.5);
            self.btnFour.sd_layout.leftSpaceToView(self.contentView,236.5).topSpaceToView(self.contentView,10.5).widthIs(68.5).heightIs(68.5);
            self.btnFive.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,86.5).widthIs(68.5).heightIs(68.5);
            self.btnSix.sd_layout.leftSpaceToView(self.contentView,89.5).topSpaceToView(self.contentView,86.5).widthIs(68.5).heightIs(68.5);
            self.btnSeven.sd_layout.leftSpaceToView(self.contentView,163).topSpaceToView(self.contentView,86.5).widthIs(68.5).heightIs(68.5);
            self.btnEight.sd_layout.leftSpaceToView(self.contentView,236.5).topSpaceToView(self.contentView,86.5).widthIs(68.5).heightIs(68.5);
            self.btnNine.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,163).widthIs(68.5).heightIs(68.5);
            self.btnTen.sd_layout.leftSpaceToView(self.contentView,89.5).topSpaceToView(self.contentView,163).widthIs(68.5).heightIs(68.5);
            //self.btnOne.sd_layout.leftSpaceToView(self.contentView,16).topSpaceToView(self.contentView,10.5).widthIs(68.5).heightIs(68.5);
        }
    }
    
    return self;
    
}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
}
@end
