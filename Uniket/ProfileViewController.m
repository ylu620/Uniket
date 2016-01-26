//
//  ProfileViewController.m
//  Fleem
//
//  Created by Jun Suh Lee on 2/11/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
@interface ProfileViewController (){
    BOOL iphoneFour;
}

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) showIndicator{
    [UIView animateWithDuration:0.0 animations:^{_indicatorView.alpha = 1.0;} completion:^(BOOL finished){
        [_indicator startAnimating];
    }];
}

-(void) hideIndicator{
    [UIView animateWithDuration:0.3 animations:^{_indicatorView.alpha = 0.0;} completion:^(BOOL finished){
        [_indicator stopAnimating];
    }];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showIndicator];
    [_scroller setScrollEnabled:YES];
    [_scroller setContentSize:CGSizeMake(320, 568)];
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height<490.0f)
        {
            NSLog(@"App is running on iPhone with screen 3.5 inch");
            iphoneFour = true;
        }
        else
        {
            NSLog(@"App is running on iPhone with screen 4.0 inch");
            iphoneFour = false;
        }
    }
    if(iphoneFour == true){
        [_scroller setContentInset:UIEdgeInsetsMake(0,0 , 100, 0)];
    }else{
           [_scroller setContentInset:UIEdgeInsetsMake(0, 0, 50, 0)];
    }
    
    //apply image
    _scroller.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"profileView.png"]];
    
    
    
   // _editButton.layer.borderWidth =0.3;
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.

     [self performSelector:@selector(uploadUserProfile) withObject:nil afterDelay:1.0];
    
    
}
-(void)viewWillAppear:(BOOL)animated {
	//[super viewWillAppear:animated];
 [[UITabBar appearance] setTintColor:[UIColor colorWithRed:173/256.0 green:17/256.0 blue:17/256.0 alpha:1.0]];
    [self uploadUserProfile];
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
- (void) uploadUserProfile
{
    PFUser *user = [PFUser currentUser];
    PFFile *userPicture = [user objectForKey:@"profilePicture"];
    [userPicture getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error){
           // _profilePicture.image = [UIImage imageWithData:data];
            
             _profilePicture.image= [UIImage imageWithData:data];
           

        }
    } ];
    
    _profileName.text = [user objectForKey:@"Name"];
    //_profileContactNum.text = [user objectForKey:@"ContactNo"];
    _profileEmail.text = [user objectForKey:@"username"];
    [self hideIndicator];
}

- (IBAction)logoutActionStart:(id)sender {
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser]; // this will now be nil
    [self performSegueWithIdentifier:@"logout" sender:self];
}
- (IBAction)goBackToHome:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
@end
