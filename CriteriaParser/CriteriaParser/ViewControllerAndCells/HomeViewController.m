//
//  HomeViewController.m
//  CriteriaParser
//
//  Created by Uzma Sayyed on 23/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import "HomeViewController.h"
#import "NetworkHelper.h"
#import "ScanTableViewCell.h"
#import "IndividualScanViewController.h"

@interface HomeViewController ()

@property (nonatomic) NSMutableArray *configData;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    //Get config data
    [self refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set table view delegate
    self.scansTableView.delegate = self;
    self.scansTableView.dataSource = self;
    
    
    //Remove extra separators from tableview
    self.scansTableView.tableFooterView = [UIView new];
}

- (void)refresh {
    
    [NetworkHelper getConfigData:^(NSString *dataString, NSError *error) {
        
        NSError *err = nil;
        if (!dataString) {
            NSLog(@"FATAL ERROR : No Response for Config Data");
            return;
        }
        
        NSData *convertedData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
        if (convertedData == nil) {
            NSLog(@"FATAL ERROR : Could not parse Config Data");
            return;
        }
        
        NSMutableArray *responseArray = [NSJSONSerialization JSONObjectWithData:convertedData options:NSJSONReadingMutableContainers error:&err];
        
        if (err) {
            NSLog(@"Config Could not be parsed as json: %@", err.description);
        }
        else{
            self.configData = responseArray;
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.scansTableView reloadData];
            });
            
        }
    }];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.configData) {
        return [self.configData count];
    }
    else
        return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    ScanTableViewCell *scanCell = [tableView dequeueReusableCellWithIdentifier:@"scanTableViewCell"];
    if (scanCell == nil) {
        scanCell = [[ScanTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scanTableViewCell"];
    }
    
    if (!self.configData) {
        [[scanCell nameLabel] setText:WAIT_MESSAGE_STRING];
        [[scanCell tagLabel] setText:@""];
        return scanCell;
    }
    
    [[scanCell nameLabel] setText:self.configData[row][NAME_STRING]];
    [[scanCell tagLabel] setText:self.configData[row][TAG_STRING]];
    if ([self.configData[row][COLOR_STRING] isEqualToString:RED]) {
        [[scanCell tagLabel] setTextColor:[UIColor redColor]];
    }
    else if ([self.configData[row][COLOR_STRING] isEqualToString:GREEN]) {
        [[scanCell tagLabel] setTextColor:[UIColor greenColor]];
    }
    
    return scanCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    //Initialize next page
    IndividualScanViewController *nextPage = [[UIStoryboard storyboardWithName:@"IndividualScan" bundle:nil] instantiateViewControllerWithIdentifier:@"individualScanViewController"];
    [nextPage setCriteriaData:self.configData[row]];
    
    [self.navigationController pushViewController:nextPage animated:YES];
    
}

@end
