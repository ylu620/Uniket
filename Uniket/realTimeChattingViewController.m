//
//  realTimeChattingViewController.m
//  Fleem
//
//  Created by Jun Suh Lee on 3/6/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "realTimeChattingViewController.h"
#import "realTimeChattingCell.h"
@interface realTimeChattingViewController (){
    BOOL chatSending;
}

@end

@implementation realTimeChattingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    chatSending = false;
       _indicatorView.alpha = 0.0;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if ([[UIScreen mainScreen] bounds].size.height<490.0f)
        {
            NSLog(@"App is running on iPhone with screen 3.5 inch");
            CGRect frame = chatTable.frame;
            frame.size.height = 160;
            chatTable.frame = frame;
            tfEntry.frame = CGRectMake(11, 230, 242, 30);
            _sendButton.frame = CGRectMake(256, 230, 64, 30);
        }
        else
        {
            NSLog(@"App is running on iPhone with screen 4.0 inch");
       
        }
    }
    tfEntry.delegate = self;
    tfEntry.autocorrectionType = UITextAutocorrectionTypeNo;
    // Do any additional setup after loading the view.

    _otherNameLabel.text = _otherName;
    chattingHeader.text = [NSString stringWithFormat:@"Chatting with %@", _otherName];
    [self queryParseMethod];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(checker) userInfo:nil
                                    repeats:YES];
 
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0) {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
    myTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(updating) userInfo:nil
                                    repeats:YES];
}
-(void) viewWillAppear:(BOOL)animated{
    [tfEntry becomeFirstResponder];
}
-(void) updating{
    if(chatSending == false){
        [self queryParseMethod];
    }
}
-(void) checker{
    if(tfEntry.text.length > 100){
        tfEntry.text = [tfEntry.text substringToIndex:100];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return rows;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    realTimeChattingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chatCell"];
    
    //****Product Data Extraction from DB **********
    //****Product Data Extraction **********
    
    
    PFObject *chatObject = [chatData objectAtIndex:indexPath.row];

    
    
    
    
        
        if (cell == nil) {
            cell = [[realTimeChattingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chatCell"];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            
        }
    NSString *nameCheck = [chatObject objectForKey:@"userName"];
    
    if([nameCheck isEqualToString:_userName]){
        cell.myUserName.text = nameCheck;
        cell.userName.text = @"";
        cell.textString.textAlignment = NSTextAlignmentRight;
           cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chatCell.png"]];
    }else{
        
        cell.userName.text= nameCheck;
            cell.myUserName.text = @"";
          cell.textString.textAlignment = NSTextAlignmentLeft;
           cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chatCellTwo.png"]];
    }
         cell.timeLabel.text= [chatObject objectForKey:@"createdAt"];
        cell.textString.text =[chatObject objectForKey:@"textString"];
    
  
    
    return cell;
}
-(void) queryParseMethod{
    PFQuery *query = [PFQuery queryWithClassName:_chattingKey];
 
    rows = [query countObjects];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            NSLog(@"%@",objects);
//            if(rows > 30){
//            objects= [objects subarrayWithRange: NSMakeRange( [objects count] - 30 , 30 )];
//                rows = 30;
//            }
            chatData = [[NSArray alloc] initWithArray:objects];
            [chatTable reloadData];
            if (chatTable.contentSize.height > chatTable.frame.size.height)
            {
                CGPoint offset = CGPointMake(0, chatTable.contentSize.height -     chatTable.frame.size.height);
                [chatTable setContentOffset:offset animated:YES];
            }
        }
        
    }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated{
    [myTimer invalidate];
}

- (IBAction)sendButton:(id)sender {
    [self showIndicator];
    chatSending = true;
    if([tfEntry.text isEqualToString:@""]){
        
    }else{
    PFObject *chatObject = [PFObject objectWithClassName:_chattingKey];
    chatObject[@"userName"] = _userName;
    chatObject[@"textString"] = tfEntry.text;
   
    [chatObject saveInBackground];
        [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.3];
    }
    @try{
        PFQuery *query = [PFUser query];
        [query whereKey:@"objectId" equalTo:_otherID]; // find all the women
        NSArray *user = [query findObjects];
        PFUser *opponent = [user objectAtIndex:0];
        [opponent fetchIfNeeded];
        PFQuery *pushQuery = [PFInstallation query];
        [pushQuery whereKey:@"objectId" equalTo:[ opponent objectForKey:@"installID"]]; // Set channel
          NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:tfEntry.text, @"alert",@"Increment",@"badge", nil];
        PFPush *push = [[PFPush alloc] init];
        [push setQuery:pushQuery];
      //  [push setMessage:tfEntry.text];
        [push setData:data];
        [push sendPushInBackground];
    }@catch(NSException *e){
        
    }
     tfEntry.text = @"";

    [self hideIndicator];
    chatSending = false;
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
- (IBAction)back:(id)sender {
//    if([_fromWhere isEqualToString:@"requestFrom"]){
//        [self performSegueWithIdentifier:@"requestFrom" sender:self];
//    }else if([_fromWhere isEqualToString:@"requestTo"]) {[self performSegueWithIdentifier:@"requestTo" sender:self];
//}
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //  [textField resignFirstResponder];
    if([tfEntry.text isEqualToString:@""]){
        
    }else{
        PFObject *chatObject = [PFObject objectWithClassName:_chattingKey];
        chatObject[@"userName"] = _userName;
        chatObject[@"textString"] = tfEntry.text;
        tfEntry.text = @"";
        [chatObject saveInBackground];
        [self queryParseMethod];
    }
    return YES;
}

- (IBAction)goBackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
