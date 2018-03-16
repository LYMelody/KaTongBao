//
//  ViewsCell.m
//  wujie
//
//  Created by rongfeng on 15/11/20.
//  Copyright © 2015年 ND. All rights reserved.
//

#import "ViewsCell.h"
#import "UIView+SDAutoLayout.h"
@implementation ViewsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _lael = [[UILabel alloc] init];
        [self.contentView addSubview:_lael];
        _lael.sd_layout.topSpaceToView(self.contentView,0).rightEqualToView(self.contentView).leftEqualToView(self.contentView).bottomEqualToView(self.contentView);
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
