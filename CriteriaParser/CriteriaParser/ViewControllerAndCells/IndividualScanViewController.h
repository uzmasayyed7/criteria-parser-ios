//
//  IndividualScanViewController.h
//  CriteriaParser
//
//  Created by Uzma Sayyed on 25/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IndividualScanViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (weak, nonatomic) IBOutlet UITableView *criteriaListTableView;

@property (strong, nonatomic) NSDictionary *criteriaData;

@end

NS_ASSUME_NONNULL_END
