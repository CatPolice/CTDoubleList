//
//  CTRightTableViewCell.h
//  CTDoubleList
//
//  Created by runlin on 17/5/24.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTRightTableViewCell : UITableViewCell

@property (nonatomic , assign)BOOL customReuseIdentifier;

+(UINib*)nib;
- (void)configCellData:(NSArray *)data withCell:(CTRightTableViewCell *)cell;



@end
