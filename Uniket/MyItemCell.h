//
//  MyItemCell.h
//  Fleem
//
//  Created by Jun Suh Lee on 2/12/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyItemCell : UITableViewCell{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *myItemImage;
@property (weak, nonatomic) IBOutlet UILabel *myItemTitle;

@property (weak, nonatomic) IBOutlet UIImageView *targetCell;
@property (weak, nonatomic) IBOutlet UILabel *myItemStatus;
@property (weak, nonatomic) IBOutlet UILabel *normalMyItemStatus;

@end
