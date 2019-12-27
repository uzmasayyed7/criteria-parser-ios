//
//  SetParameterViewController.m
//  CriteriaParser
//
//  Created by Uzma Sayyed on 27/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import "SetParameterViewController.h"
#import "Constants.h"

@interface SetParameterViewController ()

@end

@implementation SetParameterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Set label font
    [self.studyTypeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0]];
    [self.setParameterLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    [self.parameterNameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14.0]];
    
    //Set text
    [self.setParameterLabel setText:SET_PARAMETERS];
    [self.studyTypeLabel setText:[NSString stringWithFormat:@"%@",self.indicatorData[STUDY_TYPE_STRING]]];
    [self.parameterNameLabel setText:[NSString stringWithFormat:@"%@",self.indicatorData[PARAMETER_NAME_STRING]]];
    [self.parameterTextField setText:[NSString stringWithFormat:@"%@",self.indicatorData[DEFAULT_VALUE_STRING]]];
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
