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
    [self.ctDoubleList setDataSource:nil withHeadDataSource:nil withRightDataSource:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
