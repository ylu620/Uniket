//
//  ProfileEditViewController.h
//  Fleem
//
//  Created by Jun Suh Lee on 2/11/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved./Users/junsuhle/Downloads/Fleem/Fleem/ProfileEditViewController.h
//

#import <UIKit/UIKit.h>

@interface ProfileEditViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationBarDelegate,UITextFieldDelegate>
{
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    IBOutlet UIImageView *profileEditPicture;
    
    
    
}

@property (weak, nonatomic) IBOutlet UIView *pictureChooserView;
@property (strong, nonatomic) IBOutlet UIView *profileEditView;

- (IBAction)profileViewMover:(id)sender;
- (IBAction)nameFieldAction:(id)sender;

- (IBAction)chooseExisting:(id)sender;
- (IBAction)takingPicture:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *profileEditName;
@property (weak, nonatomic) IBOutlet UITextField *profileEditContactNum;
@property (weak, nonatomic) IBOutlet UILabel *profileEditEmail;

- (IBAction)fileChooserButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
- (IBAction)goBack:(id)sender;

- (IBAction)profileSubmitAction:(id)sender;

- (IBAction)fileChooserBack:(id)sender;

@end
