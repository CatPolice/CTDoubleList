//
//  CTLeftTableViewCell.h
//  CTDoubleList
//
//  Created by runlin on 17/5/23.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTLeftTableViewCell : UITableViewCell
+(UINib*)nib;

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

- (void)configCellData;


@end
