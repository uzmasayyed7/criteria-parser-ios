//
//  OptionsTableViewCell.m
//  CriteriaParser
//
//  Created by Uzma Sayyed on 27/12/19.
//  Copyright © 2019 Uzma Sayyed. All rights reserved.
//

#import "OptionsTableViewCell.h"

@implementation OptionsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.optionLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0]];
    self.optionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.optionLabel.numberOfLines = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
