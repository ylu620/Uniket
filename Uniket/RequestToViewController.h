//
//  RequestToViewController.h
//  Fleem
//
//  Created by Student on 2/13/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DataObject.h"

@interface RequestToViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *requestToArray;
    NSArray *senderItemArray;
    NSArray *receiverItemArray;
    NSInteger rows;
    
    PFObject *tempInTradingObject;
    PFObject *tempSenderItemObject;
    NSString *tempRequestToID;
    NSString *tempRequestFromID;
    NSString *tempSenderItem;
    
    
    NSString *requestToRecieverTempID;
    NSString *requestToYourTempID;
    NSString *userNameTemp;
    NSString *otherNameTemp;
    NSString *keyForChat;
    NSString *otherIDTemp;
    NSString *scopeIdentifier;
    DataObject *optionSingle;
}
@property (weak, nonatomic) IBOutlet UITableView *requestToCollection;

@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIView *noOrderMadeView;

@property (weak, nonatomic) IBOutlet UIView *requestToView;
@property (weak, nonatomic) IBOutlet UIImageView *requestToSenderImage;
@property (weak, nonatomic) IBOutlet UIImageView *requestToRecieverImage;
@property (weak, nonatomic) IBOutlet UILabel *requestToRecieverLabel;

@property (weak, nonatomic) IBOutlet UILabel *requestToSenderLabel;
- (IBAction)goBackTwo:(id)sender;

- (IBAction)goBackOne:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelRequest;

@property (weak, nonatomic) IBOutlet UIImageView *requestToInTradingReceiverImage;

@property (weak, nonatomic) IBOutlet UILabel *requestToReceiverName;
@property (weak, nonatomic) IBOutlet UILabel *requestToYourItem;
@property (weak, nonatomic) IBOutlet UILabel *requestToReceiverItem;
@property (weak, nonatomic) IBOutlet UILabel *requestToReceiverContact;
@property (weak, nonatomic) IBOutlet UIView *requestToInTradingView;
@property (weak, nonatomic) IBOutlet UIView *isTradeCompletedView;
- (IBAction)yesTradeCompletedButton:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (IBAction)notYetTradeCompletedButton:(id)sender;
- (IBAction)tradeIsCompleted:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIView *frameView;
@property (weak, nonatomic) IBOutlet UIView *frameViewTwo;
@property (weak, nonatomic) IBOutlet UIButton *chatButtonOutlet;
- (IBAction)chattingButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *chattingButtonOutlet;

@end
