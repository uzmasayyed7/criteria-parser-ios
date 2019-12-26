//
//  IndividualScanViewController.m
//  CriteriaParser
//
//  Created by Uzma Sayyed on 25/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import "IndividualScanViewController.h"
#import "Constants.h"
#import "CriteriaTableViewCell.h"

@interface IndividualScanViewController ()

@property (strong,nonatomic) NSMutableArray *criteriaList;

@end

@implementation IndividualScanViewController

-(void)viewWillAppear:(BOOL)animated{
    self.criteriaList = self.criteriaData[CRITERIA_STRING];
    
    //Set table view delegates
    self.criteriaListTableView.delegate = self;
    self.criteriaListTableView.dataSource = self;
    [self.criteriaListTableView reloadData];
    
    //Remove table view line separator
    self.criteriaListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set label font
    [self.nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0]];
    [self.tagLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]];
    
    //set header view
    [self.nameLabel setText:self.criteriaData[NAME_STRING]];
    [self.tagLabel setText:self.criteriaData[TAG_STRING]];
    
    if ([self.criteriaData[COLOR_STRING] isEqualToString:RED]) {
        [self.tagLabel setTextColor:[UIColor redColor]];
    }
    else if ([self.criteriaData[COLOR_STRING] isEqualToString:GREEN]) {
        [self.tagLabel setTextColor:[UIColor greenColor]];
    }
}

#pragma mark - Criteria list table view delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.criteriaList) {
        return [self.criteriaList count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
    CriteriaTableViewCell *criteriaCell = [tableView dequeueReusableCellWithIdentifier:@"criteriaTableViewCell"];
    if (criteriaCell == nil) {
        criteriaCell = [[CriteriaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"criteriaTableViewCell"];
    }
    
    //Set attributed text for label
    
    NSString *type = self.criteriaList[0][TYPE_STRING];
    if ([type isEqualToString:PLAIN_TEXT]) {
        [criteriaCell.criteriaTextLabel setText:[NSString stringWithFormat:@"%@",self.criteriaList[row][TEXT_STRING]]];
    }
    else if ([type isEqualToString:VARIABLE]){
        NSAttributedString *labelText = [self getTextForRow:row andString:self.criteriaList[row][TEXT_STRING]];
        [criteriaCell.criteriaTextLabel setAttributedText:labelText];
    }
    
    return criteriaCell;
}

-(NSAttributedString *) getTextForRow:(NSInteger)row andString:(NSString *)variableString{
    NSArray *variableList = [self.criteriaList[row][VARIABLE] allKeys];
    NSMutableAttributedString *resultString;
    
    NSString *value, *variable;
    
    for (int i=0; i<[variableList count]; i++) {
        variable = variableList[i];
        value = [self getValueForVariable:variable atRow:row];
        
        //Set blue color to variable value
        if (!resultString) {
            resultString = [[NSMutableAttributedString alloc] initWithString:variableString];
        }
        NSRange range = [resultString.mutableString rangeOfString:variable];
        [resultString replaceCharactersInRange:range withString:value];
        [resultString addAttribute: NSForegroundColorAttributeName value:[UIColor blueColor] range:[resultString.mutableString rangeOfString:value]];
    }
    return resultString;
}

-(NSString *)getValueForVariable:(NSString *)variable atRow:(NSInteger) row{
    NSString *type = self.criteriaList[row][VARIABLE][variable][TYPE_STRING];
    if ([type isEqualToString:VALUE]) {
        return  [NSString stringWithFormat:@"(%@)",self.criteriaList[row][VARIABLE][variable][VALUES_STRING][0]];
    }
    else if ([type isEqualToString:INDICATOR]) {
        return  [NSString stringWithFormat:@"(%@)",self.criteriaList[row][VARIABLE][variable][DEFAULT_VALUE_STRING]];
    }
    return nil;
}

@end
