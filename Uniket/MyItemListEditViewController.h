//
//  MyItemListEditViewController.h
//  Fleem
//
//  Created by Student on 2/12/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>
#define WISH 0

@interface MyItemListEditViewController : UIViewController <UITextViewDelegate>{
    
    UIImagePickerController *picker;
    UIImagePickerController *picker2;
    UIImage *image;
    NSMutableArray *wishArray;
    __weak IBOutlet UITextView *myItemListEditDescription;
    __weak IBOutlet UITextField *myItemListQuality;
    
    NSString *scopeIdentifier;
}
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
- (IBAction)titleActionStart:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIImageView *myItemEditImage;
@property (weak, nonatomic) IBOutlet UITextField *myItemEditTitle;
@property (strong, nonatomic) IBOutlet UIView *myItemListEditMainView;
- (IBAction)qualityActionStart:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *myItemEditPrice;
- (IBAction)myItemPriceEditBegin:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *myItemListView;
- (IBAction)fileChooserButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *pickerView;
- (IBAction)goBackAim:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *aimButtonOutlet;
- (IBAction)selectType:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *pictureChooserView;
- (IBAction)submitEditedItem:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)chooseExisting:(id)sender;
- (IBAction)takingPicture:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectTypeLabel;


@property (weak, nonatomic) IBOutlet UIView *aimView;
- (IBAction)hideWish:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectWishLabel;
- (IBAction)aimViewBack:(id)sender;

- (IBAction)selectWish:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)aimViewAction:(id)sender;
- (IBAction)pictureChooserBack:(id)sender;
- (IBAction)numberField:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *textbookInfoVIew;
- (IBAction)symbolField:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *symbolOutlet;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerS;

@property (weak, nonatomic) IBOutlet UITextField *numberOutlet;
@property NSString *editID;
@end
