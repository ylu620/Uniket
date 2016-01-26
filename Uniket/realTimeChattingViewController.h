//
//  realTimeChattingViewController.h
//  Fleem
//
//  Created by Jun Suh Lee on 3/6/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
@interface realTimeChattingViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate>{
 

    __weak IBOutlet UITextField *tfEntry;
    __weak IBOutlet UITableView *chatTable;
  
    __weak IBOutlet UILabel *chattingHeader;
    NSArray          *chatData;
    NSInteger rows;
    NSTimer *myTimer;
}

- (IBAction)sendButton:(id)sender;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *otherPicture;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIView *indicatorView;

- (IBAction)sendButtonTwo:(id)sender;

@property NSString *chattingKey;
@property (weak, nonatomic) IBOutlet UILabel *otherNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)goBackAction:(id)sender;

@property NSString *otherID;
@property NSString *userName;
@property NSString *otherName;
@property NSString *fromWhere;
@property UIImage *otherFace;
@end
