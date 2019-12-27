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
#import "OptionsListViewController.h"
#import "SetParameterViewController.h"

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
    
    criteriaCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Add tap gesture on links
//    criteriaCell.criteriaTextLabel.userInteractionEnabled = YES;
//    [criteriaCell.criteriaTextLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnLabel:)]];
    
    return criteriaCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    
//    CriteriaTableViewCell *currentCell = [self.criteriaListTableView cellForRowAtIndexPath:indexPath];
//    NSAttributedString *text = currentCell.criteriaTextLabel.attributedText;
//    NSRange *range = [currentCell selec]
//    NSDictionary *atributes = [text attributesAtIndex:<#(NSUInteger)#> effectiveRange:<#(nullable NSRangePointer)#>];
//    NSLog(text);
    
//    OptionsListViewController *listVC = [[UIStoryboard storyboardWithName:@"OptionsList" bundle:nil] instantiateViewControllerWithIdentifier:@"optionsListViewController"];
//    [listVC setOptionsList:self.criteriaList[row][VARIABLE_STRING][@"$1"][VALUES_STRING]];
//
//    [self.navigationController pushViewController:listVC animated:YES];
    
    
    SetParameterViewController *indicatorPage = [[UIStoryboard storyboardWithName:@"SetParameter" bundle:nil] instantiateViewControllerWithIdentifier:@"setParameterViewController"];
    [indicatorPage setIndicatorData:self.criteriaList[row][VARIABLE_STRING][@"$1"]];

    [self.navigationController pushViewController:indicatorPage animated:YES];
}

#pragma mark

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
        
        NSDictionary *linkAttributes = @{ NSForegroundColorAttributeName : [UIColor colorWithRed:0.05 green:0.4 blue:0.65 alpha:1.0],
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle), @"variable" : variable };
        
        NSRange range = [resultString.mutableString rangeOfString:variable];
        [resultString replaceCharactersInRange:range withString:value];
        [resultString addAttributes: linkAttributes range:[resultString.mutableString rangeOfString:value]];
        
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

- (void)handleTapOnLabel:(UITapGestureRecognizer *)tapGesture{
    
}
//- (void)handleTapOnLabel:(UITapGestureRecognizer *)tapGesture{
//    CGPoint locationOfTouchInLabel = [tapGesture locationInView:tapGesture.view];
//    CGSize labelSize = tapGesture.view.bounds.size;
//    CGRect textBoundingBox = [self.layoutManager usedRectForTextContainer:self.textContainer];
//    CGPoint textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
//                                              (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
//    CGPoint locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
//                                                         locationOfTouchInLabel.y - textContainerOffset.y);
//    NSInteger indexOfCharacter = [self.layoutManager characterIndexForPoint:locationOfTouchInTextContainer
//                                                            inTextContainer:self.textContainer
//                                   fractionOfDistanceBetweenInsertionPoints:nil];
//    NSRange linkRange = NSMakeRange(14, 4); // it's better to save the range somewhere when it was originally used for marking link in attributed string
//    if (NSLocationInRange(indexOfCharacter, linkRange)) {
//        // Open an URL, or handle the tap on the link in any other way
//        NSLog(@"link clicked: %@",linkRange);
//    }
//}

@end
