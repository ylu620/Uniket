#import "LogInViewController.h"
#import "HomePageViewController.h"

@interface LogInViewController (){
    BOOL segueShouldOccur;
    BOOL iphoneFour;
    BOOL checked;
    BOOL disagreeChecked;
}
@end

@implementation LogInViewController
@synthesize eMailLoginField,passwordLoginField;

//init with nib file
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_signUpScrollView setScrollEnabled:YES];
    [_signUpScrollView setContentSize:CGSizeMake(320, 700)];
    _profilePictureOutlet.layer.borderWidth = 1.0;
    _profilePictureOutlet.layer.borderColor =  [UIColor colorWithRed:99/256.0 green:9/256.0 blue:9/256.0 alpha:1.0].CGColor;
    
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@" Login e-mail" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.eMailLoginField.attributedPlaceholder = str;
    NSAttributedString *strTwo = [[NSAttributedString alloc] initWithString:@" Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    self.passwordLoginField.attributedPlaceholder = strTwo;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginView.png"]];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [_signUpScrollView addGestureRecognizer:singleTap];
    
    PFUser *user = [PFUser currentUser];
    PFInstallation *install = [PFInstallation currentInstallation];
    
    @try{
        user[@"installID"] = [install objectId];
        [user saveInBackground];
    }
    @catch (NSException *e){
        
    }
    
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
    checked = false;
    disagreeChecked = false;
    _firstLine.alpha = 0.13;
    _secondLine.alpha = 0.13;
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:@"Login E-Mail" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor]}];
    NSAttributedString *stringTwo = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    
    self.eMailLoginField.attributedPlaceholder = string;
    self.passwordLoginField.attributedPlaceholder = stringTwo;
    
    self.eMailLoginField.delegate=self;
    self.passwordLoginField.delegate=self;
    self.navigationController.navigationBar.hidden = YES;
    // Do any additional setup after loading the view.
    
    [self autoLogin];
}

//Tap gesture gecognizer
- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    [[self view] endEditing:YES];
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
    CGRect viewTwo = _loginView.frame;
    viewTwo.origin.x = 0;
    viewTwo.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _loginView.frame = viewTwo;
    
    [UIView commitAnimations];
    [UIView animateWithDuration:0.5 animations:^{_pictureChooseView.frame = CGRectMake(320, 78, 320, 147);
    }];
}

//auto log in if possible
-(void)autoLogin{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        if([[currentUser objectForKey:@"emailVerified"] boolValue]){
            //segue to main
            [self performSegueWithIdentifier:@"login" sender:self];
        }else{

        }
    } else {
        segueShouldOccur = NO;
        // show the signup or login screen
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


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
    CGRect viewTwo = _loginView.frame;
    viewTwo.origin.x = 0;
    viewTwo.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _loginView.frame = viewTwo;
    
    [UIView commitAnimations];
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooseView.frame = CGRectMake(320, 78, 320, 147);
    }];
}

- (IBAction)createAccountAction:(id)sender {
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
    [signUpMail resignFirstResponder];
    
    [signUpPassword resignFirstResponder];
    [signUpRePassword resignFirstResponder];
    
    [self checkFieldComplete];
}

- (void) checkFieldComplete {
    if([signUpMail.text isEqualToString:@""] || [signUpPassword.text isEqualToString:@""] ||[signUpRePassword.text isEqualToString:@""]
       ){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something is Wrong" message:@"You need to complete all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        [self checkPasswordsMatch];
    }
    
}

-(void) checkPasswordsMatch {
    if(![signUpPassword.text isEqualToString:signUpRePassword.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Something is Wrong" message:@"Passwords do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if(_profileImage.image == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please submit your profile picture" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else{
        [self registerNewUser];
    }
}

- (void) registerNewUser{
    PFQuery *testuser =  [PFUser query];
    [testuser whereKey:@"email" equalTo:signUpMail.text];
    
    if([testuser countObjects] > 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"The email address is already being used" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if([signUpMail.text length] < 8){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"Please put the valid email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else if(![[signUpMail.text substringWithRange:NSMakeRange([signUpMail.text length] - 7, 7)] isEqualToString:@"usc.edu"] && ![[signUpMail.text substringWithRange:NSMakeRange([signUpMail.text length] - 7, 7)] isEqualToString:@"ivc.edu"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Must use 'usc.edu' or 'ivc.edu' email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else if(!(checked && !disagreeChecked)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Agreement" message:@"Please agree the term" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
        PFUser *newUser = [PFUser user];
        newUser.username = signUpMail.text;
        newUser.password = signUpPassword.text;
        newUser[@"Name"] = signUpName.text;
        newUser.email = signUpMail.text;
        
        NSData *imageData = UIImageJPEGRepresentation(_profileImage.image, 0.1);
        PFFile *profileImage = [PFFile fileWithName:@"image.jpg" data:imageData];
        [profileImage save];
        [newUser setObject:profileImage forKey:@"profilePicture"];
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error){
                NSLog(@"Registration success");
                [PFUser logInWithUsernameInBackground:signUpMail.text
                                             password:signUpPassword.text                                    block:^(PFUser *user, NSError *error) {
                                                 if (user) {
                                                     
                                                 } else {
                                                     
                                                 }
                                             }];
                [self performSegueWithIdentifier:@"emailVerification" sender:self];
                
            }
            else {
                NSLog(@"There was an error");
            }
        }];
    }
}

- (IBAction)loginActionStart:(id)sender {
    segueShouldOccur = NO;
    if([eMailLoginField.text isEqualToString:@""] || [passwordLoginField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Please enter e-mail or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        segueShouldOccur=NO;
        
    }else{
        [PFUser logInWithUsernameInBackground:eMailLoginField.text
                                     password:passwordLoginField.text                                    block:^(PFUser *user, NSError *error) {
                                         if (user) {
                                             segueShouldOccur=YES;
                                             if([[user objectForKey:@"emailVerified"] boolValue]){
                                                 //segue to main
                                                 
                                                 [self performSegueWithIdentifier:@"login" sender:self];
                                             }else{
                                                 [self performSegueWithIdentifier:@"goVerify" sender:self];
                                             }
                                
                                         } else {
                                             segueShouldOccur=NO;
                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please type correct e-mail or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                             [alert show];
                                             
                                             //  return;
                                         }
                                     }];
    }
}

- (IBAction)emailBegin:(id)sender {
    if(iphoneFour == false){
        CGRect view = _loginView.frame;
        view.origin.x = 0;
        view.origin.y = -20;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _loginView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _loginView.frame;
        view.origin.x = 0;
        view.origin.y = -100;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _loginView.frame = view;
        
        [UIView commitAnimations];
    }
}

- (IBAction)dismissKeyBoard:(id)sender {
    [sender resignFirstResponder];
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
    [UIView commitAnimations];
    CGRect viewTwo = _loginView.frame;
    viewTwo.origin.x = 0;
    viewTwo.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _loginView.frame = viewTwo;
    
    [UIView commitAnimations];
}





- (IBAction)dismissKeyBoardTwo:(id)sender {
    [sender resignFirstResponder];
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
}

- (IBAction)didEndOne:(id)sender {
    CGRect viewTwo = _loginView.frame;
    viewTwo.origin.x = 0;
    viewTwo.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _loginView.frame = viewTwo;
    
    [UIView commitAnimations];
}

- (IBAction)didEndTwo:(id)sender {
    CGRect viewTwo = _loginView.frame;
    viewTwo.origin.x = 0;
    viewTwo.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _loginView.frame = viewTwo;
    
    [UIView commitAnimations];
}

- (IBAction)profileChooser:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Profile Picture"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Choose Existing", @"Taking Picture", nil];
    [alert show];
    
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"login"]){
        HomePageViewController *homePage=(HomePageViewController*)[segue destinationViewController];
        
    }
    
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"login"]) {
        
        if(segueShouldOccur == YES){
            return YES;
            
        }else{
            return NO;
        }
        
        
        
    }
    
    return YES;
}




- (IBAction)onCancelSignUp:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)passWordPressed:(id)sender {
    if(iphoneFour == false){
        CGRect view = _loginView.frame;
        view.origin.x = 0;
        view.origin.y = -60;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _loginView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _loginView.frame;
        view.origin.x = 0;
        view.origin.y = -135;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _loginView.frame = view;
        [UIView commitAnimations];
    }
}

- (IBAction)dismissKeyBoardFive:(id)sender {
    [sender resignFirstResponder];
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
}

- (IBAction)dismissKeyBoardFour:(id)sender {
    [sender resignFirstResponder];
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
}


-(void) imagePickerControllerDidCancel: (UIImagePickerController *) picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:
(NSDictionary *) info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_profileImage setImage:image];
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooseView.frame = CGRectMake(320, 78, 320, 147);
    }];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)phoneNumberAction:(id)sender {
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = -50;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
}

- (IBAction)fileChooserBack:(id)sender {
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooseView.frame = CGRectMake(320, 78, 320, 147);
    }];
}
- (IBAction)dismissKeyBoardThree:(id)sender {
    [sender resignFirstResponder];
    CGRect view = _signUpScrollView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _signUpScrollView.frame = view;
    
    [UIView commitAnimations];
}
- (IBAction)agreeBoxAction:(id)sender {
    if(!checked){
        [_agreeBox setImage:[UIImage imageNamed:@"checked_checkbox.png"] forState:UIControlStateNormal];
        checked = true;
        [_disagreeBox setImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
        disagreeChecked = false;
    }else if(checked){
        [_agreeBox setImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
        checked = false;
    }
}
- (IBAction)disagreeBoxAction:(id)sender {
    if(!disagreeChecked){
        [_disagreeBox setImage:[UIImage imageNamed:@"checked_checkbox.png"] forState:UIControlStateNormal];
        disagreeChecked = true;
        [_agreeBox setImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
        checked = false;
    }else if(disagreeChecked){
        [_disagreeBox setImage:[UIImage imageNamed:@"unchecked_checkbox.png"] forState:UIControlStateNormal];
        disagreeChecked = false;
    }
}
@end
