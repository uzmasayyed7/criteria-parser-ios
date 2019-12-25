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

@interface HomeViewController ()

@property (nonatomic) NSMutableArray *configData;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Get config data
    [self refresh];
    
    //Set table view delegate
    self.scansTableView.delegate = self;
    self.scansTableView.dataSource = self;
    
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
    
    [[scanCell nameLabel] setText:self.configData[row][NAME_STRING]];
    [[scanCell tagLabel] setText:self.configData[row][TAG_STRING]];
    if ([self.configData[row][COLOR_STRING] isEqualToString:@"red"]) {
        [[scanCell tagLabel] setTextColor:[UIColor redColor]];
    }
    else if ([self.configData[row][COLOR_STRING] isEqualToString:@"green"]) {
        [[scanCell tagLabel] setTextColor:[UIColor greenColor]];
    }
    
    return scanCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
