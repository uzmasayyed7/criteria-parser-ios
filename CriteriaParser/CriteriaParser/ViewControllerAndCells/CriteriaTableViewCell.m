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
    self.criteriaTextView.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    self.criteriaTextView.editable = NO;
    self.criteriaTextView.selectable = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
