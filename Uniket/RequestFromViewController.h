//
//  RequestFromViewController.h
//  Fleem
//
//  Created by Student on 2/13/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface RequestFromViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *requestFromArray;
    NSInteger rows;
    
    NSString *tempRequestFromID;
    NSString *tempRequestToID;
    
    PFObject *tempInTradingObject;
    NSString *tempReceiverItem;
    NSString *tempSenderItem;
    PFObject *tempReceiverItemObject;
    
    NSString *requestFromOppoTempID;
    NSString *requestFromYourTempID;
    NSString *firstFive;
     NSString *secondFive;
    NSString *userNameTemp;
    NSString *otherNameTemp;
    NSString *otherIDTemp;
    NSString *keyForChat;
    
    NSString *scopeIdentifier;
}
@property (weak, nonatomic) IBOutlet UITableView *requestFromCollection;

@property (weak, nonatomic) IBOutlet UIView *requestFromView;
@property (weak, nonatomic) IBOutlet UIImageView *requestFromReceiverImage;
@property (weak, nonatomic) IBOutlet UIImageView *requestFromSenderImage;
@property (weak, nonatomic) IBOutlet UILabel *requestFromSenderLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestFromReceiverLabel;
@property (weak, nonatomic) IBOutlet UITextView *requestFromSenderDescription;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (IBAction)goBackTwo:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *requestFromInTradingView;
@property (weak, nonatomic) IBOutlet UIImageView *requestFromInTradingOpponentPicture;
@property (weak, nonatomic) IBOutlet UILabel *requestFromInTradingOpponentName;
@property (weak, nonatomic) IBOutlet UILabel *requestFromInTradingYourItem;
@property (weak, nonatomic) IBOutlet UILabel *requestFromInTradingOpponentItem;
@property (weak, nonatomic) IBOutlet UILabel *requestFromInTradingOpponentContact;

@property (weak, nonatomic) IBOutlet UIView *isTradeCompletedView;
- (IBAction)goBackThree:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *opponentQuality;

- (IBAction)requestFromAccept:(id)sender;
- (IBAction)yesTradeCompletedButton:(id)sender;
- (IBAction)notYetTradeCompletedButton:(id)sender;

- (IBAction)requestFromDeny:(id)sender;

- (IBAction)tradeIsCompleted:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *noOrderReceivedView;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@property (weak, nonatomic) IBOutlet UIButton *denyButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UILabel *frameView;
@property (weak, nonatomic) IBOutlet UIButton *chatButtonOutlet;
@property (weak, nonatomic) IBOutlet UIView *frameViewTwo;


@end
