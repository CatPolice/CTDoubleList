//
//  CTRightTableViewCell.m
//  CTDoubleList
//
//  Created by runlin on 17/5/24.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "CTRightTableViewCell.h"
#import "CTRightCellView.h"
#import "CTDoubleListConstant.h"

@implementation CTRightTableViewCell
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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)configCellData:(NSArray *)data withCell:(CTRightTableViewCell *)cell{
    
    if (cell.customReuseIdentifier) {
        return;
    }
    
    for (int i = 0; i < data.count; i++) {
        CTRightCellView *cellView = [[CTRightCellView alloc] initWithFrame:(CGRect){0+(CT_RIGHTCELLVIEW_WIDTH)*i,0,CT_RIGHTCELLVIEW_WIDTH,CT_RIGHTCELLVIEW_HEIGHT}];
        cellView.lable.text = [data objectAtIndex:i];
        [self.contentView addSubview:cellView];
    }
    self.customReuseIdentifier = YES;
}

@end
