//
//  PickerView.m
//  Fleem
//
//  Created by Student on 2/12/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "PickerView.h"
#import <Parse/Parse.h>
#import "MyItemListViewController.h"
#import "DataObject.h"
@interface PickerView (){
    BOOL segueShouldOccur;
    BOOL typePicking;
    BOOL wishPicking;
    BOOL iphoneFour;
}

@end

@implementation PickerView

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if(component == WISH){
        return [wishArray count];
    }

    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == WISH){
       
        return [wishArray objectAtIndex:row];
    }
    return 0;
}

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
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 800)];
    
    _selectPictureOutletThree.layer.borderWidth = 1.0;
    _selectPictureOutletTwo.layer.borderWidth = 1.0;
    _selectPictureOutletThree.layer.borderColor =  [UIColor colorWithRed:99/256.0 green:9/256.0 blue:9/256.0 alpha:1.0].CGColor;
     _selectPictureOutletTwo.layer.borderColor =  [UIColor colorWithRed:99/256.0 green:9/256.0 blue:9/256.0 alpha:1.0].CGColor;
    _selectPictureOutletOne.layer.borderWidth = 1.0;
     _selectPictureOutletOne.layer.borderColor =  [UIColor colorWithRed:99/256.0 green:9/256.0 blue:9/256.0 alpha:1.0].CGColor;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
    [scroller addGestureRecognizer:singleTap];
   // _postButtonOutlet.layer.borderWidth =0.3;
    _qMarkSecond.alpha = 0.0;
    _qMarkThird.alpha = 0.0;
    _productImageSecond.alpha = 0.0;
    _productImageThird.alpha = 0.0;
    _selectPictureOutletTwo.alpha = 0.0;
    _selectPictureOutletThree.alpha = 0.0;
    
    _textbookInfoView.alpha = 0.0;
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
    indicatorView.alpha = 0.0;
    // Do any additional setup after loading the view.
    typePicking = false;
    wishPicking = false;
     productDescription.delegate = self;
    if([scopeIdentifier isEqualToString:@"IVC"]){
        wishArray = [[NSMutableArray alloc] init];
        [wishArray addObject:@"Textbooks"];
        [wishArray addObject:@"Others"];
        [wishArray addObject:@"Tickets"];
        [wishArray addObject:@"Bicycles"];
        [wishArray addObject:@"Other Rides"];
        [wishArray addObject:@"Sporting Goods"];
        [wishArray addObject:@"Accessories"];
        [wishArray addObject:@"Shoes"];
        [wishArray addObject:@"Hat & Cap"];
        [wishArray addObject:@"Women's Apparel"];
        [wishArray addObject:@"Men's Apparel"];
        [wishArray addObject:@"Phones"];
        [wishArray addObject:@"MacBooks"];
        [wishArray addObject:@"Other Laptop"];
        [wishArray addObject:@"Electronics"];
        [wishArray addObject:@"Furniture"];
        [wishArray addObject:@"Bags"];
        [wishArray addObject:@"Books"];
        

   
    }else{
    wishArray = [[NSMutableArray alloc] init];
    [wishArray addObject:@"Textbooks"];
    [wishArray addObject:@"Others"];
    [wishArray addObject:@"Tickets"];
    [wishArray addObject:@"Bicycles"];
    [wishArray addObject:@"Long/Skate Boards"];
    [wishArray addObject:@"Other Rides"];
    [wishArray addObject:@"Sporting Goods"];
    [wishArray addObject:@"Accessories"];
    [wishArray addObject:@"Shoes"];
    [wishArray addObject:@"Hat & Cap"];
    [wishArray addObject:@"Women's Apparel"];
    [wishArray addObject:@"Men's Apparel"];
    [wishArray addObject:@"Phones"];
    [wishArray addObject:@"MacBooks"];
    [wishArray addObject:@"Other Laptop"];
    [wishArray addObject:@"Electronics"];
    [wishArray addObject:@"Furniture"];
    [wishArray addObject:@"Bags"];
    [wishArray addObject:@"Books"];


    }
    
    
    if([_editing isEqualToString:@"True"]){
        
        if([[[currentUser objectForKey:@"username"] substringWithRange:NSMakeRange([[currentUser objectForKey:@"username"] length] - 7, 7)] isEqualToString:@"ivc.edu"]){
            scopeIdentifier = @"IVC";
        }else{
            scopeIdentifier = @"";
        }
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
        [query getObjectInBackgroundWithId:_editID block:^(PFObject *object, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
            NSLog(@"%@", object);
            if(!error){
                PFFile *imageFile = [object objectForKey:@"ItemPicture"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    _productImage.image = [UIImage imageWithData:data];
                                    }];
                if([[object objectForKey:@"numOfPicture"] isEqualToString:@"2"]){
                    PFFile *imageFileTwo = [object objectForKey:@"ItemPictureTwo"];
                    [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _productImageSecond.image = [UIImage imageWithData:data];
                    }];
                    _productImageSecond.alpha = 1.0;
                    _selectPictureOutletTwo.alpha = 1.0;
                        _qMarkSecond.alpha = 1.0;
                    
                    _productImageThird.alpha = 1.0;
                    _selectPictureOutletThree.alpha = 1.0;
                    _qMarkThird.alpha = 1.0;
                }else if([[object objectForKey:@"numOfPicture"] isEqualToString:@"3"]){
                    
                    PFFile *imageFileTwo = [object objectForKey:@"ItemPictureTwo"];
                    [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _productImageSecond.image = [UIImage imageWithData:data];
                    }];
                    
                    _productImageSecond.alpha = 1.0;
                    _selectPictureOutletTwo.alpha = 1.0;
                    _qMarkSecond.alpha = 1.0;
                    PFFile *imageFileThree = [object objectForKey:@"ItemPictureThree"];
                    [imageFileThree getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _productImageThird.image = [UIImage imageWithData:data];
                    }];
                    
                    _productImageThird.alpha = 1.0;
                    _selectPictureOutletThree.alpha = 1.0;
                    _qMarkThird.alpha = 1.0;
                }else{
                    _productImageSecond.alpha = 1.0;
                    _selectPictureOutletTwo.alpha = 1.0;
                    _qMarkSecond.alpha = 1.0;
                }

                _productTitle.text = [object objectForKey:@"Title"];
                productDescription.text = [object objectForKey:@"Description"];
                [_selectType setTitle:[object objectForKey:@"Type"] forState:UIControlStateNormal];
                if([[object objectForKey:@"Type"] isEqualToString:@"Textbooks"]){
                    _textbookInfoView.alpha = 1.0;
                    NSArray *array = [object objectForKey:@"TextbookInfo"];
                    _courseSymbolField.text = [array objectAtIndex:0];
                    _courseNumberField.text = [array objectAtIndex:1];
                }
                _productPrice.text = [object objectForKey:@"Price"];

            }
        }];

    }
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(check) userInfo:nil
                                    repeats:YES];
    
    productDescription.editable = true;
   
}
-(void) check{
    
    if([productDescription.text length] >300){
        productDescription.text = [productDescription.text substringToIndex:310];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if(wishPicking == true){
    [_selectWish setTitle:[wishArray objectAtIndex:[pickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
       }else if(typePicking == true){
    [_selectType setTitle:[wishArray objectAtIndex:[pickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
           if([_selectType.titleLabel.text isEqualToString:@"Cash"]){
               _productImage.image =[UIImage imageNamed:@"cash.png"];
           }
    }
   

 
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"submitSuccessInProcess"]){
        NSString *temID = _tempOwnerID;
        NSString *temItem = _tempOwnerItemID;
        NSString *typeItem = _tempTypeItem;
        MyItemListViewController *ownerIDs = [segue destinationViewController];
        ownerIDs.ownerItemID = temItem;
        ownerIDs.ownerID= temID;

    }else if([segue.identifier isEqualToString:@"submitSuccess"]){
        MyItemListViewController *ownerIDs = [segue destinationViewController];
    
    
     //   ownerIDs.submitted = true;

    }
}
-(void) showIndicator{
    [UIView animateWithDuration:0.0 animations:^{indicatorView.alpha = 1.0;} completion:^(BOOL finished){
        [indicator startAnimating];
    }];
}

-(void) hideIndicator{
    [UIView animateWithDuration:0.3 animations:^{indicatorView.alpha = 0.0;} completion:^(BOOL finished){
        [indicator stopAnimating];
    }];
}





- (IBAction)productSubmit:(id)sender {
     [self showIndicator];
    
    if([_editing isEqualToString:@"True"]){
        if([_productTitle.text isEqualToString:@""] ||
           [productDescription.text isEqualToString:nil] ||
           [_wishButton.titleLabel.text isEqualToString:@"Wish"] ||
           [_selectType.titleLabel.text isEqualToString:@"Select Type"] ||
           [_productTitle.text isEqualToString:@""] ||[_productPrice.text isEqualToString:@""]){
            if([_productTitle.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the title of the product" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                
            }else if([_selectType.titleLabel.text isEqualToString:@"Select Type"] ){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please select the type of your product" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }else if(  [productDescription.text isEqualToString:nil]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the brief description" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }else if(   [_productPrice.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the price of the item" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }else if(_productImage.image == nil){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the product picture" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }else if([_selectType.titleLabel.text isEqualToString:@"Textbooks"] && ([_courseNumberField.text isEqualToString:@""] || [_courseSymbolField.text isEqualToString:@""])){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Course Info" message:@"Please enter the course information" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }else{
            
            _postButton.enabled = false;
            
            PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
            [query getObjectInBackgroundWithId:_editID block:^(PFObject *productData, NSError *error) {
                // Do something with the returned PFObject in the gameScore variable.
                
                if(!error){
                    productData[@"Title"] = _productTitle.text;
                    productData[@"Description"] = productDescription.text;
                    productData[@"hide"] = @"0";
                    
           
                    productData[@"Type"] = _selectType.titleLabel.text;
                    productData[@"Price"] =  _productPrice.text;
                    if([_selectType.titleLabel.text isEqualToString:@"Textbooks"] ){
                        productData[@"whichType"] = @"Textbook";
                        
                        [productData setObject:@[[_courseSymbolField.text uppercaseString], [_courseNumberField.text uppercaseString]] forKey:@"TextbookInfo"];
                    }else{
                        productData[@"whichType"] = @"Item";
                    }
                    NSData *imageData = UIImageJPEGRepresentation(_productImage.image, 0.1);
                    
                    
                    PFFile *profileImage = [PFFile fileWithName:@"image.jpg" data:imageData];
                    [profileImage save];
                    
                    
                    [productData setObject:profileImage forKey:@"ItemPicture"];
                    //  productData[@"Quality"] = _productQuality.text;
                    NSInteger numOfPictures = 1;
                    if(_productImageSecond.image != nil){
                        numOfPictures = 2;
                        if(_productImageThird.image != nil){
                            numOfPictures = 3;
                        }
                        
                    }
                    
                    if(numOfPictures == 2){
                        NSData *imageDataTwo = UIImageJPEGRepresentation(_productImageSecond.image, 0.07);
                        
                        PFFile *profileImageTwo = [PFFile fileWithName:@"image.jpg" data:imageDataTwo];
                        [profileImageTwo save];
                        [productData setObject:profileImageTwo forKey:@"ItemPictureTwo"];
                        productData[@"numOfPicture"] = @"2";
                    }else if(numOfPictures ==3){
                        NSData *imageDataTwo = UIImageJPEGRepresentation(_productImageSecond.image, 0.07);
                        
                        PFFile *profileImageTwo = [PFFile fileWithName:@"image.jpg" data:imageDataTwo];
                        [profileImageTwo save];
                        [productData setObject:profileImageTwo forKey:@"ItemPictureTwo"];
                        NSData *imageDataThree = UIImageJPEGRepresentation(_productImageThird.image, 0.07);
                        
                        PFFile *profileImageThree = [PFFile fileWithName:@"image.jpg" data:imageDataThree];
                        [profileImageThree save];
                        [productData setObject:profileImageThree forKey:@"ItemPictureThree"];
                        productData[@"numOfPicture"] = @"3";
                    }else if(numOfPictures == 1){
                        productData[@"numOfPicture"] = @"1";
                    }
                    
                    [productData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (succeeded) {
                            // The object has been saved.
                        } else {
                            // There was a problem, check error.description
                        }
                        
                    }];
                    
                    
                }
                optionSingle = [DataObject dataObjects];
                optionSingle.submittedFromPickerView = @"True";
                _editing = @"False";
                _postButton.enabled = true;
                [self dismissViewControllerAnimated:YES completion:NULL];
            }];
        }
        
    }else{
    if([_productTitle.text isEqualToString:@""] ||
       [productDescription.text isEqualToString:nil] ||
       [_wishButton.titleLabel.text isEqualToString:@"Wish"] ||
       [_selectType.titleLabel.text isEqualToString:@"Select Type"] ||
       [_productTitle.text isEqualToString:@""] ||[_productPrice.text isEqualToString:@""]){
        if([_productTitle.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the title of the product" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];

        }else if([_selectType.titleLabel.text isEqualToString:@"Select Type"] ){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please select the type of your product" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else if(  [productDescription.text isEqualToString:nil]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the brief description" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else if(   [_productPrice.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the price of the item" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }else if(_productImage.image == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the product picture" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
    }else if([_selectType.titleLabel.text isEqualToString:@"Textbooks"] && ([_courseNumberField.text isEqualToString:@""] || [_courseSymbolField.text isEqualToString:@""])){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Course Info" message:@"Please enter the course information" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    
        }else{
            _postButton.enabled = false;
        
    PFObject *productData = [PFObject objectWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [productData setObject:[PFUser currentUser] forKey:@"createdBy"];
    productData[@"Title"] = _productTitle.text;
    productData[@"Description"] = productDescription.text;
    productData[@"hide"] = @"0";

    productData[@"Type"] = _selectType.titleLabel.text;
    productData[@"Price"] =  _productPrice.text;
    if([_selectType.titleLabel.text isEqualToString:@"Textbooks"] ){
                    productData[@"whichType"] = @"Textbook";
        
                    [productData setObject:@[[_courseSymbolField.text uppercaseString], [_courseNumberField.text uppercaseString]] forKey:@"TextbookInfo"];
            }else{
    productData[@"whichType"] = @"Item";
            }
            NSInteger numOfPictures = 1;
            if(_productImageSecond.image != nil){
                numOfPictures = 2;
                if(_productImageThird.image != nil){
                    numOfPictures = 3;
                }
                
            }
    NSData *imageData = UIImageJPEGRepresentation(_productImage.image, 0.1);
    
    PFFile *profileImage = [PFFile fileWithName:@"image.jpg" data:imageData];
    [profileImage save];
       [productData setObject:profileImage forKey:@"ItemPicture"];
            if(numOfPictures == 2){
                NSData *imageDataTwo = UIImageJPEGRepresentation(_productImageSecond.image, 0.07);
                
                PFFile *profileImageTwo = [PFFile fileWithName:@"image.jpg" data:imageDataTwo];
                [profileImageTwo save];
                [productData setObject:profileImageTwo forKey:@"ItemPictureTwo"];
                productData[@"numOfPicture"] = @"2";
            }else if(numOfPictures ==3){
                NSData *imageDataTwo = UIImageJPEGRepresentation(_productImageSecond.image, 0.07);
                
                PFFile *profileImageTwo = [PFFile fileWithName:@"image.jpg" data:imageDataTwo];
                [profileImageTwo save];
                [productData setObject:profileImageTwo forKey:@"ItemPictureTwo"];
                NSData *imageDataThree = UIImageJPEGRepresentation(_productImageThird.image, 0.07);
                
                PFFile *profileImageThree = [PFFile fileWithName:@"image.jpg" data:imageDataThree];
                [profileImageThree save];
                [productData setObject:profileImageThree forKey:@"ItemPictureThree"];
                    productData[@"numOfPicture"] = @"3";
            }else if(numOfPictures == 1){
                   productData[@"numOfPicture"] = @"1";
            }
    
 
  //  productData[@"Quality"] = _productQuality.text;
        [productData saveInBackground];
        
        if([_determineString isEqualToString:@"fromNormal"]){
        
            
        optionSingle = [DataObject dataObjects];
        optionSingle.submittedFromPickerView = @"True";
            
            _postButton.enabled = true;
        [self dismissViewControllerAnimated:YES completion:NULL];
            
          //  BOOL submittedFromPickerView = true;
        //[self performSegueWithIdentifier:@"submitSuccess" sender:self];
        }
        
        

    }
    }
    [self hideIndicator];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)singleTapGestureCaptured:(UITapGestureRecognizer *)gesture
{
    CGPoint touchPoint=[gesture locationInView:scroller];
    [[self view] endEditing:YES];
   
    [[self view] endEditing:YES];
    CGRect view = _pickerViewView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _pickerViewView.frame = view;
    
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _pickerViewContainer.frame =CGRectMake(0, 700, 320, 300);
    
    [UIView commitAnimations];
    typePicking = NO;
    wishPicking = NO;
    if([_selectType.titleLabel.text isEqualToString:@"Textbooks"]){
        _textbookInfoView.alpha = 1.0;
    }else{
        _textbookInfoView.alpha = 0.0;
    }

}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch =  [touches anyObject];
    
    if([touch view] == _pickerViewMainView || [touch view] == _textbookInfoView || [touch view] == scroller)
    {
    [[self view] endEditing:YES];
  
    [[self view] endEditing:YES];
    CGRect view = _pickerViewView.frame;
    view.origin.x = 
    view.origin.y = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _pickerViewView.frame = view;
        
        [UIView commitAnimations];
   
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        _pickerViewContainer.frame =CGRectMake(0, 700, 320, 300);
        
        [UIView commitAnimations];
        typePicking = NO;
        wishPicking = NO;
    }
    
    if([_selectType.titleLabel.text isEqualToString:@"Textbooks"]){
        _textbookInfoView.alpha = 1.0;
    }else{
        _textbookInfoView.alpha = 0.0;
    }
}


- (IBAction)hideWish:(id)sender {
    [_selectType setTitle:[wishArray objectAtIndex:[_pickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _pickerViewContainer.frame =CGRectMake(0, 700, 320, 300);
    [UIView commitAnimations];
    typePicking = false;
    wishPicking = false;
    if([_selectType.titleLabel.text isEqualToString:@"Textbooks"]){
        _textbookInfoView.alpha = 1.0;
    }else{
        _textbookInfoView.alpha = 0.0;
    }
}





- (IBAction)titleActionStart:(id)sender {
//        if(iphoneFour == true){
//    CGRect view = _pickerViewView.frame;
//    view.origin.x = 0;
//    view.origin.y = -50;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    _pickerViewView.frame = view;
//    
//    [UIView commitAnimations];
//        }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Begin editing");
    if(iphoneFour == false){
    CGRect view = _pickerViewView.frame;
    view.origin.x = 0;
    view.origin.y = -195;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _pickerViewView.frame = view;
    
    [UIView commitAnimations];
    }else{
        CGRect view = _pickerViewView.frame;
        view.origin.x = 0;
        view.origin.y = -200;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _pickerViewView.frame = view;
        
        [UIView commitAnimations];
    }
    
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (productDescription.text.length >= 300 && range.length == 0)
    {
    	return NO; // return NO to not change text
    }
    else
    {return YES;}
}








- (IBAction)selectType:(id)sender {
    if(iphoneFour == false){
    [UIView beginAnimations:nil
                    context:NULL];
    [UIView setAnimationDuration:0.3];
    _pickerViewContainer.frame =CGRectMake(0, 351, 320, 300);
    _selectLabel.text = @"Select Type";
    [UIView commitAnimations];
    typePicking = true;
    wishPicking = false;
    }else{
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _pickerViewContainer.frame =CGRectMake(0, 280, 320, 300);
        _selectLabel.text = @"Select Type";
        [UIView commitAnimations];
        typePicking = true;
        wishPicking = false;
    }
}


- (IBAction)productPriceEditBegin:(id)sender {
    if(iphoneFour == false){
        CGRect view = _pickerViewView.frame;
        view.origin.x = 0;
        view.origin.y = 0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _pickerViewView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _pickerViewView.frame;
        view.origin.x = 0;
        view.origin.y = 0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _pickerViewView.frame = view;
        
        [UIView commitAnimations];
    }
}

- (IBAction)goBackToList:(id)sender {
    _editing = @"False";
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)symbolEditBegin:(id)sender {
    if(iphoneFour == false){
        CGRect view = _pickerViewView.frame;
        view.origin.x = 0;
        view.origin.y = -70;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _pickerViewView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _pickerViewView.frame;
        view.origin.x = 0;
        view.origin.y = -100;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _pickerViewView.frame = view;
        
        [UIView commitAnimations];
    }

}

- (IBAction)numberEditBegin:(id)sender {
    if(iphoneFour == false){
        CGRect view = _pickerViewView.frame;
        view.origin.x = 0;
        view.origin.y = -60;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _pickerViewView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _pickerViewView.frame;
        view.origin.x = 0;
        view.origin.y = -90;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _pickerViewView.frame = view;
        
        [UIView commitAnimations];
    }

}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:
(NSDictionary *) info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if(_firstPictureEditing){
    [_productImage setImage:image];
        _qMarkSecond.alpha = 1.0;
        _productImageSecond.alpha = 1.0;
        _selectPictureOutletTwo.alpha = 1.0;
    }else if(_secondPictureEditing){
         [_productImageSecond setImage:image];
        _qMarkThird.alpha = 1.0;
        _productImageThird.alpha = 1.0;
        _selectPictureOutletThree.alpha = 1.0;
    }else if(_thirdPictureEditing){
         [_productImageThird setImage:image];
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        chooserPicker = [[UIImagePickerController alloc] init];
        chooserPicker.delegate = self;
        [chooserPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:chooserPicker animated:YES completion:NULL];
    }else if(buttonIndex == 2){
        takePicturePicker = [[UIImagePickerController alloc] init];
        takePicturePicker.delegate = self;
        [takePicturePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:takePicturePicker animated:YES completion:nil];
    }else if(buttonIndex ==3){
        if(_firstPictureEditing){
           [_productImage setImage:nil];
            if(_productImageSecond.image != nil && _productImageThird.image != nil ){
                  [_productImage setImage:_productImageSecond.image];
                 [_productImageSecond setImage:_productImageThird.image];
                [_productImageThird setImage:nil];
                
            }else if(_productImageSecond.image != nil){
                 [_productImage setImage:_productImageSecond.image];
                [_productImageSecond setImage:nil];
                _qMarkThird.alpha = 0.0;
                _productImageThird.alpha= 0.0;
                _selectPictureOutletThree.alpha = 0.0;
               
            }else{
                _qMarkSecond.alpha = 0.0;
                _productImageSecond.alpha= 0.0;
                _selectPictureOutletTwo.alpha = 0.0;
            }
        }else if(_secondPictureEditing){
            [_productImageSecond setImage:nil];
            if(_productImageThird.image != nil){
                  [_productImageSecond setImage:_productImageThird.image];
                [_productImageThird setImage:nil];
               
            }else{
                _qMarkThird.alpha = 0.0;
                _productImageThird.alpha= 0.0;
                _selectPictureOutletThree.alpha = 0.0;
            }
          
        }else if(_thirdPictureEditing){
            [_productImageThird setImage:nil];
           
        }
    }
}

- (IBAction)selectPictureButton:(id)sender {
    if(_productImage.image == nil){
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Item Picture"
                          message:@""
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Choose Existing", @"Taking Picture", nil];
     [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Item Picture"
                              message:@""
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Choose Existing", @"Taking Picture", @"Delete", nil];
          [alert show];
    }


    _firstPictureEditing = true;
    _secondPictureEditing = false;
    _thirdPictureEditing = false;
}
- (IBAction)selectPictrueButtonTwo:(id)sender {
    if(_productImageSecond.image == nil){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Item Picture"
                              message:@""
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Choose Existing", @"Taking Picture", nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Item Picture"
                              message:@""
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Choose Existing", @"Taking Picture", @"Delete", nil];
          [alert show];
    }
    _firstPictureEditing = false;
    _secondPictureEditing = true;
    _thirdPictureEditing = false;
}

- (IBAction)selectPictureButtonThree:(id)sender {
    if(_productImageThird.image == nil){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Item Picture"
                              message:@""
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Choose Existing", @"Taking Picture", nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Item Picture"
                              message:@""
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"Choose Existing", @"Taking Picture", @"Delete", nil];
          [alert show];
    }
    _firstPictureEditing = false;
    _secondPictureEditing = false;
    _thirdPictureEditing = true;
}
@end
