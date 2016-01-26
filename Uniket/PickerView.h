//
//  PickerView.h
//  Fleem
//
//  Created by Student on 2/12/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataObject.h"
#define WISH 0
//extern BOOL submittedFromPickerView;
@interface PickerView : UIViewController
<UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationBarDelegate, UIPickerViewDelegate, UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate>{
    
    IBOutlet UIPickerView *wishPicker;
    
    UIImagePickerController *chooserPicker;
    UIImagePickerController *takePicturePicker;
    UIImage *image;
    
    __weak IBOutlet UITextField *productQuality;
   
     NSMutableArray *wishArray;

    
    __weak IBOutlet UITextView *productDescription;
    
    
    
    //Indicator
  
    IBOutlet UIActivityIndicatorView *indicator;
    __weak IBOutlet UIView *indicatorView;
      NSString *scopeIdentifier;
    
  
    IBOutlet UIScrollView *scroller;
    
    DataObject *optionSingle;
    
}
@property (weak, nonatomic) IBOutlet UILabel *wishLabel;
- (IBAction)selectType:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
- (IBAction)aimViewAction:(id)sender;

- (IBAction)selectType:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *productTitle;
@property (weak, nonatomic) IBOutlet UITextField *productPrice;
- (IBAction)productPriceEditBegin:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *wishButton;

@property (weak, nonatomic) IBOutlet UIButton *aimButtonOutlet;


@property (weak, nonatomic) IBOutlet UIView *pickerViewContainer;

@property (weak, nonatomic) IBOutlet UIButton *postButton;

- (IBAction)fileChooserBack:(id)sender;

- (IBAction)productSubmit:(id)sender;

- (IBAction)hideWish:(id)sender;
- (IBAction)qualityActionStart:(id)sender;

- (IBAction)selectPictureButton:(id)sender;

- (IBAction)aimViewBack:(id)sender;

- (IBAction)titleActionStart:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *pictureChooserView;
- (IBAction)goBackToList:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *goBacktoList;

@property (weak, nonatomic) IBOutlet UIButton *selectWish;
- (IBAction)selectWish:(id)sender;

- (IBAction)chooseExisting:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *pickerViewView;
@property (weak, nonatomic) IBOutlet UIButton *selectType;

- (IBAction)takingPicture:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *aimView;
- (IBAction)goBackAim:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *pickerViewMainView;
@property NSString *tempOwnerID;
@property NSString *tempOwnerItemID;
@property NSString *tempTypeItem;
  //Determine Whether from MyItemList(Normal) OR MyItemList(In process)
 @property NSString *determineString;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;
@property (weak, nonatomic) IBOutlet UIButton *postButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *selectTypeOutlet;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *textbookInfoView;
@property (weak, nonatomic) IBOutlet UITextField *courseSymbolField;
@property (weak, nonatomic) IBOutlet UITextField *courseNumberField;
- (IBAction)symbolEditBegin:(id)sender;
- (IBAction)numberEditBegin:(id)sender;



@property (weak, nonatomic) IBOutlet UIImageView *qMarkFirst;
//picture outlets
@property (weak, nonatomic) IBOutlet UIImageView *qMarkSecond;
@property (weak, nonatomic) IBOutlet UIImageView *qMarkThird;
@property (weak, nonatomic) IBOutlet UIImageView *productImageSecond;
@property (weak, nonatomic) IBOutlet UIImageView *productImageThird;
- (IBAction)selectPictrueButtonTwo:(id)sender;
- (IBAction)selectPictureButtonThree:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectPictureOutletTwo;
@property (weak, nonatomic) IBOutlet UIButton *selectPictureOutletThree;
@property (weak, nonatomic) IBOutlet UIButton *selectPictureOutletOne;

@property BOOL firstPictureEditing;
@property BOOL secondPictureEditing;
@property BOOL thirdPictureEditing;
@property NSString *editID;
@property NSString *editing;

@end
