
#import <UIKit/UIKit.h>


#import <Parse/Parse.h>




@interface LogInViewController : UIViewController<UITextFieldDelegate>{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    __weak IBOutlet UITextField *signUpName;
    

    __weak IBOutlet UITextField *signUpMail;
    
    __weak IBOutlet UITextField *signUpPassword;
    
    __weak IBOutlet UITextField *signUpRePassword;
    
}
- (IBAction)phoneNumberAction:(id)sender;

- (IBAction)fileChooserBack:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *eMailLoginField;
@property (weak, nonatomic) IBOutlet UITextField *passwordLoginField;

- (IBAction)loginActionStart:(id)sender;
- (IBAction)emailBegin:(id)sender;

- (IBAction)dismissKeyBoard:(id)sender;
- (IBAction)didEndOne:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *signUpScrollView;

@property (weak, nonatomic) IBOutlet UIView *signUpView;

- (IBAction)dismissKeyBoardTwo:(id)sender;

- (IBAction)didEndTwo:(id)sender;
- (IBAction)passwordConfirmAction:(id)sender;

- (IBAction)dismissKeyBoardFive:(id)sender;
- (IBAction)dismissKeyBoardFour:(id)sender;

- (IBAction)chooseExisting:(id)sender;
- (IBAction)takingPicture:(id)sender;
- (IBAction)emailFieldAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *firstLine;
@property (weak, nonatomic) IBOutlet UIView *secondLine;
@property (weak, nonatomic) IBOutlet UITextField *dismissKeyBoardFive;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
- (IBAction)profileChooser:(id)sender;
- (IBAction)dismissKeyBoardThree:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *dismissKeyBoardFour;

- (IBAction)passwordTextAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *pictureChooseView;
@property (weak, nonatomic) IBOutlet UIButton *agreeBox;
- (IBAction)agreeBoxAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *disagreeBox;
- (IBAction)disagreeBoxAction:(id)sender;

- (IBAction)logInActionStart:(id)sender;
- (IBAction)onCancelSignUp:(id)sender;
- (IBAction)createAccountAction:(id)sender;

- (IBAction)passWordPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *profilePictureOutlet;

@end
