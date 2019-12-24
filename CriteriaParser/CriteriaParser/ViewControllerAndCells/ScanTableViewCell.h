//
//  ScanTableViewCell.h
//  CriteriaParser
//
//  Created by Uzma Sayyed on 23/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@end

NS_ASSUME_NONNULL_END
