//
//  CTLeftTableViewCell.m
//  CTDoubleList
//
//  Created by runlin on 17/5/23.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "CTLeftTableViewCell.h"

@implementation CTLeftTableViewCell
+(UINib*)nib{
    return  [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configCellData{
    self.cellTitle.text = @"11111";
}


@end
