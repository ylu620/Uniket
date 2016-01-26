//
//  realTimeChattingCell.h
//  Fleem
//
//  Created by Jun Suh Lee on 3/6/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface realTimeChattingCell : UITableViewCell{
    
   
}
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *myUserName;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *textString;
@end
