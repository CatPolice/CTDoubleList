//
//  CTDoubleListView.m
//  CTDoubleList
//
//  Created by runlin on 17/5/23.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "CTDoubleListView.h"
#import "CTUITableviewDataSource.h"
#import "CTLeftTableViewCell.h"


@interface CTDoubleListView ()<UIScrollViewDelegate,UITableViewDelegate>
{
    
    __weak IBOutlet UIView *_headBackgroundView;
    __weak IBOutlet UIView *_leftBackgroundView;
    __weak IBOutlet UIView *_rightBackgroundView;
    
    UITableView *_leftTableview;
    UITableView *_rightTableview;
}


@property (nonatomic , strong)CTUITableviewDataSource *leftDataSource;
@property (nonatomic , strong)CTUITableviewDataSource *rightDataSource;

@end


@implementation CTDoubleListView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if ([super initWithCoder:aDecoder]) {
        
        UIView *contentView =[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] lastObject];
        [self addSubview:contentView];
        self.translatesAutoresizingMaskIntoConstraints=NO;
        contentView.translatesAutoresizingMaskIntoConstraints=NO;
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [self addConstraint: [NSLayoutConstraint constraintWithItem:contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        
        contentView.backgroundColor = [UIColor yellowColor];
    }
    //这里改属性要放在加载nib之后
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UIView *subView = [[NSBundle mainBundle]loadNibNamed:@"CTDoubleListView" owner:self options:nil].firstObject;
        [self addSubview:subView];
        subView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        subView.backgroundColor = [UIColor redColor];
    }
    //加载了过后才可以修改属性
    self.frame = frame;
    return self;
}

/**
 *
 *     set data source
 *
 */
- (void)setDataSource:(NSArray *)liftDataSource withHeadDataSource:(NSArray *)headDataSource withRightDataSource:(NSArray *)rightDataSource{
    [self createLeftTableView:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]];
    [self createRightTableView:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]];
}




/**
 *  left
 */
- (void)createLeftTableView:(NSArray *)leftDataSource{
    
    _leftTableview = [[UITableView alloc] initWithFrame:_leftBackgroundView.bounds style:UITableViewStylePlain];
    [_leftTableview registerNib:[CTLeftTableViewCell nib] forCellReuseIdentifier:@"LEFT_UITABLEVIEW"];
    _leftTableview.delegate = self;
    _leftTableview.rowHeight = 45;
    [_leftBackgroundView addSubview:_leftTableview];
    
    
    CTUITableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell, id items , NSIndexPath *indexPath){
        CTLeftTableViewCell *leftCell = (CTLeftTableViewCell *)cell;
        [leftCell configCellData];
    };

    _leftDataSource = [[CTUITableviewDataSource alloc] initWithItems:leftDataSource cellIdentifier:@"LEFT_UITABLEVIEW" configureCellBlock:configureCell];
    _leftTableview.dataSource = _leftDataSource;
}


/**
 *  head
 */
- (void)createHeadScrollView:(NSArray *)headDataSource{
}

/**
 *  right
 */

- (void)createRightTableView:(NSArray *)rightDataSource{
    
    _rightTableview = [[UITableView alloc] initWithFrame:_rightBackgroundView.bounds style:UITableViewStylePlain];
    [_rightTableview registerNib:[CTLeftTableViewCell nib] forCellReuseIdentifier:@"RIGHT_UITABLEVIEW"];
    _rightTableview.delegate = self;
    _rightTableview.rowHeight = 45;
    [_rightBackgroundView addSubview:_rightTableview];
    
    
    CTUITableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell, id items , NSIndexPath *indexPath){
        CTLeftTableViewCell *leftCell = (CTLeftTableViewCell *)cell;
        [leftCell configCellData];
    };
    
    _rightDataSource = [[CTUITableviewDataSource alloc] initWithItems:rightDataSource cellIdentifier:@"RIGHT_UITABLEVIEW" configureCellBlock:configureCell];
    _rightTableview.dataSource = _rightDataSource;
}




/**
 *  scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _leftTableview) {
        [self tableView:_rightTableview scrollFollowTheOther:_leftTableview];
    }else{
        [self tableView:_leftTableview scrollFollowTheOther:_rightTableview];
    }

}


- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY= other.contentOffset.y;
    CGPoint offset=tableView.contentOffset;
    offset.y=offsetY;
    tableView.contentOffset=offset;
}


@end
