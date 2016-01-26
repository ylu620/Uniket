//
//  ProfileEditViewController.m
//  Fleem
//
//  Created by Jun Suh Lee on 2/11/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "ProfileEditViewController.h"
#import <Parse/Parse.h>
@interface ProfileEditViewController (){
    BOOL iphoneFour;
}

@end

@implementation ProfileEditViewController

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
     _profileEditName.autocorrectionType = UITextAutocorrectionTypeNo;
  //  _submitButton.layer.borderWidth = 0.3;
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

    _indicatorView.alpha = 0.0;
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
    [self uploadUserProfile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) uploadUserProfile
{
    PFUser *user = [PFUser currentUser];
    PFFile *userPicture = [user objectForKey:@"profilePicture"];
    [userPicture getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error){
          profileEditPicture.image = [UIImage imageWithData:data];
            
            
        
        }
    } ];
    
    _profileEditName.text = [user objectForKey:@"Name"];
  //  _profileEditContactNum.text = [user objectForKey:@"ContactNo"];
    _profileEditEmail.text = [user objectForKey:@"username"];
    
    
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
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
    CGRect view = _profileEditView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _profileEditView.frame = view;
    
    [UIView commitAnimations];
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooserView.frame = CGRectMake(320, 98, 320, 198);
    }];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        picker2 = [[UIImagePickerController alloc] init];
        picker2.delegate = self;
        [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:picker2 animated:YES completion:NULL];
      }else if(buttonIndex == 2){
          picker = [[UIImagePickerController alloc] init];
          picker.delegate = self;
          [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
          [self presentViewController:picker animated:YES completion:nil];
    }
}



- (IBAction)fileChooserButton:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Edit Profile Picture"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Choose Existing", @"Taking Picture", nil];
    [alert show];
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)profileSubmitAction:(id)sender {
    [self showIndicator];
    PFUser *user = [PFUser currentUser];
    
    user[@"Name"] = _profileEditName.text;
    //user[@"ContactNo"] = _profileEditContactNum.text;
    
    NSData *imageData = UIImageJPEGRepresentation(profileEditPicture.image, 0.1);
    
    PFFile *profileImage = [PFFile fileWithName:@"image.jpg" data:imageData];
    [profileImage save];
    
    
    [user setObject:profileImage forKey:@"profilePicture"];
    [user save];
    [self hideIndicator];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)fileChooserBack:(id)sender {
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooserView.frame = CGRectMake(320, 98, 320, 198);
    }];
}



-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:
(NSDictionary *) info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [profileEditPicture setImage:image];
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooserView.frame = CGRectMake(320, 98, 320, 198);
    }];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel: (UIImagePickerController *) picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}





- (IBAction)profileViewMover:(id)sender {
    if(iphoneFour == false){
    CGRect view = _profileEditView.frame;
    view.origin.x = 0;
    view.origin.y = -80;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _profileEditView.frame = view;
    
    [UIView commitAnimations];
    }else{
        CGRect view = _profileEditView.frame;
        view.origin.x = 0;
        view.origin.y = -140;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _profileEditView.frame = view;
        
        [UIView commitAnimations];
    }
}

- (IBAction)nameFieldAction:(id)sender {
    if(iphoneFour == false){
    CGRect view = _profileEditView.frame;
    view.origin.x = 0;
    view.origin.y = -40;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _profileEditView.frame = view;
    
    [UIView commitAnimations];
    }else{
        CGRect view = _profileEditView.frame;
        view.origin.x = 0;
        view.origin.y = -100;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _profileEditView.frame = view;
        
        [UIView commitAnimations];
    }
}





@end

