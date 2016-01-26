//
//  MyItemCell.m
//  Fleem
//
//  Created by Jun Suh Lee on 2/12/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "MyItemCell.h"

@implementation MyItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
