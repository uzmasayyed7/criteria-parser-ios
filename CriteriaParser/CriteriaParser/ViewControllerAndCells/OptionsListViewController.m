//
//  OptionsListViewController.m
//  CriteriaParser
//
//  Created by Uzma Sayyed on 27/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import "OptionsListViewController.h"
#import "OptionsTableViewCell.h"

@interface OptionsListViewController ()

@end

@implementation OptionsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.optionsListTableView.delegate = self;
    self.optionsListTableView.dataSource = self;
    
    //Remove extra separators from tableview
    self.optionsListTableView.tableFooterView = [UIView new];
}

#pragma mark - Options list table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.optionsList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    OptionsTableViewCell *optionCell = [tableView dequeueReusableCellWithIdentifier:@"optionsTableViewCell"];
    if (optionCell == nil) {
        optionCell = [[OptionsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionsTableViewCell"];
    }
    
    [optionCell.optionLabel setText:[NSString stringWithFormat:@"%@",self.optionsList[row]]];
    
    return optionCell;
}

@end
