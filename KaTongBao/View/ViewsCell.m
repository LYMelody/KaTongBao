//
//  ViewsCell.m
//  wujie
//
//  Created by rongfeng on 15/11/20.
//  Copyright © 2015年 ND. All rights reserved.
//

#import "ViewsCell.h"
#import "UIView+SDAutoLayout.h"
#import "Common.h"
@implementation ViewsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _lael = [[UILabel alloc] init];
        [self.contentView addSubview:_lael];
        _lael.sd_layout.topSpaceToView(self.contentView,0).rightEqualToView(self.contentView).leftEqualToView(self.contentView).bottomEqualToView(self.contentView);
        UIImageView *LineImg = [[UIImageView alloc] init];
        LineImg.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:LineImg];
        LineImg.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0).heightIs(0.5);
        //self.backgroundColor = [UIColor lightGrayColor];
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
