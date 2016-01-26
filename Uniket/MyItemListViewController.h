//
//  MyItemListViewController.h
//  Fleem
//
//  Created by Jun Suh Lee on 2/12/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataObject.h"
#import "MyItemCell.h"

@interface MyItemListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate,UITextViewDelegate>{
    
    __weak IBOutlet UITextView *itemBargainInProcess;
    NSArray *myItemImageArray;
    NSArray *myItemTitleArray;
    NSString *tempID;
    NSString *tempUserID;
      NSInteger rows;
    
    NSString *tempToID;
    NSString *tempFromID;
    
    
    NSString *tempStatus;
    
    
            NSString *chcker;
       NSString *scopeIdentifier;
    
    IBOutlet UIScrollView *scroller;
    
    
    DataObject *optionSingle;
}
@property (weak, nonatomic) IBOutlet UITableView *myItemListCollection;
@property (weak, nonatomic) IBOutlet UIImageView *myItemDetailImage;
@property (weak, nonatomic) IBOutlet UIImageView *myItemDetailImageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *myItemDetailImageThree;
@property (weak, nonatomic) IBOutlet UILabel *myItemDetailTitle;
@property (weak, nonatomic) IBOutlet UITextView *myItemDetailDescription;
//properties
@property NSString *ownerItemID;
@property NSString *ownerID;
@property UIImage *itemPicture;
@property NSString *itemName;
@property BOOL fromHome;
@property NSString *itemPrice;
- (IBAction)sendRequest:(id)sender;
- (IBAction)deleteItem:(id)sender;
- (IBAction)goBack:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)addMyItem:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *noItemsPostedView;

@property (weak, nonatomic) IBOutlet UIView *myItemDetailView;
- (IBAction)addMyItemInProcess:(id)sender;
- (IBAction)backDetailAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
- (IBAction)deleteItemInProcess:(id)sender;
- (IBAction)backReloadItemInProcess:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *reloadItemViewInProcess;
@property (weak, nonatomic) IBOutlet UIImageView *myItemDetailQuality;

@property (weak, nonatomic) IBOutlet UILabel *finalOpponentLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalMyItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *myItemDetailWish;
- (IBAction)reloadItemInProcess:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *myItemDetailType;
@property (weak, nonatomic) IBOutlet UIImageView *itemPictureInProcess;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleInProcess;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceInProcess;
@property (strong, nonatomic) IBOutlet UIView *requestConfirmView;
- (IBAction)goBackToHomeTwo:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (IBAction)goBackToHome:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@property (weak, nonatomic) IBOutlet UIButton *backbuttonLogo;
- (IBAction)editMyItem:(id)sender;

@end
