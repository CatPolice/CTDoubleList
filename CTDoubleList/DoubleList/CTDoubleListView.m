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
#import "CTRightTableViewCell.h"
#import "CTDoubleListConstant.h"
#import "CTHeadCellView.h"


@interface CTDoubleListView ()<UIScrollViewDelegate,UITableViewDelegate>
{
    
    __weak IBOutlet UIView *_headBackgroundView;
    __weak IBOutlet UIView *_leftBackgroundView;
    __weak IBOutlet UIView *_rightBackgroundView;
    
    UITableView *_leftTableview;
    UITableView *_rightTableview;
    
    UIScrollView *_mainScrollview;
    UIScrollView *_headScrollview;
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
    //更改属性要放在加载nib之后
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        UIView *subView = [[NSBundle mainBundle]loadNibNamed:@"CTDoubleListView" owner:self options:nil].firstObject;
        [self addSubview:subView];
        subView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        subView.backgroundColor = [UIColor redColor];
    }
    //加载过后才可以更改属性
    self.frame = frame;
    return self;
}

/**
 *     set data source
 */
- (void)setDataSource:(NSArray *)liftDataSource withHeadDataSource:(NSArray *)headDataSource withRightDataSource:(NSArray *)rightDataSource{
    [self createLeftTableView:liftDataSource];
    [self createRightTableView:rightDataSource];
    [self createHeadScrollView:headDataSource];
}


/**
 *  left
 */
- (void)createLeftTableView:(NSArray *)leftDataSource{
    _leftTableview = [[UITableView alloc] initWithFrame:_leftBackgroundView.bounds style:UITableViewStylePlain];
    [_leftTableview registerNib:[CTLeftTableViewCell nib] forCellReuseIdentifier:@"LEFT_UITABLEVIEW"];
    _leftTableview.delegate = self;
    _leftTableview.rowHeight = CT_CELL_ROW_HEIGHT;
    [_leftBackgroundView addSubview:_leftTableview];
    _leftTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CTUITableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell, id items , NSIndexPath *indexPath){
        CTLeftTableViewCell *leftCell = (CTLeftTableViewCell *)cell;
        [leftCell configCellData:[NSString stringWithFormat:@"%zd",indexPath.row]];
    };
    _leftDataSource = [[CTUITableviewDataSource alloc] initWithItems:leftDataSource cellIdentifier:@"LEFT_UITABLEVIEW" configureCellBlock:configureCell];
    _leftTableview.dataSource = _leftDataSource;
}


/**
 *  head
 */
- (void)createHeadScrollView:(NSArray *)headDataSource{
    _headScrollview = [[UIScrollView alloc] initWithFrame:_headBackgroundView.bounds];
    [_headBackgroundView addSubview:_headScrollview];
    _headScrollview.delegate = self;
    _headScrollview.contentSize = CGSizeMake(CT_HEAD_CELLVIEW_WIDTH*headDataSource.count, 0);
    for (int i = 0; i < headDataSource.count; i++) {
        CTHeadCellView *headView = [[CTHeadCellView alloc] initWithFrame:(CGRect){0+(CT_HEAD_CELLVIEW_WIDTH)*i,0,CT_HEAD_CELLVIEW_WIDTH,CT_HEAD_CELLVIEW_HEIGHT}];
        headView.lable.text = [NSString stringWithFormat:@"%zd",i];
        [_headScrollview addSubview:headView];
    }
}


/**
 *  right
 */
- (void)createRightTableView:(NSArray *)rightDataSource{
    // addsubview --> scrollview
    _mainScrollview = [[UIScrollView alloc] initWithFrame:_rightBackgroundView.bounds];
    _mainScrollview.contentSize = CGSizeMake(CT_RIGHTCELLVIEW_WIDTH*rightDataSource.count, 0);
    _mainScrollview.delegate = self;
//    _mainScrollview.bounces = NO;
    [_rightBackgroundView addSubview:_mainScrollview];
    // addsubview --> tableview
    _rightTableview = [[UITableView alloc] initWithFrame:(CGRect){0,0,CT_RIGHTCELLVIEW_WIDTH*rightDataSource.count,_rightBackgroundView.bounds.size.height} style:UITableViewStylePlain];
    [_rightTableview registerNib:[CTRightTableViewCell nib] forCellReuseIdentifier:@"RIGHT_UITABLEVIEW"];
    _rightTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _rightTableview.delegate = self;
    _rightTableview.rowHeight = CT_CELL_ROW_HEIGHT;
    [_mainScrollview addSubview:_rightTableview];
    
    
    CTUITableViewCellConfigureBlock configureCell = ^(UITableViewCell *cell, id items , NSIndexPath *indexPath){
        CTRightTableViewCell *rightCell = (CTRightTableViewCell *)cell;
        [rightCell configCellData:rightDataSource withCell:rightCell];
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
    }else if(scrollView == _rightTableview){
        [self tableView:_leftTableview scrollFollowTheOther:_rightTableview];
    }else if (scrollView == _headScrollview){
        [self scrollView:_mainScrollview scrollFollowTheOther:_headScrollview];
    }else if (scrollView == _mainScrollview){
        [self scrollView:_headScrollview scrollFollowTheOther:_mainScrollview];
    }

}


- (void)tableView:(UITableView *)tableView scrollFollowTheOther:(UITableView *)other{
    CGFloat offsetY = other.contentOffset.y;
    CGPoint offset = tableView.contentOffset;
    offset.y = offsetY;
    tableView.contentOffset=offset;
}

- (void)scrollView:(UIScrollView *)scrollView scrollFollowTheOther:(UIScrollView *)other{
    CGFloat offsetX = other.contentOffset.x;
    CGPoint offset = scrollView.contentOffset;
    offset.x = offsetX;
    scrollView.contentOffset = offset;
}


@end
