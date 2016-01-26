//
//  HomeTableViewCell.h
//  Fleem
//
//  Created by Mahesh Kumar Lunawat on 2/8/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell{
    
}
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *productTitle;
@property (weak, nonatomic) IBOutlet UITextView *productDetail;
@property (weak, nonatomic) IBOutlet UIImageView *productQuality;
@property (weak, nonatomic) IBOutlet UIImageView *wishMatch;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *wishLabel;
@property (weak, nonatomic) IBOutlet UILabel *wishColor;

@end
