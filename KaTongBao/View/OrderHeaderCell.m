//
//  OrderHeaderCell.m
//  KaTongBao
//
//  Created by rongfeng on 16/6/21.
//  Copyright © 2016年 rongfeng. All rights reserved.
//

#import "OrderHeaderCell.h"
#import "Common.h"
#import "UIView+SDAutoLayout.h"
@implementation OrderHeaderCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.BackImgView = [[UIImageView alloc] init];
        self.BackImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.BackImgView.layer.borderWidth = 0.5;
        self.BackImgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.BackImgView];
        self.BackImgView.sd_layout.leftSpaceToView(self.contentView,8).topSpaceToView(self.contentView,0).widthIs(KscreenWidth - 16).heightIs(60);
        
        self.HeaderLab = [[UILabel alloc] init];
        self.HeaderLab.text = @"审核中";
        self.HeaderLab.textAlignment = NSTextAlignmentCenter;
        self.HeaderLab.font = [UIFont systemFontOfSize:19];
        [self.BackImgView addSubview:self.HeaderLab];
        self.HeaderLab.sd_layout.centerYEqualToView(self.BackImgView).centerXEqualToView(self.BackImgView).widthIs(100).heightIs(20);
        
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
