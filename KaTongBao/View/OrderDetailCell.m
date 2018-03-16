//
//  OrderDetailCell.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/21.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "OrderDetailCell.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
@implementation OrderDetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        self.contentView.layer.borderWidth = 0.5;
//        self.contentView.layer.borderColor = [UIColor blackColor].CGColor;
        
        self.BackImgView = [[UIImageView alloc] init];
        self.BackImgView.backgroundColor = [UIColor whiteColor];
        self.BackImgView.layer.borderWidth = 0.5;
        self.BackImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:self.BackImgView];
        self.BackImgView.sd_layout.leftSpaceToView(self.contentView,8).topSpaceToView(self.contentView,0).widthIs(self.contentView.width - 16).heightIs(self.contentView.height);
        
        self.LeftLab = [[UILabel alloc] init];
        self.LeftLab.font = [UIFont systemFontOfSize:16];
        [self.BackImgView addSubview:self.LeftLab];
        self.LeftLab.sd_layout.leftSpaceToView(self.BackImgView,10).centerYEqualToView(self.BackImgView).widthIs(80).heightIs(17.5);
        
        self.RightLab = [[UILabel alloc] init];
        self.RightLab.font = [UIFont systemFontOfSize:16];
        self.RightLab.textColor = TextColor;
        [self.BackImgView addSubview:self.RightLab];
        self.RightLab.sd_layout.leftSpaceToView(self.LeftLab,10).centerYEqualToView(self.BackImgView).widthIs(200).heightIs(17.5);
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
}


@end
