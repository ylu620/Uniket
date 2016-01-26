//
//  MyItemListEditViewController.m
//  Fleem
//
//  Created by Student on 2/12/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "MyItemListEditViewController.h"
#import <Parse/Parse.h>
@interface MyItemListEditViewController (){
    BOOL segueShouldOccur;
    BOOL typePicking;
    BOOL wishPicking;
    BOOL iphoneFour;
}

@end

@implementation MyItemListEditViewController
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

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch =  [touches anyObject];
    
    if([touch view] == _myItemListEditMainView
       || [touch view] == _textbookInfoVIew)
    {

    [[self view] endEditing:YES];
    CGRect view = _myItemListView.frame;
    view.origin.x = 0;
    view.origin.y = 0;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _myItemListView.frame = view;
    
    [UIView commitAnimations];
    [UIView commitAnimations];
        [ UIView animateWithDuration:0.5 animations:^{_pictureChooserView.frame = CGRectMake(320, 70, 320, 191);
        }];
    [ UIView animateWithDuration:0.5 animations:^{_aimView.frame = CGRectMake(320, 241, 320, 327);
    }];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        _pickerView.frame =CGRectMake(0, 700, 320, 300);
        
        [UIView commitAnimations];
        typePicking = NO;
        wishPicking = NO;
    }
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if(wishPicking == YES){
        [_selectWishLabel setTitle:[wishArray objectAtIndex:[pickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
    }else if(typePicking == YES){
        [_selectTypeLabel setTitle:[wishArray objectAtIndex:[pickerView selectedRowInComponent:0]] forState:UIControlStateNormal];
    }
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    NSLog(@"Begin editing");
    if(iphoneFour == false) {
    CGRect view = _myItemListView.frame;
    view.origin.x = 0;
    view.origin.y = -195;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _myItemListView.frame = view;
    
    [UIView commitAnimations];
    }else{
        CGRect view = _myItemListView.frame;
        view.origin.x = 0;
        view.origin.y = -200;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _myItemListView.frame = view;
        
        [UIView commitAnimations];
    }
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    return YES;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    PFUser *currentUser = [PFUser currentUser];
    _submitButton.layer.borderWidth = 0.3;
    _textbookInfoVIew.alpha = 0.0;
    myItemListEditDescription.layer.borderWidth = 0.3;
    if([[[currentUser objectForKey:@"username"] substringWithRange:NSMakeRange([[currentUser objectForKey:@"username"] length] - 7, 7)] isEqualToString:@"ivc.edu"]){
        scopeIdentifier = @"IVC";
    }else{
        scopeIdentifier = @"";
    }
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    _indicatorView.alpha = 0.0;
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
    myItemListEditDescription.delegate = self;
  
    // Do any additional setup after loading the view.

    typePicking = false;
    wishPicking = false;
  
    
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
    
    
//    [wishArray addObject:@"(ACCT)(AHIS)(ALI)(AME)"];
//    [wishArray addObject:@"(AMST)(ANTH)(ARCH)(ASTE)"];
//    [wishArray addObject:@"(ASTR)(BAEP)(BIOC)(BME)"];
//    [wishArray addObject:@"(BUAD)(BUCO)"];
//    
//    [wishArray addObject:@"(CE)(CHE)(CHEM)"];
//    [wishArray addObject:@"(CLAS)(CMGT)(COLT)(CNTV)"];
//    [wishArray addObject:@"(COMM)(CRIT)(CSCI)"];
//    [wishArray addObject:@"(CTCS)(CTIN)(CTPR)(CTWR)"];
//    [wishArray addObject:@"(EALC)(EASC)(ECON)(EE)"];
//    [wishArray addObject:@"(ENE)(ENGL)(ENST)(EXSC)"];
//    
//    [wishArray addObject:@"(FBE)(FREN)(GEOG)"];
//    [wishArray addObject:@"(GEOL)(GR)(GERM)"];
//    [wishArray addObject:@"(HBIO)(HEBR)(HIST)"];
//    [wishArray addObject:@"(IR)(ITAL)(JOUR)"];
//    
//    [wishArray addObject:@"(LAT)(LBST)(LING)"];
//    [wishArray addObject:@"Thornton School of Music"];
//    [wishArray addObject:@"(MATH)(NEUR)(PEPP)(PHIL)"];
//    [wishArray addObject:@"(PHYS)(POIR)(POSC)(PSYC)"];
//    [wishArray addObject:@"Roski School of Art"];
//    [wishArray addObject:@"(SOCI)(SPAN)(THTR)(WRIT)"];
    }
    [query getObjectInBackgroundWithId:_editID block:^(PFObject *object, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"%@", object);
        if(!error){
            PFFile *imageFile = [object objectForKey:@"ItemPicture"];
            [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                _myItemEditImage.image = [UIImage imageWithData:data];
            }];
            
            _myItemEditTitle.text = [object objectForKey:@"Title"];
            myItemListEditDescription.text = [object objectForKey:@"Description"];
            [_selectTypeLabel setTitle:[object objectForKey:@"Type"] forState:UIControlStateNormal];
            if([[object objectForKey:@"Type"] isEqualToString:@"Textbooks"]){
                _textbookInfoVIew.alpha = 1.0;
                NSArray *array = [object objectForKey:@"TextbookInfo"];
                _symbolOutlet.text = [array objectAtIndex:0];
                _numberOutlet.text = [array objectAtIndex:1];
            }
            _myItemEditPrice.text = [object objectForKey:@"Price"];
            myItemListQuality.text = [object objectForKey:@"Quality"];
        }
    }];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(check) userInfo:nil
                                    repeats:YES];
    
}
-(void) check{
    if([myItemListQuality.text length] > 1){
        myItemListQuality.text = [myItemListQuality.text substringToIndex:1];
    }
    
    if(wishPicking == YES || typePicking == YES){
        if(iphoneFour == false) {
        [ UIView animateWithDuration:0 animations:^{_aimView.frame = CGRectMake(0, 241, 320, 327);
        }];
    }else{
        [ UIView animateWithDuration:0.5 animations:^{_aimView.frame = CGRectMake(0, 180, 320, 327);
        }];
    }
    }
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


- (IBAction)submitEditedItem:(id)sender {
    [self showIndicator];
    if([_myItemEditTitle.text isEqualToString:@""] ||
       [myItemListEditDescription.text isEqualToString:@""] ||
       [_selectWishLabel.titleLabel.text isEqualToString:@"Wish"] ||
       [_selectTypeLabel.titleLabel.text isEqualToString:@"Type"] ||
       [_myItemEditTitle.text isEqualToString:@""] || [myItemListQuality.text isEqualToString:@""]|| [_myItemEditPrice.text isEqualToString:@""]){
        if([_myItemEditTitle.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the title of the product" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }else if([_selectTypeLabel.titleLabel.text isEqualToString:@"Select Type"] ){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please select the type of your product" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else if(  [myItemListEditDescription.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the brief description" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else if(  [myItemListQuality.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the quality of the item" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }else if(   [_myItemEditPrice.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the price of the item" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }else if(!([myItemListQuality.text isEqualToString:@"1"]||[myItemListQuality.text isEqualToString:@"2"]||[myItemListQuality.text isEqualToString:@"3"]||[myItemListQuality.text isEqualToString:@"4"]||[myItemListQuality.text isEqualToString:@"5"])){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Quality should be 5,4,3,2 or 1" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else if(_myItemEditImage.image == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Submit Error" message:@"Please put the product picture" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else if([_selectTypeLabel.titleLabel.text isEqualToString:@"Textbooks"] && ([_numberOutlet.text isEqualToString:@""] || [_symbolOutlet.text isEqualToString:@""])){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Course Info" message:@"Please enter the course information" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else{
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
        [query getObjectInBackgroundWithId:_editID block:^(PFObject *productData, NSError *error) {
            // Do something with the returned PFObject in the gameScore variable.
     
            if(!error){
        productData[@"Title"] = _myItemEditTitle.text;
        productData[@"Description"] = myItemListEditDescription.text;
        productData[@"hide"] = @"0";
     
        productData[@"Quality"] = myItemListQuality.text;
        productData[@"Type"] = _selectTypeLabel.titleLabel.text;
        productData[@"Price"] =  _myItemEditPrice.text;
                if([_selectTypeLabel.titleLabel.text isEqualToString:@"Textbooks"] ){
                    productData[@"whichType"] = @"Textbook";
                    
                    [productData setObject:@[[_symbolOutlet.text uppercaseString], [_numberOutlet.text uppercaseString]] forKey:@"TextbookInfo"];
                }else{
                    productData[@"whichType"] = @"Item";
                }
        NSData *imageData = UIImageJPEGRepresentation(_myItemEditImage.image, 0.1);
        
                
        PFFile *profileImage = [PFFile fileWithName:@"image.jpg" data:imageData];
        [profileImage save];
        
        
        [productData setObject:profileImage forKey:@"ItemPicture"];
        //  productData[@"Quality"] = _productQuality.text;
        [productData saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        
        }];
            }
        }];
        [self performSegueWithIdentifier:@"editSuccess" sender:self];

    }
    [self hideIndicator];
}

- (IBAction)cancel:(id)sender {

}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:
(NSDictionary *) info{
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_myItemEditImage setImage:image];
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooserView.frame = CGRectMake(320, 70, 320, 191);
    }];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) imagePickerControllerDidCancel: (UIImagePickerController *) picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)chooseExisting:(id)sender {
    picker2 = [[UIImagePickerController alloc] init];
    picker2.delegate = self;
    [picker2 setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:picker2 animated:YES completion:NULL];
    

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (myItemListEditDescription.text.length >= 90 && range.length == 0)
    {
    	return NO; // return NO to not change text
    }
    else
    {return YES;}
}

- (IBAction)takingPicture:(id)sender {
    picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [self presentViewController:picker animated:YES completion:nil];
}
- (IBAction)fileChooserButton:(id)sender {
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooserView.frame = CGRectMake(0, 70, 320, 191);
    }];
    
}
- (IBAction)hideWish:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    _pickerView.frame =CGRectMake(0, 700, 320, 300);
    
    [UIView commitAnimations];
         [_selectTypeLabel setTitle:[wishArray objectAtIndex:[_pickerS selectedRowInComponent:0]] forState:UIControlStateNormal];
    if([_selectTypeLabel.titleLabel.text isEqualToString:@"Textbooks"]){
        _textbookInfoVIew.alpha = 1.0;
    }else{
        _textbookInfoVIew.alpha = 0.0;

    }
    typePicking = NO;
    wishPicking = NO;
}
- (IBAction)aimViewBack:(id)sender {
    if(!([_selectWishLabel.titleLabel.text isEqualToString:@"Wish"] ||[_selectTypeLabel.titleLabel.text isEqualToString:@"Type"] )){
        [_aimButtonOutlet setBackgroundImage:[UIImage imageNamed:@"aimed.png"] forState: UIControlStateNormal];
        
    }
    typePicking = NO;
    wishPicking = NO;
    [ UIView animateWithDuration:0.5 animations:^{_aimView.frame = CGRectMake(320, 241, 320, 327);
    }];
}

- (IBAction)selectWish:(id)sender {
    if(iphoneFour == false){
    [UIView beginAnimations:nil
                    context:NULL];
    [UIView setAnimationDuration:0.3];
    _pickerView.frame =CGRectMake(0, 351, 320, 300);
    _selectLabel.text =@"Select Wish";
    [UIView commitAnimations];
    }else{
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _pickerView.frame =CGRectMake(0, 280, 320, 300);
        _selectLabel.text =@"Select Wish";
        [UIView commitAnimations];
    }
    wishPicking = YES;
    typePicking = NO;
}

- (IBAction)aimViewAction:(id)sender {
    if(iphoneFour == false){
    [ UIView animateWithDuration:0.5 animations:^{_aimView.frame = CGRectMake(0, 241, 320, 327);
    }];
    }else{
        [ UIView animateWithDuration:0.5 animations:^{_aimView.frame = CGRectMake(0, 180, 320, 327);
        }];
    }
}

- (IBAction)pictureChooserBack:(id)sender {
    [ UIView animateWithDuration:0.5 animations:^{_pictureChooserView.frame = CGRectMake(320, 70, 320, 191);
    }];
}

- (IBAction)numberField:(id)sender {
    if(iphoneFour == false){
        CGRect view = _myItemListEditMainView.frame;
        view.origin.x = 0;
        view.origin.y = -60;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _myItemListEditMainView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _myItemListEditMainView.frame;
        view.origin.x = 0;
        view.origin.y = -90;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _myItemListEditMainView.frame = view;
        
        [UIView commitAnimations];
    }
}
- (IBAction)selectType:(id)sender {
    if(iphoneFour == false){
   [ UIView beginAnimations:nil
context:NULL];
    [UIView setAnimationDuration:0.3];
    _pickerView.frame =CGRectMake(0, 351, 320, 300);
        _selectLabel.text =@"Select Type";
    [UIView commitAnimations];
    }else{
        [ UIView beginAnimations:nil
                         context:NULL];
        [UIView setAnimationDuration:0.3];
        _pickerView.frame =CGRectMake(0, 280, 320, 300);
        _selectLabel.text =@"Select Type";
        [UIView commitAnimations];
    }
    typePicking = YES;
    wishPicking = NO;
}
- (IBAction)goBackAim:(id)sender {
    
    if(!([_selectWishLabel.titleLabel.text isEqualToString:@"Wish"] ||[_selectTypeLabel.titleLabel.text isEqualToString:@"Type"] )){
        [_aimButtonOutlet setBackgroundImage:[UIImage imageNamed:@"aimed.png"] forState: UIControlStateNormal];
        
    }
    typePicking = NO;
    wishPicking = NO;
    [ UIView animateWithDuration:0.5 animations:^{_aimView.frame = CGRectMake(320, 241, 320, 327);
    }];
}
- (IBAction)titleActionStart:(id)sender {
//        if(iphoneFour == true){
//    CGRect view = _myItemListView.frame;
//    view.origin.x = 0;
//    view.origin.y = -50;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    _myItemListView.frame = view;
//    
//    [UIView commitAnimations];
//        }
}
- (IBAction)qualityActionStart:(id)sender {
//    if(iphoneFour == true){
//    CGRect view = _myItemListView.frame;
//    view.origin.x = 0;
//    view.origin.y = -70;
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.3];
//    _myItemListView.frame = view;
//    
//    [UIView commitAnimations];
//    }
}
- (IBAction)myItemPriceEditBegin:(id)sender {
    if(iphoneFour == false){
        CGRect view = _myItemListView.frame;
        view.origin.x = 0;
        view.origin.y = 0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _myItemListView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _myItemListView.frame;
        view.origin.x = 0;
        view.origin.y = 0;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _myItemListView.frame = view;
        
        [UIView commitAnimations];
    }
}

- (IBAction)symbolField:(id)sender {
    if(iphoneFour == false){
        CGRect view = _myItemListEditMainView.frame;
        view.origin.x = 0;
        view.origin.y = -60;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _myItemListEditMainView.frame = view;
        
        [UIView commitAnimations];
    }else{
        CGRect view = _myItemListEditMainView.frame;
        view.origin.x = 0;
        view.origin.y = -90;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _myItemListEditMainView.frame = view;
        
        [UIView commitAnimations];
    }

}
@end
