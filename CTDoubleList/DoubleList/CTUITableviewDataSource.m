//
//  CTUITableviewDataSource.m
//  CTDoubleList
//
//  Created by runlin on 17/5/23.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "CTUITableviewDataSource.h"
#import "CTLeftTableViewCell.h"


@interface CTUITableviewDataSource ()

@property(nonatomic, strong) NSArray *items;
@property(nonatomic, copy) NSString *cellIdentifier;
@property(nonatomic, copy) CTUITableViewCellConfigureBlock configureCellBlock;

@end

@implementation CTUITableviewDataSource


- (instancetype)init {
    return  nil;
}

- (id)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(CTUITableViewCellConfigureBlock)aConfigureCellBlock {
    
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureCellBlock = aConfigureCellBlock;
    }
    return  self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[(NSUInteger) indexPath.row];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id item = [self itemAtIndexPath:indexPath];
    self.configureCellBlock(cell, item , indexPath);
    return cell;
}

@end

