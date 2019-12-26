//
//  ScanTableViewCell.m
//  CriteriaParser
//
//  Created by Uzma Sayyed on 23/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import "ScanTableViewCell.h"

@implementation ScanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self.nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0]];
    [self.tagLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]];
}

@end
