//
//  CTHeadCellView.m
//  CTDoubleList
//
//  Created by runlin on 17/5/25.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "CTHeadCellView.h"

@implementation CTHeadCellView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.lable = [[UILabel alloc] initWithFrame:(CGRect){0,0,frame.size.width,frame.size.height}];
        self.lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lable];
    }
    //加载了过后才可以修改属性
    self.layer.borderWidth = .5;
    self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.backgroundColor = [UIColor magentaColor];
    return self;
}
@end
