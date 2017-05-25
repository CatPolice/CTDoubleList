//
//  ViewController.m
//  CTDoubleList
//
//  Created by runlin on 17/5/23.
//  Copyright © 2017年 gavin. All rights reserved.
//

#import "ViewController.h"
#import "CTDoubleListView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet CTDoubleListView *ctDoubleList;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated{
    // layout 结束之后设置数据源
    [self.ctDoubleList setDataSource:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]
                  withHeadDataSource:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]
                 withRightDataSource:@[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
