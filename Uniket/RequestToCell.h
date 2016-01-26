//
//  RequestToCell.h
//  Fleem
//
//  Created by Student on 2/13/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestToCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftPicture;
@property (weak, nonatomic) IBOutlet UIImageView *rightPicture;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *status;

@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *chattingButtonOutlet;

@end
