//
//  SetParameterViewController.h
//  CriteriaParser
//
//  Created by Uzma Sayyed on 27/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SetParameterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *studyTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *setParameterLabel;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UILabel *parameterNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *parameterTextField;

@property (strong, nonatomic) NSMutableDictionary *indicatorData;

@end

NS_ASSUME_NONNULL_END
