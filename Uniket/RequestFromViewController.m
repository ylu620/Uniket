//
//  RequestFromViewController.m
//  Fleem
//
//  Created by Student on 2/13/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "RequestFromViewController.h"
#import "RequestFromCell.h"
#import "realTimeChattingViewController.h"
#import <Parse/Parse.h>
@interface RequestFromViewController (){
    NSMutableArray *requestFromList;
    BOOL iphoneFour;
    
    UIRefreshControl *refreshControl;
}

@end

@implementation RequestFromViewController

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
    self.requestFromCollection.separatorColor=[UIColor clearColor];
    self.requestFromCollection.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableBackground.png"]];
    //image apply
     _requestFromView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"orderRecievedView.png"]];
     _requestFromInTradingView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"InTradingView.png"]];
    
   // _acceptButton.layer.borderWidth = 0.3;
   // _denyButton.layer.borderWidth = 0.3;
   // _doneButton.layer.borderWidth = 0.3;
   // _noOrderReceivedView.alpha = 0.0;
   // _frameViewTwo.layer.borderWidth = 0.3;
   // _frameView.layer.borderWidth = 0.3;
   // _chatButtonOutlet.layer.borderWidth = 0.3;
    _requestFromInTradingOpponentPicture.layer.borderWidth = 0.3;
     _chatButtonOutlet.layer.borderColor = [[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f] CGColor];
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
    [self.requestFromCollection addSubview:refreshControl];
    // Do any additional setup after loading the view.
    requestFromList = [NSMutableArray arrayWithObjects:@"requestTo 1",nil];
   self.navigationItem.hidesBackButton = YES;
   // [self queryParseMethod];
        [self showIndicator];
      [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
}

-(void)viewWillAppear:(BOOL)animated{
    //   self.navigationItem.backBarButtonItem=nil;
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setBadge:0];
    [currentInstallation saveEventually];
      [[UITabBar appearance] setTintColor:[UIColor colorWithRed:173/256.0 green:17/256.0 blue:17/256.0 alpha:1.0]];
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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"goChat"]){
        NSString *key = [NSString stringWithFormat:@"Cht%@",keyForChat ];
        
        realTimeChattingViewController *destination = [segue destinationViewController];
        destination.chattingKey = key;
        destination.userName =  userNameTemp;
        destination.otherName = otherNameTemp;
        destination.fromWhere = @"requestFrom";
        destination.otherFace = _requestFromInTradingOpponentPicture.image;
        destination.otherID = otherIDTemp;
        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RequestFromCell *cell = [tableView dequeueReusableCellWithIdentifier:@"requestFromCell"];
    
    //****Product Data Extraction from DB **********
    //****Product Data Extraction **********
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"requestFromCell.png"]];
    if (cell == nil) {
        cell = [[RequestFromCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"requestFromCell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    PFObject *requestFromoObject = [requestFromArray objectAtIndex:indexPath.row];
    
    NSString *requestToSenderItemPrice = [requestFromoObject objectForKey:@"senderPrice"];
    NSString *requestToReceiverItemID = [requestFromoObject objectForKey:@"receiverItem"];
    
    NSLog(@"%@", requestToReceiverItemID);
    NSLog(@"requestoID");
   
 
    
            
              
    //CHATBUTTON IS ALPHA 0.0 AS USUAL
    cell.chattingButtonOutlet.alpha = 0.0;
    
            NSString *tem = [requestFromoObject objectForKey:@"status"];
            NSLog(@"%@", tem);
            NSLog(@"statusinfo");
            if([tem isEqualToString:@"1"]){
               // cell.status.image = [UIImage imageNamed:@"left.png"];
                [cell.statusLabel setTextColor:[UIColor blackColor]];
                cell.statusLabel.text = @"Pending";
            }else if([tem isEqualToString:@"3"]){
              //  cell.status.image = [UIImage imageNamed:@"check.png"];
                [cell.statusLabel setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
                 cell.statusLabel.text = @"In Trading";
                cell.chattingButtonOutlet.alpha = 1.0;
                cell.chattingButtonOutlet.tag = indexPath.row;
                [cell.chattingButtonOutlet addTarget:self action:@selector(yourButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
            }
                  cell.rightLabel.text = requestToSenderItemPrice;
         
            
    
    PFQuery *productQueryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
    [productQueryTwo getObjectInBackgroundWithId:requestToReceiverItemID block:^(PFObject *receiverItemObject, NSError *error) {
        if(!error){
            NSLog(@"reciever item object");
            NSLog(@"%@", receiverItemObject);
            NSLog(@"reciever item object");
            PFFile *receiverProImage = [receiverItemObject objectForKey:@"ItemPicture"];
            
            [receiverProImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    cell.leftImage.image
                    = [UIImage imageWithData:data];
                }
            }];
            
            cell.leftLabel.text = [receiverItemObject objectForKey:@"Title"];
            
            
        }
    }];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *tempObject = [requestFromArray objectAtIndex:indexPath.row];
    tempInTradingObject = tempObject;
    NSString *requestToSenderItemPrice = [tempObject objectForKey:@"senderPrice"];
    NSString *requestToReceiverItemID = [tempObject objectForKey:@"receiverItem"];
    
    requestFromYourTempID = requestToReceiverItemID;
    tempRequestFromID = tempObject.objectId;
   
    NSString *status = [tempObject objectForKey:@"status"];
    
    
    //if Status is 'waiting = 1'
    if([status isEqualToString:@"1"]){

          
                
               [_requestFromSenderLabel setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
        
        
               
                     _requestFromSenderLabel.text = requestToSenderItemPrice;
            _requestFromSenderDescription.text =  [tempObject objectForKey:@"Comment"];
    
            
        
        
        PFQuery *productQueryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
        [productQueryTwo getObjectInBackgroundWithId:requestToReceiverItemID block:^(PFObject *receiverItemObject, NSError *error) {
            if(!error){
                
                PFFile *receiverProImage = [receiverItemObject objectForKey:@"ItemPicture"];
                tempReceiverItem = requestToReceiverItemID;
                [receiverProImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if(!error){
                        _requestFromReceiverImage.image
                        = [UIImage imageWithData:data];
                    }
                }];
                
                _requestFromReceiverLabel.text = [receiverItemObject objectForKey:@"Title"];
                
                [self animateDetailView];
            }
        }];
  
   

       
   

    
    
    }
    
    // if status is 'Accepted' (3)
    else if([status isEqualToString:@"3"]){
    
       
                
                  _requestFromInTradingOpponentItem.text = requestToSenderItemPrice;
                 [_requestFromInTradingOpponentItem setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
                                    
                
        
        PFQuery *productQueryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
        [productQueryTwo getObjectInBackgroundWithId:requestToReceiverItemID block:^(PFObject *receiverItemObject, NSError *error) {
            if(!error){
                
               
                
              
                tempReceiverItemObject = receiverItemObject;
                _requestFromInTradingYourItem.text = [receiverItemObject objectForKey:@"Title"];
                
                
            }
        }];
        PFUser *opponent = [tempObject objectForKey:@"senderID"];
         [opponent fetchIfNeeded];
   
        NSString *check = [opponent objectForKey:@"Name"];
        otherNameTemp = check;
        
        _requestFromInTradingOpponentName.text = [opponent objectForKey:@"Name"];
        otherIDTemp =  [opponent objectId];
        NSLog(@"%@", check);
        NSLog(@"check:");
      //  _requestFromInTradingOpponentContact.text = [opponent objectForKey:@"ContactNo"];
        PFFile *opponentImage = [opponent objectForKey:@"profilePicture"];
        [opponentImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!error){
                _requestFromInTradingOpponentPicture.image
                = [UIImage imageWithData:data];
            }
        }];
        keyForChat = tempObject.objectId;
        PFUser *myObject = [PFUser currentUser];
        userNameTemp = [myObject objectForKey:@"Name"];
        [self animateDetailViewForInTrading];
    }
}

-(void) queryParseMethod{
    PFQuery *requestFromQuery = [PFQuery queryWithClassName:@"RequestFrom"];
    [requestFromQuery whereKey:@"receiverID" equalTo:[PFUser currentUser]];
    
    rows = [requestFromQuery countObjects];
    if(rows == 0){
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.requestFromCollection.bounds.size.width, self.requestFromCollection.bounds.size.height - 100)];
        
        messageLabel.text = @"No Order Received. Pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        [messageLabel sizeToFit];
        
        self.requestFromCollection.backgroundView = messageLabel;
       // self.requestFromCollection.separatorStyle = UITableViewCellSeparatorStyleNone;
        [requestFromQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                NSLog(@"%@",objects);
                NSLog(@"Query");
                requestFromArray = [[NSArray alloc]initWithArray:objects];
                [_requestFromCollection reloadData];
                [self hideIndicator];
                
            }
            
        }];
        //[self hideIndicator];
    }else{
        self.requestFromCollection.backgroundView = nil;
    [requestFromQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"%@",objects);
            NSLog(@"Query");
            requestFromArray = [[NSArray alloc]initWithArray:objects];
                        [_requestFromCollection reloadData];
            [self hideIndicator];
            
        }
        
    }];
    
    }
    
    
}

-(void) animateDetailView{
    if(iphoneFour == false){
   [ UIView animateWithDuration:0.3 animations:^{_requestFromView.frame = CGRectMake(0, 0, 320, 519);
  }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestFromView.frame = CGRectMake(0, 0, 320, 435);
        }];
    }
    
}
-(void) animateDetailViewForInTrading{
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_requestFromInTradingView.frame = CGRectMake(0, 0, 320, 519);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestFromInTradingView.frame = CGRectMake(0, 0, 320, 435);
        }];
    }
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





- (IBAction)requestFromAccept:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"RequestFrom"];
    firstFive = @"00";
    [query getObjectInBackgroundWithId:tempRequestFromID block:^(PFObject *requestFromObject, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        requestFromObject[@"status"] = @"3";
        tempRequestToID = [requestFromObject objectForKey:@"requestToID"];
        NSLog(@"%@" ,tempRequestToID);
        NSLog(@"requestToInfos");
        
        //chatting room creation
      
 
        NSString *key = [NSString stringWithFormat:@"Cht%@", requestFromObject.objectId];
   
        PFObject *keyObject = [PFObject objectWithClassName:key];
        keyObject[@"userName"] = @"Uniket";
         keyObject[@"textString"] = @"Have a good trade!";
        keyObject[@"status"] = @"0";
        [keyObject saveInBackground];
        
        //chattingroom created
        [requestFromObject saveInBackground];
        PFQuery *queryTwo = [PFQuery queryWithClassName:@"RequestTo"];
        [queryTwo getObjectInBackgroundWithId:tempRequestToID block:^(PFObject *requestToObject, NSError *error) {
            NSLog(@"%@" ,requestToObject);
            NSLog(@"requestToInfo");
            // Do something with the returned PFObject in the gameScore variable.
            requestToObject[@"status"] = @"3";
            
          
           
          
            [requestToObject saveInBackground];
            
           
            
            @try{
            PFUser *opponent = [requestToObject objectForKey:@"senderID"];
            [opponent fetchIfNeeded];
            PFQuery *pushQuery = [PFInstallation query];
            [pushQuery whereKey:@"objectId" equalTo:[ opponent objectForKey:@"installID"]]; // Set channel
                  NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:@"The seller has accepted your offer", @"alert",@"Increment",@"badge", nil];
            PFPush *push = [[PFPush alloc] init];
            [push setQuery:pushQuery];
//            [push setMessage:@"The seller has accepted your offer"];
                [push setData:data];
            [push sendPushInBackground];
            }@catch(NSException *e){
                
            }
        }];
    }];
   
   
    
    
    PFQuery *queryReceiver = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
    [queryReceiver getObjectInBackgroundWithId:tempReceiverItem block:^(PFObject *object, NSError *error) {
        
        object[@"hide"] = @"1";
        
        [object saveInBackground];
    }];

    //delete all other items related to this one
     PFQuery *queryTwo = [PFQuery queryWithClassName:@"RequestFrom"];
    if(iphoneFour == false){
        [ UIView animateWithDuration:0.3 animations:^{_requestFromView.frame = CGRectMake(320, 0, 320, 519);
        }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestFromView.frame = CGRectMake(320, 0, 320, 435);
        }];
    }
    
    
    [self showIndicator];
    [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
    
    
    [queryTwo whereKey:@"receiverItem" equalTo:tempReceiverItem];
    [queryTwo whereKey:@"objectId" notEqualTo:tempRequestFromID];
    [queryTwo findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSInteger num = [objects count];
        PFObject *tempob;
        NSString *tempOppo;
        PFQuery *tempquery;
        for(int i = 0; i<num; i++){
            tempob = [objects objectAtIndex:i];
            tempOppo = [tempob objectForKey:@"requestToID"];
            tempquery = [PFQuery queryWithClassName:@"RequestTo"];
            [tempquery getObjectInBackgroundWithId:tempOppo block:^(PFObject *object, NSError *error) {
                object[@"status"] = @"2";
                PFQuery *tempItemQuery = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
                NSString *tempItemID = [object objectForKey:@"senderItem"];
                [tempItemQuery getObjectInBackgroundWithId:tempItemID block:^(PFObject *object2, NSError *error) {
                    object2[@"hide"] = @"0";
                    [object2 saveInBackground];
                }];
                [object saveInBackground];
            }];
            
            [tempob deleteInBackground];
            
        }
        
    }];
    
    [super viewDidLoad];
}

- (void)yesTradeCompletedButton{
    
   
//[ UIView animateWithDuration:0.5 animations:^{_requestFromView.frame = CGRectMake(320, 0, 320, 506);
   // }];
    NSString *key = [NSString stringWithFormat:@"Cht%@", tempInTradingObject.objectId];
    PFQuery *temQuery = [PFQuery queryWithClassName:key];
    NSLog(@"%@",key);
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
    PFQuery *productQuery = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
    [productQuery getObjectInBackgroundWithId:requestFromOppoTempID block:^(PFObject *senderProductObject, NSError *error) {
        if(!error){
            
            if([[senderProductObject objectForKey:@"hide"] isEqualToString:@"3"]){
                  [tempReceiverItemObject deleteInBackground];
                [senderProductObject deleteInBackground];
            }else{
                tempReceiverItemObject[@"hide"] = @"3";
                [tempReceiverItemObject saveInBackground];
            }
        }
    }];
  
   // [self queryParseMethod];
   //  rows--;
    
    if(iphoneFour == false){
        [ UIView animateWithDuration:0.3 animations:^{_requestFromInTradingView.frame = CGRectMake(320, 0, 320, 519);
        }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestFromInTradingView.frame = CGRectMake(320, 0, 320, 435);
        }];
    }
    [self showIndicator];
    [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
   //  [self performSegueWithIdentifier:@"requestFromRefresh" sender:self];
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


- (IBAction)requestFromDeny:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"RequestFrom"];
    [query getObjectInBackgroundWithId:tempRequestFromID block:^(PFObject *requestFromObject, NSError *error) {
       
         tempRequestToID = [requestFromObject objectForKey:@"requestToID"];
        PFQuery *queryTwo = [PFQuery queryWithClassName:@"RequestTo"];
        [queryTwo getObjectInBackgroundWithId:tempRequestToID block:^(PFObject *requestToObject, NSError *error) {
            NSLog(@"%@" ,requestToObject);
            NSLog(@"requestToInfo");
            // Do something with the returned PFObject in the gameScore variable.
            requestToObject[@"status"] = @"2";
            [requestToObject saveInBackground];
        }];
        
        [requestFromObject deleteInBackground];
    }];
    
    PFQuery *queryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
    [queryTwo getObjectInBackgroundWithId:tempSenderItem block:^(PFObject *object, NSError *error) {
        
        object[@"hide"] = @"0";
        
        [object saveInBackground];
        if(iphoneFour == false){
            [ UIView animateWithDuration:0.3 animations:^{_requestFromView.frame = CGRectMake(320, 0, 320, 519);
            }];
        }else{
            [ UIView animateWithDuration:0.3 animations:^{_requestFromView.frame = CGRectMake(320, 0, 320, 435);
            }];
        }
        [self showIndicator];
        [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
    }];

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
- (IBAction)goBackThree:(id)sender {
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_requestFromView.frame = CGRectMake(320, 0, 320, 519);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestFromView.frame = CGRectMake(320, 0, 320, 435);
        }];
    }
}

- (IBAction)goBackTwo:(id)sender {
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_requestFromInTradingView.frame = CGRectMake(320, 0, 320, 519);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_requestFromInTradingView.frame = CGRectMake(320, 0, 320, 435);
        }];
    }
}


- (void)yourButtonClicked:(UIButton*)sender {
    PFObject *tempObject = [requestFromArray objectAtIndex:sender.tag];
    tempInTradingObject = tempObject;
    NSString *requestToSenderItemPrice = [tempObject objectForKey:@"senderPrice"];
    NSString *requestToReceiverItemID = [tempObject objectForKey:@"receiverItem"];
    
    requestFromYourTempID = requestToReceiverItemID;
    tempRequestFromID = tempObject.objectId;
    
    NSString *status = [tempObject objectForKey:@"status"];
    
    _requestFromInTradingOpponentItem.text = requestToSenderItemPrice;
    [_requestFromInTradingOpponentItem setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
    
    
    
    PFQuery *productQueryTwo = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
    [productQueryTwo getObjectInBackgroundWithId:requestToReceiverItemID block:^(PFObject *receiverItemObject, NSError *error) {
        if(!error){
            
            
            
            
            tempReceiverItemObject = receiverItemObject;
            _requestFromInTradingYourItem.text = [receiverItemObject objectForKey:@"Title"];
            
            
        }
    }];
    PFUser *opponent = [tempObject objectForKey:@"senderID"];
    [opponent fetchIfNeeded];
    
    NSString *check = [opponent objectForKey:@"Name"];
    otherNameTemp = check;
    
    _requestFromInTradingOpponentName.text = [opponent objectForKey:@"Name"];
    otherIDTemp =  [opponent objectId];
    NSLog(@"%@", check);
    NSLog(@"check:");
    //  _requestFromInTradingOpponentContact.text = [opponent objectForKey:@"ContactNo"];
    PFFile *opponentImage = [opponent objectForKey:@"profilePicture"];
    [opponentImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error){
            _requestFromInTradingOpponentPicture.image
            = [UIImage imageWithData:data];
        }
    }];
    keyForChat = tempObject.objectId;
    PFUser *myObject = [PFUser currentUser];
    userNameTemp = [myObject objectForKey:@"Name"];
    
    
    
    
    
    [self performSegueWithIdentifier:@"goChat" sender:self];
    
    
    
    
    
    
}
@end
