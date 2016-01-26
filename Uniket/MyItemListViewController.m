//
//  MyItemListViewController.m
//  Fleem
//
//  Created by Jun Suh Lee on 2/12/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "MyItemListViewController.h"
#import "MyItemListEditViewController.h"
#import "PickerView.h"
#import "DataObject.h"
#import <Parse/Parse.h>
@interface MyItemListViewController (){
    NSMutableArray *productArray;
    BOOL iphoneFour;
    
    UIRefreshControl *refreshControl;
}

@end

@implementation MyItemListViewController
//- (id)init {
//    self = [super initWithNibName:@"MyNibName" bundle:nil];
//    if (self) {
//              [[self tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"myItem.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"myItemClicked.png"]];
//    }
//    return self;
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"editMyItem"]){
        NSString *id = tempID;
        PickerView *myItemEdit = [segue destinationViewController];
        myItemEdit.editID = id;
        myItemEdit.editing = @"True";
    }else if([segue.identifier isEqualToString:@"addNewItemNormal"]){
          NSString *determine = @"fromNormal";
        PickerView *myPicerView = [segue destinationViewController];
        myPicerView.determineString = determine;
        
    }else if([segue.identifier isEqualToString:@"addNewItemInProcess"]){
        NSString *determine = @"fromInProcess";
        PickerView *myPicerView = [segue destinationViewController];
        myPicerView.determineString = determine;
        myPicerView.tempOwnerID = _ownerID;
        myPicerView.tempOwnerItemID = _ownerItemID;
      
        
    }
}

-(void) viewWillAppear:(BOOL)animated{
     // [[UITabBar appearance] setTintColor:[UIColor redColor]];
    
    [self.tabBarController.tabBar setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height  - 49, 320, 49)];
    optionSingle = [DataObject dataObjects];
    if([optionSingle.submittedFromPickerView isEqualToString:@"True"]){
        [self showIndicator];
        [scroller setScrollEnabled:YES];
        [scroller setContentSize:CGSizeMake(320, 800)];
        //_editButton.layer.borderWidth = 0.3;
        _backbuttonLogo.alpha =0.0;
        //_deleteButton.layer.borderWidth = 0.3;
        //_confirmButton.layer.borderWidth = 0.3;
        
        
     //   _noItemsPostedView.alpha = 0.0;
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
        
        if(_fromHome == true){
            // _itemPictureInProcess.image = _itemPicture;
            _itemTitleInProcess.text = _itemName;
            itemBargainInProcess.delegate = self;
            itemBargainInProcess.editable = true;
            _itemPriceInProcess.text = [NSString stringWithFormat:@"%@", _itemPrice];
        }
        self.navigationItem.hidesBackButton = YES;
        // Do any additional setup after loading the view.
        productArray = [NSMutableArray arrayWithObjects:@"Product 1",@"Product 2",@"Product 3",@"Product 4", nil];
        
        optionSingle.submittedFromPickerView = @"False";
        
       
        [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
        if(iphoneFour == false){
            [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(320, 0, 320, 506);
            }];
        }else{
            [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(320, 0, 320, 428);
            }];
        }
        [UIView animateWithDuration:1.0 animations:^{_backbuttonLogo.alpha = 0.0;} completion:^(BOOL finished){
            
        }];
    }
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
- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Begin editing");
    if(iphoneFour == false){
        CGRect view = _requestConfirmView.frame;
        view.origin.x = 0;
        view.origin.y = -50;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _requestConfirmView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _requestConfirmView.frame;
        view.origin.x = 0;
        view.origin.y = -70;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _requestConfirmView.frame = view;
        
        [UIView commitAnimations];
    }
    
    
}
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch =  [touches anyObject];
    
    if([touch view] == _requestConfirmView)
    {
        [[self view] endEditing:YES];
        [[self view] endEditing:YES];
        CGRect view = _requestConfirmView.frame;
        view.origin.x = 0;
        view.origin.y = 0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _requestConfirmView.frame = view;
        
        [UIView commitAnimations];

    }
}

-(void) refreshTable{
    [self queryParseMethod];
    [refreshControl endRefreshing];
}
- (void)viewDidLoad
{
   // _indicatorView.alpha = 0.0;
    
    [super viewDidLoad];
    [self showIndicator];
    //image apply
    scroller.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"myItemDetail.png"]];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 800)];
    //_editButton.layer.borderWidth = 0.3;
    _backbuttonLogo.alpha =0.0;
    //_deleteButton.layer.borderWidth = 0.3;
    //_confirmButton.layer.borderWidth = 0.3;
   
   
        _noItemsPostedView.alpha = 0.0;
    
    refreshControl = [[UIRefreshControl alloc] init];
    
    
     [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self.myItemListCollection addSubview:refreshControl];
   
   
    
    
    
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
   
    if(iphoneFour == true){
        [scroller setContentInset:UIEdgeInsetsMake(0,0 , 350, 0)];
    }
    
    if(_fromHome == true){
       // _itemPictureInProcess.image = _itemPicture;
        _itemTitleInProcess.text = _itemName;
        itemBargainInProcess.delegate = self;
        itemBargainInProcess.editable = true;
        _itemPriceInProcess.text = [NSString stringWithFormat:@"%@", _itemPrice];
    }
    self.navigationItem.hidesBackButton = YES;
    // Do any additional setup after loading the view.
     productArray = [NSMutableArray arrayWithObjects:@"Product 1",@"Product 2",@"Product 3",@"Product 4", nil];
   [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
   //[self queryParseMethod];
  
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return rows;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myitemcell"];
    
    //****Product Data Extraction from DB **********
    //****Product Data Extraction **********
    
     cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"myItemCell.png"]];
    
    
    @try{
    PFObject *myItemImageObject = [myItemImageArray objectAtIndex:indexPath.row];
    
    PFFile *myItemImageFile = [myItemImageObject objectForKey:@"ItemPicture"];
    
    PFObject *myItemTitleObject = [myItemTitleArray objectAtIndex:indexPath.row];
  
    if([[myItemTitleObject objectForKey:@"hide"] isEqualToString:@"0"] || [[myItemTitleObject objectForKey:@"hide"] isEqualToString:@"1"] ){
    [myItemImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error){
            cell.myItemImage.image = [UIImage imageWithData:data];
        }
    }];
    
    
    if (cell == nil) {
        cell = [[MyItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myitemcell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.myItemTitle.text = [myItemTitleObject objectForKey:@"Title"];
    
    if([[myItemTitleObject objectForKey:@"hide"] isEqualToString:@"0"]){
        
        [cell.myItemStatus setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
        cell.myItemStatus.text = @"Available to Trade";
         [cell.normalMyItemStatus setTextColor:[UIColor colorWithRed:90/255.0f green:219/255.0f blue:155/255.0f alpha:1.0f]];
        cell.normalMyItemStatus.text = @"Listed";
    }else if([[myItemTitleObject objectForKey:@"hide"] isEqualToString:@"1"]){
          [cell.myItemStatus setTextColor:[UIColor colorWithRed:219/255.0f green:90/255.0f blue:105/255.0f alpha:1.0f]];
         cell.myItemStatus.text = @"Unavailable to Trade";
        
        cell.normalMyItemStatus.text = @"In Trading";
    }
  
 
        
    }else if([[myItemTitleObject objectForKey:@"hide"] isEqualToString:@"2"]){
        [myItemImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if(!error){
                cell.myItemImage.image = [UIImage imageWithData:data];
            }
        }];
        
        
        if (cell == nil) {
            cell = [[MyItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myitemcell"];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
        cell.myItemTitle.text = [myItemTitleObject objectForKey:@"Title"];
        
       
            
            [cell.myItemStatus setTextColor:[UIColor colorWithRed:240/255.0f green:217/255.0f blue:72/255.0f alpha:1.0f]];
        [cell.normalMyItemStatus setTextColor:[UIColor colorWithRed:240/255.0f green:217/255.0f blue:72/255.0f alpha:1.0f]];
            cell.myItemStatus.text = @"Expired, Click to reload";
        cell.normalMyItemStatus.text = @"Expired, Click to reload";
             //  NSLog(@"%@", _targetType);
      
    }
    }@catch(NSException *n){
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    scroller.contentOffset = CGPointMake(0, 0 - scroller.contentInset.top);
    PFObject *tempObject = [myItemImageArray objectAtIndex:indexPath.row];
    if(![[tempObject objectForKey:@"hide"] isEqualToString:@"2"]){
    PFFile *imageFile = [tempObject objectForKey:@"ItemPicture"];
    _myItemDetailTitle.text = [tempObject objectForKey:@"Title"];
    _myItemDetailDescription.text = [tempObject objectForKey:@"Description"];
    tempID = tempObject.objectId;
    tempStatus = [tempObject objectForKey:@"hide"];
    
    tempUserID = [tempObject objectForKey:@"createdBy"];
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        
        if(!error){
            _myItemDetailImage.image =[UIImage imageWithData:data];
            if([[tempObject objectForKey:@"numOfPicture"] isEqualToString:@"2"]){
                PFFile *imageFileTwo = [tempObject objectForKey:@"ItemPictureTwo"];
                [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    _myItemDetailImageTwo.image =[UIImage imageWithData:data];
                }];
                _myItemDetailImageThree.image = nil;
            }else if([[tempObject objectForKey:@"numOfPicture"] isEqualToString:@"3"]){
                  PFFile *imageFileTwo = [tempObject objectForKey:@"ItemPictureTwo"];
                  PFFile *imageFileThree = [tempObject objectForKey:@"ItemPictureThree"];
                [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    _myItemDetailImageTwo.image =[UIImage imageWithData:data];
                }];
                [imageFileThree getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    _myItemDetailImageThree.image =[UIImage imageWithData:data];
                }];
            }else{
                 _myItemDetailImageThree.image = nil;
                 _myItemDetailImageTwo.image = nil;
            }
        }
    }];
        _myItemDetailType.text = [tempObject objectForKey:@"Type"];
        _myItemDetailWish.text = [NSString stringWithFormat:@"%@%@", [tempObject objectForKey:@"Price"], @"$"];
               _finalMyItemLabel.text = _myItemDetailTitle.text;
        PFQuery *opponentProduct = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
  
        [opponentProduct getObjectInBackgroundWithId:_ownerItemID block:
        ^(PFObject *object, NSError *error) {
            _finalOpponentLabel.text = [object objectForKey:@"Title"];
            chcker = [object objectForKey:@"hide"];
        }];
   
    [self animateDetailView];
    }else{
        tempID = tempObject.objectId;
          [self animateReloadView];
    }

}


-(void) queryParseMethod{
    PFUser *currentUser = [PFUser currentUser];
    if([[[currentUser objectForKey:@"username"] substringWithRange:NSMakeRange([[currentUser objectForKey:@"username"] length] - 7, 7)] isEqualToString:@"ivc.edu"]){
        scopeIdentifier = @"IVC";
    }else{
        scopeIdentifier = @"";
    }
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [query whereKey:@"createdBy" equalTo:[PFUser currentUser]];
    [query whereKey:@"hide" notEqualTo:@"3"];
    rows = [query countObjects];
    if(rows == 0){
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No Item Posted Yet. Click + to post or Pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        [messageLabel sizeToFit];
        
        self.myItemListCollection.backgroundView = messageLabel;
       // self.myItemListCollection.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self hideIndicator];
    }else{
        
        
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"%@",objects);
            myItemImageArray = [[NSArray alloc] initWithArray:objects];
            myItemTitleArray = [[NSArray alloc] initWithArray:objects];
            [_myItemListCollection reloadData];
              [self hideIndicator];
        }
        
    }];
    }
     [self hideIndicator];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void) animateDetailView{
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(0, 0, 320, 506);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(0, 0, 320, 428);
        }];
    }
    [UIView animateWithDuration:1.0 animations:^{_backbuttonLogo.alpha = 1.0;} completion:^(BOOL finished){
        
    }];
    
}
-(void) animateReloadView{
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_reloadItemViewInProcess.frame = CGRectMake(0, 0, 320, 530);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_reloadItemViewInProcess.frame = CGRectMake(0, 0, 320, 435);
        }];
    }
    
}

- (IBAction)sendRequest:(id)sender {
    [self showIndicator];
    
    if([itemBargainInProcess.text isEqualToString:nil]){
        itemBargainInProcess.text = @"";
    }
     
    
        
    PFObject *requestToObject = [PFObject objectWithClassName:@"RequestTo"];
    PFObject *requestFromObject = [PFObject objectWithClassName:@"RequestFrom"];
    PFUser *user = [PFUser currentUser];
  
    requestToObject[@"senderID"] = user;
    requestToObject[@"senderPrice"] = _itemPriceInProcess.text;
    requestToObject[@"receiverID"] = _ownerID;
    requestToObject[@"receiverItem"] = _ownerItemID;
    requestToObject[@"status"] = @"1";
    requestToObject[@"Comment"] = itemBargainInProcess.text;
    requestToObject[@"senderPrice"] = _itemPrice;

 
    requestFromObject[@"senderID"] = user;
    requestFromObject[@"senderPrice"] = _itemPriceInProcess.text;
    requestFromObject[@"receiverID"] = _ownerID;
    requestFromObject[@"receiverItem"] = _ownerItemID;
    requestFromObject[@"Comment"] = itemBargainInProcess.text;
    requestFromObject[@"status"] = @"1";
      requestFromObject[@"senderPrice"] = _itemPrice;

    [requestToObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
      
            tempToID = requestToObject.objectId;
            [requestFromObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    // The object has been saved.
                    tempFromID = requestFromObject.objectId;
                    // tempFromID = requestFromObject.objectId;
                    requestToObject[@"requestFromID"] = tempFromID;
                     requestFromObject[@"requestToID"] = tempToID;
                    [requestToObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                        
                    }];
                    [requestFromObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {}];
                    [self performSegueWithIdentifier:@"requestSuccess" sender:self];
                } else {
                    // There was a problem, check error.description
                }
            }];

        } else {
          //  NSLog(@"%@",requestToObject.objectId) ;
           
        }
    }];
    
    
    
    @try{
    PFUser *opponent = [requestFromObject objectForKey:@"receiverID"];
    [opponent fetchIfNeeded];
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"objectId" equalTo:[ opponent objectForKey:@"installID"]]; // Set channel
        NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:@"Someone would like to buy your item", @"alert",@"Increment",@"badge", nil];
    PFPush *push = [[PFPush alloc] init];
    [push setQuery:pushQuery];
        [push setData:data];
  //  [push setMessage:@"Someone would like to buy your item"];
    [push sendPushInBackground];
    
        
    }@catch (NSException *e){
        
    }
    optionSingle = [DataObject dataObjects];
    optionSingle.requestConfirmed = @"True";
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self hideIndicator];
        
}

- (IBAction)deleteItem:(id)sender {
    [self showIndicator];
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [query getObjectInBackgroundWithId:tempID block:^(PFObject *deletedObject, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", deletedObject);
        
        if([[deletedObject objectForKey:@"hide"] isEqualToString:@"1"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Unavailable" message:@"This item is in trading or waiting status. Please cancel it first." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
           

        }else if([[deletedObject objectForKey:@"hide"] isEqualToString:@"0"]){
        [deletedObject deleteInBackground];
            if(iphoneFour == false){
                [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(320, 0, 320, 506);
                }];
            }else{
                [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(320, 0, 320, 428);
                }];
            }
         [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
      //   [self queryParseMethod];
        }
    }];
    [self hideIndicator];
}

- (IBAction)goBack:(id)sender {
    if(iphoneFour == false){
        [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(320, 0, 320, 506);
        }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(320, 0, 320, 428);
        }];
    }
    [UIView animateWithDuration:1.0 animations:^{_backbuttonLogo.alpha = 0.0;} completion:^(BOOL finished){
        
    }];
}

- (IBAction)backAction:(id)sender {
    if(iphoneFour == false){
        [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(320, 0, 320, 506);
        }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_myItemDetailView.frame = CGRectMake(320, 0, 320, 428);
        }];
    }
}

- (IBAction)addMyItem:(id)sender {
    [self performSegueWithIdentifier:@"addNewItemNormal" sender:self];
}
- (IBAction)addMyItemInProcess:(id)sender {
    
    [self performSegueWithIdentifier:@"addNewItemInProcess" sender:self];
}



- (IBAction)deleteItemInProcess:(id)sender {
    [self showIndicator];
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [query getObjectInBackgroundWithId:tempID block:^(PFObject *deletedObject, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", deletedObject);
        
        [deletedObject deleteInBackground];
            //   [self queryParseMethod];
        if(iphoneFour == false){
            [ UIView animateWithDuration:0.3 animations:^{_reloadItemViewInProcess.frame = CGRectMake(320, 0, 320, 506);
            }];
        }else{
            [ UIView animateWithDuration:0.3 animations:^{_reloadItemViewInProcess.frame = CGRectMake(320, 0, 320, 435);
            }];
        }
        [self showIndicator];
        [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
    }];
   // [self hideIndicator];
}

- (IBAction)backReloadItemInProcess:(id)sender {
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_reloadItemViewInProcess.frame = CGRectMake(320, 0, 320, 530);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_reloadItemViewInProcess.frame = CGRectMake(320, 0, 320, 428);
        }];
    }
}

- (IBAction)reloadItemInProcess:(id)sender {
    [self showIndicator];
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [query getObjectInBackgroundWithId:tempID block:^(PFObject *deletedObject, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", deletedObject);
        
        deletedObject[@"hide"] = @"0";
    
            
            
 
            [deletedObject saveInBackground];
        if(iphoneFour == false){
            [ UIView animateWithDuration:0.3 animations:^{_reloadItemViewInProcess.frame = CGRectMake(320, 0, 320, 506);
            }];
        }else{
            [ UIView animateWithDuration:0.3 animations:^{_reloadItemViewInProcess.frame = CGRectMake(320, 0, 320, 435);
            }];
        }
            //   [self queryParseMethod];
        [self showIndicator];
               [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
    }];
    
 //   [self hideIndicator];
}
- (IBAction)goBackToHomeTwo:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)goBackToHome:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)editMyItem:(id)sender {
    
    [self performSegueWithIdentifier:@"editMyItem" sender:self];
}
@end
