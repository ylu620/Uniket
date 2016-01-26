//
//  ProfileViewController.h
//  Fleem
//
//  Created by Jun Suh Lee on 2/11/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileContactNum;
@property (weak, nonatomic) IBOutlet UILabel *profileEmail;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
- (IBAction)logoutActionStart:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
- (IBAction)goBackToHome:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scroller;


@end
