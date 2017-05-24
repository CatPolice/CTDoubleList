//
//  CTRightCellView.m
//  CTDoubleList
//
//  Created by runlin on 17/5/24.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "CTRightCellView.h"


@interface CTRightCellView ()

@end


@implementation CTRightCellView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.lable = [[UILabel alloc] initWithFrame:(CGRect){0,0,frame.size.width,frame.size.height}];
        self.lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lable];
    }
    //加载了过后才可以修改属性
    self.layer.borderWidth = .5;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.backgroundColor = [UIColor yellowColor];
    return self;
}




@end
