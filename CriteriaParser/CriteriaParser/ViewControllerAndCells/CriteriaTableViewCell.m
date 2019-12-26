//
//  CriteriaTableViewCell.m
//  CriteriaParser
//
//  Created by Uzma Sayyed on 26/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import "CriteriaTableViewCell.h"

@implementation CriteriaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Configure the view for the selected state
    [self.criteriaTextLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0]];
    self.criteriaTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.criteriaTextLabel.numberOfLines = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
