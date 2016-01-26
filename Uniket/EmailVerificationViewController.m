//
//  EmailVerificationViewController.m
//  Fleem
//
//  Created by Student on 2/20/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "EmailVerificationViewController.h"
#import <Parse/Parse.h>
@interface EmailVerificationViewController (){
    PFUser *user;
}

@end

@implementation EmailVerificationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     user = [PFUser currentUser];
    _email.text = user.email;
    
    [self checkVerified];
    
    // Do any additional setup after loading the view.
}

- (void)checkVerified{
    [user fetch];
    if([[user objectForKey:@"emailVerified"] boolValue]){
        //segue to main
        [self performSegueWithIdentifier:@"goHome" sender:self];
    }else{
        NSLog(@"stillfalse");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)resendEmail:(id)sender {
     user = [PFUser currentUser];
    NSString *temp;
    temp = user.email;
    user.email = @"cal@usc.edu";
    [user saveInBackground];
    user = [PFUser currentUser];
    user.email = temp;
    [user saveInBackground];
    _emailResent.text = @"Verification has been resent";
}

- (IBAction)iVerified:(id)sender {
    [[PFUser currentUser] refresh];
     user = [PFUser currentUser];
   // [user fetch];
    if([[user objectForKey:@"emailVerified"] boolValue]){
        //segue to main
        @try{
            
            PFInstallation *install = [PFInstallation currentInstallation];
          
            user[@"installID"] = [install objectId];
            [user saveInBackground];
            
            if([[[user objectForKey:@"username"] substringWithRange:NSMakeRange([[user objectForKey:@"username"] length] - 7, 7)] isEqualToString:@"ivc.edu"]){
                install[@"location"] = @"irvine";
                [install saveInBackground];
            }
        }
        @catch (NSException *e){
            
        }
        [self performSegueWithIdentifier:@"goHome" sender:self];
    }else{
        NSLog(@"stillfalse");
    }

}
@end
