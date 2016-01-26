//
//  EmailVerificationViewController.h
//  Fleem
//
//  Created by Student on 2/20/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmailVerificationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *email;
- (IBAction)resendEmail:(id)sender;
- (IBAction)iVerified:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *emailResent;

@end
