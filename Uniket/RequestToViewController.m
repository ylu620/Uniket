//
//  RequestToViewController.m
//  Fleem
//
//  Created by Student on 2/13/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "RequestToViewController.h"
#import "RequestToCell.h"
#import "realTimeChattingViewController.h"
#import <Parse/Parse.h>
@interface RequestToViewController (){
    NSMutableArray *requestToList;
    BOOL iphoneFour;
    
        UIRefreshControl *refreshControl;
}


@end

@implementation RequestToViewController

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

-(void) refreshTable{
    [self queryParseMethod];
    [refreshControl endRefreshing];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.requestToCollection.separatorColor=[UIColor clearColor];
      self.requestToCollection.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableBackground.png"]];
    //image apply
     _requestToInTradingView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"InTradingView.png"]];
    _requestToView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pendingView.png"]];
    
   // _frameView.layer.borderWidth = 0.3;
   // _frameViewTwo.layer.borderWidth = 0.3;
   // _chatButtonOutlet.layer.borderWidth = 0.3;
    _chatButtonOutlet.layer.borderColor = [[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f] CGColor];
    _requestToInTradingReceiverImage.layer.borderWidth = 0.3;
    //_noOrderMadeView.alpha = 0.0;
  //  _doneButton.layer.borderWidth = 0.3;
  //  _cancelButton.layer.borderWidth =0.3;
    PFUser *currentUser = [PFUser currentUser];
    if([[[currentUser objectForKey:@"username"] substringWithRange:NSMakeRange([[currentUser objectForKey:@"username"] length] - 7, 7)] isEqualToString:@"ivc.edu"]){
        scopeIdentifier = @"IVC";
    }else{
        scopeIdentifier = @"";
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
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    
    
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self.requestToCollection addSubview:refreshControl];
    
    [self showIndicator];
    // Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;
      requestToList = [NSMutableArray arrayWithObjects:@"requestTo 1",nil];
   //  [self queryParseMethod];
     [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
}
-(void)viewWillAppear:(BOOL)animated{
    //   self.navigationItem.backBarButtonItem=nil;
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];

    [currentInstallation setBadge:0];
    [currentInstallation saveEventually];
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:173/256.0 green:17/256.0 blue:17/256.0 alpha:1.0]];
    optionSingle = [DataObject dataObjects];
    if( [optionSingle.requestConfirmed isEqualToString:@"True"]){
         [self showIndicator];
        if(iphoneFour == false){
            [ UIView animateWithDuration:0.3 animations:^{_isTradeCompletedView.frame = CGRectMake(0, 383, 320, 123);
            }];
        }else{
            [ UIView animateWithDuration:0.3 animations:^{_isTradeCompletedView.frame = CGRectMake(0, 300, 320, 123);
            }];
        }
        if(iphoneFour == false){
            [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(320, 0, 320, 550);
            }];
        }else{
            [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(320, 0, 320, 435);
            }];
        }
           [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
        optionSingle.requestConfirmed = @"False";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RequestToCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestCell"];
    
    //****Product Data Extraction from DB **********
    //****Product Data Extraction **********
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"requestToCell.png"]];

    
    if (cell == nil) {
        cell = [[RequestToCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"requestCell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    PFObject *requestToObject = [requestToArray objectAtIndex:indexPath.row];
    
    NSString *requestToSenderItemPrice = [requestToObject objectForKey:@"senderPrice"];
    NSString *requestToReceiverItemID = [requestToObject objectForKey:@"receiverItem"];
    
    NSLog(@"%@", requestToReceiverItemID);
     NSLog(@"requestoID");
                NSString *tem = [requestToObject objectForKey:@"status"];
            NSLog(@"%@", tem);
            NSLog(@"statusinfo");
    
    
    
    //CHATBUTTON IS ALPHA 0.0 AS USUAL
    cell.chattingButtonOutlet.alpha = 0.0;
            if([tem isEqualToString:@"1"]){
                     [cell.statusLabel setTextColor:[UIColor blackColor]];
                //cell.status.image = [UIImage imageNamed:@"right.png"];
                cell.statusLabel.text = @"Pending";
            }else if([tem isEqualToString:@"3"]){
                //cell.status.image = [UIImage imageNamed:@"check.png"];
                [cell.statusLabel setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
                  cell.statusLabel.text = @"Accepted";
                
                cell.chattingButtonOutlet.alpha = 1.0;
                cell.chattingButtonOutlet.tag = indexPath.row;
                [cell.chattingButtonOutlet addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }else if([tem isEqualToString:@"2"]){
                //cell.status.image = [UIImage imageNamed:@"x.png"];
                 [cell.statusLabel setTextColor:[UIColor colorWithRed:219/255.0f green:90/255.0f blue:105/255.0f alpha:1.0f]];
                  cell.statusLabel.text = @"Denied";
                [requestToObject deleteInBackground];
            }

            cell.leftLabel.text = requestToSenderItemPrice;
            
    
    

     PFQuery *productQueryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [productQueryTwo getObjectInBackgroundWithId:requestToReceiverItemID block:^(PFObject *receiverItemObject, NSError *error) {
        if(!error){
              NSLog(@"reciever item object");
            NSLog(@"%@", receiverItemObject);
             NSLog(@"reciever item object");
            PFFile *receiverProImage = [receiverItemObject objectForKey:@"ItemPicture"];
            
            [receiverProImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    cell.rightPicture.image
                    = [UIImage imageWithData:data];
                }
            }];
            
            cell.rightLabel.text = [receiverItemObject objectForKey:@"Title"];
            
            
        }
    }];

    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *tempObject = [requestToArray objectAtIndex:indexPath.row];
    tempInTradingObject = tempObject;
    NSString *requestToSenderItemPrice = [tempObject objectForKey:@"senderPrice"];
    NSString *requestToReceiverItemID = [tempObject objectForKey:@"receiverItem"];
    
    tempRequestToID = tempObject.objectId;
    tempRequestFromID = [tempObject objectForKey:@"requestFromID"];
    NSString *status = [tempObject objectForKey:@"status"];
    
    
    if([status isEqualToString:@"1"]){
   
    
     // [_requestToSenderLabel setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
    _requestToSenderLabel.text = requestToSenderItemPrice;
       
            
        
    PFQuery *productQueryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [productQueryTwo getObjectInBackgroundWithId:requestToReceiverItemID block:^(PFObject *receiverItemObject, NSError *error) {
        if(!error){
            
            PFFile *receiverProImage = [receiverItemObject objectForKey:@"ItemPicture"];
            
            [receiverProImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    _requestToRecieverImage.image
                    = [UIImage imageWithData:data];
                }
            }];
            
            _requestToRecieverLabel.text = [receiverItemObject objectForKey:@"Title"];
                [self animateDetailView];
            
        }
    }];
    
    
    

    
    }
    
    if([status isEqualToString:@"3"]){
        PFQuery *productQuery = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
       
                
                _requestToYourItem.text = requestToSenderItemPrice;
                
        
        PFQuery *productQueryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
        [productQueryTwo getObjectInBackgroundWithId:requestToReceiverItemID block:^(PFObject *receiverItemObject, NSError *error) {
            if(!error){
                
                
                
                
                
                _requestToReceiverItem.text = [receiverItemObject objectForKey:@"Title"];
               
                requestToRecieverTempID = requestToReceiverItemID;
                
            }
        }];
        PFUser *opponent = [tempObject objectForKey:@"receiverID"];
        [opponent fetchIfNeeded];
        NSLog(@"opponentID");
        NSLog(@"%@", opponent);
        NSLog(@"opponentID");
        NSString *check = [opponent objectForKey:@"Name"];
      //  [_requestToReceiverName setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
        _requestToReceiverName.text = [opponent objectForKey:@"Name"];
        otherNameTemp =   _requestToReceiverName.text;
        NSLog(@"%@", check);
        NSLog(@"check:");
        //_requestToReceiverContact.text = [opponent objectForKey:@"ContactNo"];
        PFFile *opponentImage = [opponent objectForKey:@"profilePicture"];
        otherIDTemp = [opponent objectId];
        [opponentImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!error){
                _requestToInTradingReceiverImage.image
                = [UIImage imageWithData:data];
            }
        }];
       keyForChat = [NSString stringWithFormat:@"Cht%@", [tempInTradingObject objectForKey:@"requestFromID"]];
        
        
        PFUser *myObject = [PFUser currentUser];
        userNameTemp = [myObject objectForKey:@"Name"];
        [self animateDetailViewForInTrading];
    }
    
    
    
}

-(void) animateDetailViewForInTrading{
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_requestToInTradingView.frame = CGRectMake(0, 0, 320, 550);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestToInTradingView.frame = CGRectMake(0, 0, 320, 435);
        }];
    }
    
}
-(void) queryParseMethod{
    PFQuery *requestToQuery = [PFQuery queryWithClassName:@"RequestTo"];
    [requestToQuery whereKey:@"senderID" equalTo:[PFUser currentUser]];
    
    
    
    rows = [requestToQuery countObjects];
    
    if(rows == 0){
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.requestToCollection.bounds.size.width, self.requestToCollection.bounds.size.height)];
        
        messageLabel.text = @"No Order Made. Pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        [messageLabel sizeToFit];
        
        self.requestToCollection.backgroundView = messageLabel;
        //self.requestToCollection.separatorStyle = UITableViewCellSeparatorStyleNone;
        [requestToQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                NSLog(@"%@",objects);
                NSLog(@"Query");
                requestToArray = [[NSArray alloc]initWithArray:objects];
                
                [_requestToCollection reloadData];
                [self hideIndicator];
                
            }
            
        }];
        
    }else{
        //_noOrderMadeView.alpha = 0.0;
        self.requestToCollection.backgroundView = nil;
    [requestToQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"%@",objects);
            NSLog(@"Query");
            requestToArray = [[NSArray alloc]initWithArray:objects];
            
            [_requestToCollection reloadData];
            [self hideIndicator];
            
        }
        
    }];
    
    }
    
    
}

-(void) animateDetailView{
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(0, 0, 320, 550);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(0, 0, 320, 435);
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
     requestToList = [NSMutableArray arrayWithObjects:@"requestTo 1",nil];
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
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"goChat"]){
        NSString *key = keyForChat;

        realTimeChattingViewController *destination = [segue destinationViewController];
        destination.chattingKey = key;
        destination.userName =  userNameTemp;
        destination.otherName = otherNameTemp;
          destination.fromWhere = @"requestTo";
       destination.otherFace = _requestToInTradingReceiverImage.image;
        destination.otherID = otherIDTemp;
    }
}
- (IBAction)goBackTwo:(id)sender {
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_requestToInTradingView.frame = CGRectMake(320, 0, 320, 550);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestToInTradingView.frame = CGRectMake(320, 0, 320, 435);
        }];
    }
}

- (IBAction)goBackOne:(id)sender {
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(320, 0, 320, 550);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(320, 0, 320, 435);
        }];
    }
}
- (void)yesTradeCompletedButton {
    
   
    [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(320, 0, 320, 550);
    }];

   
    NSString *key = [NSString stringWithFormat:@"Cht%@", [tempInTradingObject objectForKey:@"requestFromID"]];
    PFQuery *temQuery = [PFQuery queryWithClassName:key];
    [temQuery whereKey:@"status" equalTo:@"1"];
    if([temQuery countObjects] == 0){
        PFObject *object = [temQuery getFirstObject];
        object[@"status"] = @"1";
        [object saveInBackground];
        PFObject *temOb = [PFObject objectWithClassName:key];
        temOb[@"userName"] = @"Uniket";
        temOb[@"textString"] = @"The other party leaves chatting room";
        [temOb saveInBackground];
    }else{
    
        
        PFObject *temOb = [PFObject objectWithClassName:key];
        temOb[@"userName"] = @"Uniket";
        temOb[@"textString"] = @"The other party leaves chatting room";
        temOb[@"status"] = @"Done Trading";
        [temOb saveInBackground];
    }
    [tempInTradingObject deleteInBackground];
   
  
    //[self queryParseMethod];
   // rows--;
    if(iphoneFour == false){
        [ UIView animateWithDuration:0.3 animations:^{_requestToInTradingView.frame = CGRectMake(320, 0, 320, 550);
        }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestToInTradingView.frame = CGRectMake(320, 0, 320, 435);
        }];
    }
    [self showIndicator];
    [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
   // [self performSegueWithIdentifier:@"requestToRefresh" sender:self];
}

- (IBAction)cancelAction:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"RequestFrom"];
    [query getObjectInBackgroundWithId:tempRequestFromID block:^(PFObject *requestFromObject, NSError *error) {
   
   
        [requestFromObject deleteInBackground];
        PFQuery *queryTwo = [PFQuery queryWithClassName:@"RequestTo"];
        [queryTwo getObjectInBackgroundWithId:tempRequestToID block:^(PFObject *requestToObject, NSError *error) {
     
            [requestToObject deleteInBackground];
        }];
        
        if(iphoneFour == false){
            [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(320, 0, 320, 550);
            }];
        }else{
            [ UIView animateWithDuration:0.3 animations:^{_requestToView.frame = CGRectMake(320, 0, 320, 435);
            }];
        }
        [self showIndicator];
        [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
    }];
    
    PFQuery *queryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [queryTwo getObjectInBackgroundWithId:tempSenderItem block:^(PFObject *object, NSError *error) {
        object[@"hide"] = @"0";
        [object saveInBackground];
    }];

    
    
}

- (IBAction)notYetTradeCompletedButton:(id)sender {
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_isTradeCompletedView.frame = CGRectMake(320, 383, 320, 123);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_isTradeCompletedView.frame = CGRectMake(320, 300, 320, 123);
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self yesTradeCompletedButton];
    }else if(buttonIndex == 2){
        
    }
}

- (IBAction)tradeIsCompleted:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Is Trade Completed?"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Yes", @"Not Yet", nil];
    [alert show];
}
- (void)yourButtonClicked:(UIButton*)sender {
      PFObject *tempObject = [requestToArray objectAtIndex:sender.tag];
    tempInTradingObject = tempObject;
    NSString *requestToSenderItemPrice = [tempObject objectForKey:@"senderPrice"];
    NSString *requestToReceiverItemID = [tempObject objectForKey:@"receiverItem"];
    
    tempRequestToID = tempObject.objectId;
    tempRequestFromID = [tempObject objectForKey:@"requestFromID"];
    NSString *status = [tempObject objectForKey:@"status"];
    
    PFQuery *productQuery = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    
    
    _requestToYourItem.text = requestToSenderItemPrice;
    
    
    PFQuery *productQueryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [productQueryTwo getObjectInBackgroundWithId:requestToReceiverItemID block:^(PFObject *receiverItemObject, NSError *error) {
        if(!error){
            
            
            
            
            
            _requestToReceiverItem.text = [receiverItemObject objectForKey:@"Title"];
            
            requestToRecieverTempID = requestToReceiverItemID;
            
        }
    }];
    PFUser *opponent = [tempObject objectForKey:@"receiverID"];
    [opponent fetchIfNeeded];
    NSLog(@"opponentID");
    NSLog(@"%@", opponent);
    NSLog(@"opponentID");
    NSString *check = [opponent objectForKey:@"Name"];
    [_requestToReceiverName setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
    _requestToReceiverName.text = [opponent objectForKey:@"Name"];
    otherNameTemp =   _requestToReceiverName.text;
    NSLog(@"%@", check);
    NSLog(@"check:");
    //_requestToReceiverContact.text = [opponent objectForKey:@"ContactNo"];
    PFFile *opponentImage = [opponent objectForKey:@"profilePicture"];
    otherIDTemp = [opponent objectId];
    [opponentImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error){
            _requestToInTradingReceiverImage.image
            = [UIImage imageWithData:data];
        }
    }];
    keyForChat = [NSString stringWithFormat:@"Cht%@", [tempInTradingObject objectForKey:@"requestFromID"]];
    
    
    PFUser *myObject = [PFUser currentUser];
    userNameTemp = [myObject objectForKey:@"Name"];
    [self performSegueWithIdentifier:@"goChat" sender:self];






}
@end
