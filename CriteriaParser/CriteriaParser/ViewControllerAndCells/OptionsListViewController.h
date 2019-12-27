//
//  OptionsListViewController.h
//  CriteriaParser
//
//  Created by Uzma Sayyed on 27/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OptionsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *optionsListTableView;

@property (strong, nonatomic) NSMutableArray *optionsList;

@end

NS_ASSUME_NONNULL_END
