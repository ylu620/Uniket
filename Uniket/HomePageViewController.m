
#import "HomePageViewController.h"
#import "HomeTableViewCell.h"
#import <Parse/Parse.h>
#import "MyItemListViewController.h"
@interface HomePageViewController (){
    NSMutableArray *productArray;
    BOOL notEnoughWish;
    BOOL iphoneFour;
    BOOL textbookSearched;
    
       UIRefreshControl *refreshControl;
}

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"sendOwnerID"]){
        NSString *id = tempItemID;
        NSString *userID = tempUserID;
        MyItemListViewController *ownerIDs = [segue destinationViewController];
        ownerIDs.ownerItemID = id;
        ownerIDs.ownerID = userID;
        ownerIDs.itemName = nameWillsend;
        ownerIDs.itemPicture = _detailImage.image;
        ownerIDs.fromHome = true;
        ownerIDs.itemPrice = _wishMatchNotify.text;
    }else if([segue.identifier isEqualToString:@"refresh"]){
        HomePageViewController *refreshed = [segue destinationViewController];
        refreshed.category = selectedCategory;
        refreshed.refreshed = true;
        refreshed.textbookRefreshed = false;
        if(textbookSearched == true){
            refreshed.courseSymbol = courseSym;
            refreshed.courseNumber = courseNum;
            refreshed.textbookRefreshed = true;
        }
    }
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if([pickerView isEqual:categoryPicker]){
        return 1;

    }else if([pickerView isEqual:textbookPicker]){
        return 1;

    }
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    
    if([pickerView isEqual:categoryPicker]){
        return [categoryArray count];
    }else if([pickerView isEqual:textbookPicker]){
          return [textbookArray count];
    }
    
    return 0;
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if([pickerView isEqual:categoryPicker]){
        
        return [categoryArray objectAtIndex:row];
    }else if([pickerView isEqual:textbookPicker]){
        return [textbookArray objectAtIndex:row];
    }
    return 0;
}

-(void)refreshTable{
    
    if(_textbookRefreshed == true){
        //  courseSym = _courseSymbol;
        //  courseNum = _courseNumber;
        //  _textbookRefreshed = false;
        
        [self textbookSearch];
       // [self performSelector:@selector(reloadTextbook) withObject:nil afterDelay:0.7];
    }else if(_categoryRefreshed == true){
       // [self performSelector:@selector(reloadCategoryParseMethod) withObject:nil afterDelay:0.7];
        
        [self categoryParseMethod];
    }else{
        textbookSearched = false;
        //[self performSelector:@selector(reloadQuaryParseMethod) withObject:nil afterDelay:0.7];
        [self queryParseMethod];
    }
  
    [refreshControl endRefreshing];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        if(iphoneFour ==false){
            [ UIView animateWithDuration:0.5 animations:^{_detailView.frame = CGRectMake(320, 0, 320, 600);
            }];
        }else{
            [ UIView animateWithDuration:0.5 animations:^{_detailView.frame = CGRectMake(320, 0, 320, 434);
            }];
        }
        PFObject *reportedData = [PFObject objectWithClassName:@"ReportAbuse"];
        [reportedData setObject:tempDetailObject forKey:@"reportedItem"];
        [reportedData save];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Report Success" message:@"Thank you for your report. Fleem will review the item!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else if(buttonIndex == 2){
      
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 800)];
    
    [searchViewScroller setScrollEnabled:YES];
    [searchViewScroller setShowsHorizontalScrollIndicator:NO];
    [searchViewScroller setShowsVerticalScrollIndicator:NO];
    [searchViewScroller setContentSize:CGSizeMake(960, 170)];
    //image apply
    _detailPage.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainDetail.png"]];
    _bigImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mainBig.png"]];
    _categoryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"searchView.png"]];
    
      _symbolField.autocorrectionType = UITextAutocorrectionTypeNo;
   // _placeOrderButton.layer.borderWidth = 0.3;
    //_textBookSearch.layer.borderWidth = 0.3;
    //_generalSearch.layer.borderWidth = 0.3;
    _textbookSearchGo.layer.borderWidth = 0.3;
    _textbookInfoView.alpha = 0.0;
    _backButtonLogo.alpha = 0.0;
    _bigImageView.alpha = 0.0;
    
//    [self.view.layer insertSublayer:bgLayer atIndex:0];
    PFUser *currentUser = [PFUser currentUser];
    if([[[currentUser objectForKey:@"username"] substringWithRange:NSMakeRange([[currentUser objectForKey:@"username"] length] - 7, 7)] isEqualToString:@"ivc.edu"]){
        scopeIdentifier = @"IVC";
    }else{
        scopeIdentifier = @"";
    }
    //_detailView.alpha = 0;
    
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    
    
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self.imagesCollection addSubview:refreshControl];
    
    
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
    
    selectedCategory =@"All";
    
    
    if([scopeIdentifier isEqualToString:@"IVC"]){
          categoryArray= [[NSMutableArray alloc] init];
        [categoryArray addObject:@"All"];
        [categoryArray addObject:@"Textbooks"];
        [categoryArray addObject:@"Others"];
        [categoryArray addObject:@"Tickets"];
        [categoryArray addObject:@"Bicycles"];
        [categoryArray addObject:@"Other Rides"];
        [categoryArray addObject:@"Sporting Goods"];
        [categoryArray addObject:@"Accessories"];
        [categoryArray addObject:@"Shoes"];
        [categoryArray addObject:@"Hat & Cap"];
        [categoryArray addObject:@"Women's Apparel"];
        [categoryArray addObject:@"Men's Apparel"];
        [categoryArray addObject:@"Phones"];
        [categoryArray addObject:@"MacBooks"];
        [categoryArray addObject:@"Other Laptop"];
        [categoryArray addObject:@"Electronics"];
        [categoryArray addObject:@"Furniture"];
        [categoryArray addObject:@"Bags"];
        [categoryArray addObject:@"Books"];
       
        
    
    }else{
        
        categoryArray= [[NSMutableArray alloc] init];
        [categoryArray addObject:@"All"];
        [categoryArray addObject:@"Textbooks"];
        [categoryArray addObject:@"Others"];
        [categoryArray addObject:@"Tickets"];
        [categoryArray addObject:@"Bicycles"];
        [categoryArray addObject:@"Long/Skate Boards"];
        [categoryArray addObject:@"Other Rides"];
        [categoryArray addObject:@"Sporting Goods"];
        [categoryArray addObject:@"Accessories"];
        [categoryArray addObject:@"Shoes"];
        [categoryArray addObject:@"Hat & Cap"];
        [categoryArray addObject:@"Women's Apparel"];
        [categoryArray addObject:@"Men's Apparel"];
        [categoryArray addObject:@"Phones"];
        [categoryArray addObject:@"MacBooks"];
        [categoryArray addObject:@"Other Laptop"];
        [categoryArray addObject:@"Electronics"];
        [categoryArray addObject:@"Furniture"];
        [categoryArray addObject:@"Bags"];
        [categoryArray addObject:@"Books"];
    }
    if([scopeIdentifier isEqualToString:@"IVC"]){
        textbookArray= [[NSMutableArray alloc] init];
        
        [textbookArray addObject:@"Other Textbooks"];
        [textbookArray addObject:@"(ACCT)(AJ)(ANTH)"];
        [textbookArray addObject:@"(ART)(ARTH)"];
        [textbookArray addObject:@"(BIO)(CHEM)(COMM)(CIM)"];
        [textbookArray addObject:@"(CS)(DMP)(DMA)"];
        
        [textbookArray addObject:@"(ECON)(ET)"];
        [textbookArray addObject:@"(ESL)(FR)"];
        [textbookArray addObject:@"(GEOG)(GEOL)"];
        [textbookArray addObject:@"(HIST)(HD)"];
        [textbookArray addObject:@"(HUM)"];
        [textbookArray addObject:@"(JA)(MGT)"];
        [textbookArray addObject:@"(MATH)(MUS)"];
        [textbookArray addObject:@"(PHIL)"];
        [textbookArray addObject:@"(PHYS)(PS)"];
        [textbookArray addObject:@"(PSYC)"];
        [textbookArray addObject:@"(RE)(SPAN)"];
        [textbookArray addObject:@"(SRM)(SOC)"];
        
        [textbookArray addObject:@"(TA)"];
        [textbookArray addObject:@"(WR)"];
    }else{
    textbookArray= [[NSMutableArray alloc] init];
    [textbookArray addObject:@"Other Textbooks"];
    [textbookArray addObject:@"(ACCT)(AHIS)(ALI)(AME)"];
    [textbookArray addObject:@"(AMST)(ANTH)(ARCH)(ASTE)"];
    [textbookArray addObject:@"(ASTR)(BAEP)(BIOC)(BME)"];
    [textbookArray addObject:@"(BUAD)(BUCO)"];
    
    [textbookArray addObject:@"(CE)(CHE)(CHEM)"];
    [textbookArray addObject:@"(CLAS)(CMGT)(COLT)(CNTV)"];
    [textbookArray addObject:@"(COMM)(CRIT)(CSCI)"];
    [textbookArray addObject:@"(CTCS)(CTIN)(CTPR)(CTWR)"];
    [textbookArray addObject:@"(EALC)(EASC)(ECON)(EE)"];
    [textbookArray addObject:@"(ENE)(ENGL)(ENST)(EXSC)"];
    
    [textbookArray addObject:@"(FBE)(FREN)(GEOG)"];
    [textbookArray addObject:@"(GEOL)(GR)(GERM)"];
    [textbookArray addObject:@"(HBIO)(HEBR)(HIST)"];
    [textbookArray addObject:@"(IR)(ITAL)(JOUR)"];
    
    [textbookArray addObject:@"(LAT)(LBST)(LING)"];
    [textbookArray addObject:@"Thornton School of Music"];
    [textbookArray addObject:@"(MATH)(NEUR)(PEPP)(PHIL)"];
    [textbookArray addObject:@"(PHYS)(POIR)(POSC)(PSYC)"];
    [textbookArray addObject:@"Roski School of Art"];
    [textbookArray addObject:@"(SOCI)(SPAN)(THTR)(WRIT)"];
    }
    [self showIndicator];
   // self.navigationItem.hidesBackButton = YES;
   // self.navigationController.navigationBar.hidden = YES;
   // self.navigationItem.backBarButtonItem=nil;
  
    productArray = [NSMutableArray arrayWithCapacity:1];
    // Do any additional setup after loading the view.
 
//    if(_refreshed == true){
//        selectedCategory = _category;
//        _refreshed = false;
//        if(_textbookRefreshed == true){
//            courseSym = _courseSymbol;
//            courseNum = _courseNumber;
//            _textbookRefreshed = false;
//            [self performSelector:@selector(textbookSearch) withObject:nil afterDelay:0.7];
//        }else{
//        [self performSelector:@selector(categoryParseMethod) withObject:nil afterDelay:0.7];
//        }
//        
//     
//    }else{
//        textbookSearched = false;
//          [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];
//    }

   // [self queryParseMethod];
    [self performSelector:@selector(queryParseMethod) withObject:nil afterDelay:0.7];

   

}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch =  [touches anyObject];
    
    if([touch view] == _categoryView || [touch view] ==_textbookInfoView || [touch view] == blackview){
        CGRect view = _textbookInfoView.frame;
        view.origin.x = 0;
        view.origin.y = 321;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _textbookInfoView.frame = view;
        _textbookInfoView.backgroundColor = [UIColor clearColor];
        [blackview removeFromSuperview];
        [UIView commitAnimations];
    if(iphoneFour == false){
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _selectTypeView.frame =CGRectMake(0, 600, 320, 300);
        [UIView commitAnimations];
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _selectCourseView.frame =CGRectMake(0, 600, 320, 300);
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _selectTypeView.frame =CGRectMake(0, 600, 320, 300);
        [UIView commitAnimations];
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _selectCourseView.frame =CGRectMake(0, 600, 320, 300);
        [UIView commitAnimations];
    }
       [[self view] endEditing:YES];
        
    }
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];               //Change the "2" to the desired duration
    
 _categoryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"searchView.png"]];
    
    [UIView commitAnimations];
}


- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = CGSizeMake(320,100);
    return newSize;
}
-(void)viewWillAppear:(BOOL)animated{
   //   self.navigationItem.backBarButtonItem=nil;
//     [super viewWillAppear:animated];
//      [[self navigationController] setNavigationBarHidden:NO animated:YES];
   // self.navigationController.navigationBar.frame.size.height = ;


    
    
    optionSingle = [DataObject dataObjects];
    if( [optionSingle.requestConfirmed isEqualToString:@"True"]){
       // optionSingle.requestConfirmed = @"GoTo";
    UITabBarController *tabBarController = self.tabBarController;
        tabBarController.selectedIndex = 2;
 
    }else{
       [[UITabBar appearance] setTintColor:[UIColor colorWithRed:173/256.0 green:17/256.0 blue:17/256.0 alpha:1.0]];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:99/256.0 green:9/256.0 blue:9/256.0 alpha:1.0], UITextAttributeTextColor,
                                                           nil] forState:UIControlStateSelected];
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

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homecell"];
    
    //****Product Data Extraction from DB **********
    //****Product Data Extraction **********
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cellImage.png"]];
    
    PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    PFFile *imageFile = [imageObject objectForKey:@"ItemPicture"];
    cell.productImage.image = [UIImage imageNamed:@"loading.png"];
    
    
    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if(!error){
            //CGSize size=CGSizeMake(251, 192);
            //UIImage *resizedImage= [self resizeImage:[UIImage imageWithData:data] imageSize:size];
           
            cell.productImage.image = [UIImage imageWithData:data];
        }
    }];

    
    
    if (cell == nil) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"homecell"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }


    cell.productTitle.text = [imageObject objectForKey:@"Title"];
 
//    cell.productDetail.text= [imageObject objectForKey:@"Description"];
  
    NSString *temptitle = cell.productTitle.text;
   
  
    cell.wishLabel.text =  [NSString stringWithFormat:@"%@%@", @"$", [imageObject objectForKey:@"Price"]];
    //UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.contentView.frame.size.height - 1.0, cell.contentView.frame.size.width, 1)];
    
    //lineView.backgroundColor = [UIColor colorWithRed:240.0/256.0 green:235.0/256.0 blue:235.0/256.0 alpha:1.0];
    //[cell.contentView addSubview:lineView];

    cell.contentView.backgroundColor = [UIColor clearColor];
  
    
    if (indexPath.row == rows - 1)
    {
        if(rows >= 20 && rows < 100 && _allItemLoaded == false){
        [self showIndicator];
        [self performSelector:@selector(reload) withObject:nil afterDelay:0.7];
        //_refreshed = true;
        }
        //[self reload];
    }
    
    return cell;
}
-(void) reload{
    
        if(_textbookRefreshed == true){
          //  courseSym = _courseSymbol;
          //  courseNum = _courseNumber;
          //  _textbookRefreshed = false;
            [self performSelector:@selector(reloadTextbook) withObject:nil afterDelay:0.7];
        }else if(_categoryRefreshed == true){
            [self performSelector:@selector(reloadCategoryParseMethod) withObject:nil afterDelay:0.7];
        }else{
        textbookSearched = false;
        [self performSelector:@selector(reloadQuaryParseMethod) withObject:nil afterDelay:0.7];
    }
    
  
    
}
-(void) reloadCategoryParseMethod{
    textbookSearched = false;
    _categoryRefreshed = true;
    _textbookRefreshed = false;
    if([selectedCategory isEqualToString:@"All"]){
        [self reloadQuaryParseMethod];
        
    }else{
        
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
        [query whereKey:@"createdBy" notEqualTo:[PFUser currentUser]];
        [query whereKey:@"Type" equalTo:selectedCategory];
        [query whereKey:@"hide" equalTo:@"0"];
        // rows = [queryWish countObjects];
        size = -1;
        [query orderByDescending:@"createdAt"];
        
        [query findObjectsInBackgroundWithBlock:^(NSArray *objectsNormal, NSError *error) {
            if(!error){
                normalRows = [objectsNormal count];
                if(normalRows - rows <20){
                    imageFilesArray =[[NSArray alloc] initWithArray:
                                      objectsNormal];
                    
                    
                    rows = [objectsNormal count];
                    _allItemLoaded = true;
                    if(rows > 100){
                        rows = 100;
                    }
                    [_imagesCollection reloadData];
                    [self hideIndicator];
                    
                    
                }else{
                    _allItemLoaded = false;
                  
                    imageFilesArray =[[NSArray alloc] initWithArray:
                                      objectsNormal];
                    rows = rows + 20;
                    if(rows > 100){
                        rows = 100;
                    }
                    [_imagesCollection reloadData];
                    [self hideIndicator];
                }
            }
            
            
            
            
        }];
              [self hideIndicator];
    }

}
-(void) reloadQuaryParseMethod{
    _categoryRefreshed = false;
    _textbookRefreshed = false;
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [query whereKey:@"createdBy" notEqualTo:[PFUser currentUser]];
    [query whereKey:@"hide" equalTo:@"0"];
    // rows = [queryWish countObjects];
    size = -1;
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objectsNormal, NSError *error) {
        if(!error){
           // normalRows = [objectsNormal count];
           // normalRows -= rows;
            if([objectsNormal count] - rows <20){
                imageFilesArray =[[NSArray alloc] initWithArray:
                                  objectsNormal];
                
                
                rows = [objectsNormal count];
                _allItemLoaded = true;
                if(rows > 100){
                    rows = 100;
                }
                [_imagesCollection reloadData];
                [self hideIndicator];
                
                
            }else{
                _allItemLoaded = false;
                
               
                imageFilesArray =[[NSArray alloc] initWithArray:
                                  objectsNormal];
                rows = rows + 20;
                if(rows > 100){
                    rows = 100;
                }
                
                [_imagesCollection reloadData];
                [self hideIndicator];
            }
        }
        
        
        //  self.imagesCollection.contentOffset = CGPointMake(0, 0 - self.imagesCollection.contentInset.top);
        
    }];
    if(rows > 100){
        rows = 100;
    }
    [self hideIndicator];
}
-(void) reloadTextbook{
    textbookSearched = true;
    
    _categoryRefreshed = false;
    _textbookRefreshed = true;
    if([courseNum isEqualToString:@""]){
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
        [query whereKey:@"TextbookInfo" containedIn:@[courseSym]];
        NSArray *textbooks = [query findObjects];
        //imageFilesArray = textbooks;
        // rows = [textbooks count];
        //[_imagesCollection reloadData];
        
        [query orderByDescending:@"createdAt"];
        if([textbooks count] - rows <20){
            imageFilesArray =[[NSArray alloc] initWithArray:
                              textbooks];
            
            
            rows = [textbooks count];
            if(rows > 100){
                rows = 100;
            }
            _allItemLoaded = true;
            [_imagesCollection reloadData];
            [self hideIndicator];
            
            
        }else{
            _allItemLoaded = false;
           
            imageFilesArray =[[NSArray alloc] initWithArray:
                              textbooks];
            rows = rows + 20;
            if(rows > 100){
                rows = 100;
            }
            [_imagesCollection reloadData];
            [self hideIndicator];
        }
        
        [self hideIndicator];
    }else{
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
        [query whereKey:@"TextbookInfo" containsAllObjectsInArray:@[courseSym , courseNum]];
        NSArray *textbooks = [query findObjects];
        
        [query orderByDescending:@"createdAt"];
        if([textbooks count] - rows <20){
            imageFilesArray =[[NSArray alloc] initWithArray:
                              textbooks];
            
            
            rows = [textbooks count];
            if(rows > 100){
                rows = 100;
            }
            _allItemLoaded = true;
            [_imagesCollection reloadData];
            [self hideIndicator];
            
            
        }else{
            _allItemLoaded = false;
                       imageFilesArray =[[NSArray alloc] initWithArray:
                              textbooks];
            rows = 20 + rows;
            if(rows > 100){
                rows = 100;
            }
            [_imagesCollection reloadData];
            [self hideIndicator];
        }
    }

    if(rows > 100){
        rows = 100;
    }
}
-(UIImage*)resizeImage:(UIImage *)image imageSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    //here is the scaled image which has been changed to the size specified
    UIGraphicsEndImageContext();
    return newImage;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _detailImageFirstOutlet.layer.borderWidth = 0;
    _detailImageSecondOutlet.layer.borderWidth = 0;
    _detailImageThirdOutlet.layer.borderWidth = 0;
    [UIView animateWithDuration:0.3 animations:^{_uniketLogo.alpha = 0.0;} completion:^(BOOL finished){

    }];
    [UIView animateWithDuration:0.3 animations:^{_searchLogo.alpha = 0.0;} completion:^(BOOL finished){
        
    }];
    
    _detailImage.image = [UIImage imageNamed:@"uniketClear.png"];
    scroller.contentOffset = CGPointMake(0, 0 - scroller.contentInset.top);
    
    PFObject *tempObject = [imageFilesArray objectAtIndex:indexPath.row];
        PFFile *imageFile = [tempObject objectForKey:@"ItemPicture"];
    tempDetailObject = tempObject;
    _detailTitle.text = [tempObject objectForKey:@"Title"];
    _detailDescription.text = [tempObject objectForKey:@"Description"];
    if([[tempObject objectForKey:@"Type"] isEqualToString:@"Textbooks"]){
        NSArray *array = [tempObject objectForKey:@"TextbookInfo"];
        NSString *courseName = [array objectAtIndex:0];
        NSString *courseNum = [array objectAtIndex:1];
        _detailCourseName.text = [NSString stringWithFormat:@"%@ %@",courseName,courseNum ];
    }else{
    _detailCourseName.text = @"";
    }
    
   [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
       tempUserID = [tempObject objectForKey:@"createdBy"];
       tempItemID = tempObject.objectId;
       if(!error){
           UIImage *ourImage = [UIImage imageWithData:data];
           _detailImageFirst.image = ourImage;
           CGImageRef ref;
           if(ourImage.size.width < ourImage.size.height){
               _detailImage.transform = CGAffineTransformMakeRotation(3.14/2);
               ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.height /8, 0, (ourImage.size.height *6)/8,ourImage.size.width ));
               
           }else{
               _detailImage.transform = CGAffineTransformMakeRotation(0);
                ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.width /8, 0, (ourImage.size.width *6)/8,ourImage.size.height  ));
           }
           _currentImage =ourImage;
           UIImage *img = [UIImage imageWithCGImage:ref];
           //_detailImage.image =[UIImage imageWithData:data];
           _detailImage.image = img;
               _detailImageFirstOutlet.layer.borderWidth = 2;
           _detailImageFirstOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
           if([[tempObject objectForKey:@"numOfPicture"] isEqualToString:@"2"]){
               PFFile *imageFileTwo = [tempObject objectForKey:@"ItemPictureTwo"];
               [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                   _detailImageSecond.image =[UIImage imageWithData:data];
                   _detailImageThird.image = nil;
                   
                            _detailImageSecondOutlet.alpha = 1.0;
                   _detailImageThirdOutlet.alpha = 0.0;
               }];
           }else if([[tempObject objectForKey:@"numOfPicture"] isEqualToString:@"3"]){
               PFFile *imageFileTwo = [tempObject objectForKey:@"ItemPictureTwo"];
               PFFile *imageFileThree = [tempObject objectForKey:@"ItemPictureThree"];
               [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                   _detailImageSecond.image =[UIImage imageWithData:data];
               }];
               [imageFileThree getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                   _detailImageThird.image =[UIImage imageWithData:data];
               }];
               
               _detailImageSecondOutlet.alpha = 1.0;
               _detailImageThirdOutlet.alpha = 1.0;
           }else{
               
               _detailImageSecond.image = nil;
                 _detailImageThird.image = nil;
               
               _detailImageSecondOutlet.alpha = 0.0;
               _detailImageThirdOutlet.alpha = 0.0;
           }

           
       }
   }];
    _wishMatchNotify.text = [NSString stringWithFormat:@"%@%@", @"$", [tempObject objectForKey:@"Price"]];
  
       // NSString *tem = [tempObject objectForKey:@"Quality"];
    //if([tem isEqualToString:@"1"]){
   //    _qualityImage.image = [UIImage imageNamed:@"star1.png"];
   // }else if([tem isEqualToString:@"2"]){
   //     _qualityImage.image = [UIImage imageNamed:@"star2.png"];
  //  }else if([tem isEqualToString:@"3"]){
   //    _qualityImage.image = [UIImage imageNamed:@"star3.png"];
   // }else if([tem isEqualToString:@"4"]){
  //     _qualityImage.image = [UIImage imageNamed:@"star4.png"];
  //  }else if([tem isEqualToString:@"5"]){
   //     _qualityImage.image = [UIImage imageNamed:@"star5.png"];
   // }

    nameWillsend =  _detailTitle.text;
    imageWillsend = _detailImage.image;
    [self animateDetailView];
    
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

-(void) queryParseMethod{
   _allItemLoaded = false;
    
    
    _categoryRefreshed = false;
    _textbookRefreshed = false;
   
    
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [query whereKey:@"createdBy" notEqualTo:[PFUser currentUser]];
     [query whereKey:@"hide" equalTo:@"0"];
    // rows = [queryWish countObjects];
    size = -1;
    [query orderByDescending:@"createdAt"];
  
    [query findObjectsInBackgroundWithBlock:^(NSArray *objectsNormal, NSError *error) {
        if(!error){
            normalRows = [objectsNormal count];
            if(normalRows <20){
                imageFilesArray =[[NSArray alloc] initWithArray:
                                  objectsNormal];
                
                
                rows = [objectsNormal count];
                [_imagesCollection reloadData];
                [self hideIndicator];
                
                
            }else{
              

                imageFilesArray =[[NSArray alloc] initWithArray:
                                  objectsNormal];
                rows = 20;
                [_imagesCollection reloadData];
                [self hideIndicator];
//                UITabBarController *tabBarController = self.tabBarController;
//                tabBarController.selectedIndex = 3;
            }
        }
        
    
         self.imagesCollection.contentOffset = CGPointMake(0, 0 - self.imagesCollection.contentInset.top);
    
    }];

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
    //[UIView animateWithDuration:0.5 animations:^{_detailView.alpha = 1.0;} completion:^(BOOL finished){
   // }];
   if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_detailView.frame = CGRectMake(0, 0, 320, 600);
    }];
//       [ UIView animateWithDuration:0.3 animations:^{self.navigationController.navigationBar.frame = CGRectMake(0, 50, 320, 506);
//       }];
    }else{
       
        [ UIView animateWithDuration:0.3 animations:^{_detailView.frame = CGRectMake(0, 0, 320, 434);
        }];
//        [ UIView animateWithDuration:0.3 animations:^{self.navigationController.navigationBar.frame = CGRectMake(0, 50, 320, 506);
//        }];
    }
    [UIView animateWithDuration:1.0 animations:^{_backButtonLogo.alpha = 1.0;} completion:^(BOOL finished){
        
    }];

}


- (IBAction)backAction:(id)sender {
//    [UIView animateWithDuration:0.5 animations:^{_detailView.alpha = 0;} completion:^(BOOL finished){
//    }];

    [UIView animateWithDuration:0.5 animations:^{_backButtonLogo.alpha = 0.0;} completion:^(BOOL finished){
        
    }];
    [UIView animateWithDuration:0.3 animations:^{_uniketLogo.alpha = 1.0;} completion:^(BOOL finished){
        
    }];
    [UIView animateWithDuration:0.3 animations:^{_searchLogo.alpha = 1.0;} completion:^(BOOL finished){
        
    }];
   if(iphoneFour == false){
    [ UIView animateWithDuration:0.3 animations:^{_detailView.frame = CGRectMake(320, 0, 320, 600);
    }];
    }else{
        [ UIView animateWithDuration:0.3 animations:^{_detailView.frame = CGRectMake(320, 0, 320, 434);
        }];
    }
}
- (IBAction)reportButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Report Item"
                          message:@"Are you sure you want to report this item as abuse?"
                          delegate:self
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"Yes, I'm Sure", @"No", nil];
    [alert show];
}


- (IBAction)categoryAction:(id)sender {
    [ UIView animateWithDuration:0.3 animations:^{_categoryView.frame = CGRectMake(0, 0, 320, 568);
    }];
    [ UIView animateWithDuration:0.3 animations:^{ self.tabBarController.tabBar.frame = CGRectMake(0, 600, 320, 49);
    }];
  
    PFQuery *query = [PFQuery queryWithClassName:@"AdBoard"];
    [query whereKey:@"status" equalTo:@"1"];
    [query orderByDescending:@"order"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            imageOne = [objects objectAtIndex:0];
            PFFile *imageFileOne = [imageOne objectForKey:@"boardCornerImage"];
            PFFile *mainImageOne = [imageOne objectForKey:@"image"];
            
            boardPriceOne.text = [imageOne objectForKey:@"price"];
            boardContentOne.text = [imageOne objectForKey:@"content"];
            [imageFileOne getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    //CGSize size=CGSizeMake(251, 192);
                    //UIImage *resizedImage= [self resizeImage:[UIImage imageWithData:data] imageSize:size];
                    
                   
                     boardViewOne.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:data]];
                }
            }];
            [mainImageOne getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    //CGSize size=CGSizeMake(251, 192);
                    //UIImage *resizedImage= [self resizeImage:[UIImage imageWithData:data] imageSize:size];
                    
                    boardImageOne.image =[UIImage imageWithData:data];
                }
            }];
            imageTwo = [objects objectAtIndex:1];
            PFFile *imageFileTwo = [imageTwo objectForKey:@"boardCornerImage"];
            PFFile *mainImageTwo = [imageTwo objectForKey:@"image"];
            boardPriceTwo.text = [imageTwo objectForKey:@"price"];
               boardContentTwo.text = [imageTwo objectForKey:@"content"];
            [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    //CGSize size=CGSizeMake(251, 192);
                    //UIImage *resizedImage= [self resizeImage:[UIImage imageWithData:data] imageSize:size];
                
                    boardViewTwo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:data]];
                }
            }];
            [mainImageTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    //CGSize size=CGSizeMake(251, 192);
                    //UIImage *resizedImage= [self resizeImage:[UIImage imageWithData:data] imageSize:size];
                    
                    boardImageTwo.image =[UIImage imageWithData:data];
                }
            }];
            imageThree = [objects objectAtIndex:2];
            PFFile *imageFileThree = [imageThree objectForKey:@"boardCornerImage"];
            PFFile *mainImageThree = [imageThree objectForKey:@"image"];
            boardPriceThree.text = [imageThree objectForKey:@"price"];
             boardContentThree.text = [imageThree objectForKey:@"content"];
            [imageFileThree getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    //CGSize size=CGSizeMake(251, 192);
                    //UIImage *resizedImage= [self resizeImage:[UIImage imageWithData:data] imageSize:size];
                    
                    boardViewThree.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:data]];
                }
            }];
            [mainImageThree getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if(!error){
                    //CGSize size=CGSizeMake(251, 192);
                    //UIImage *resizedImage= [self resizeImage:[UIImage imageWithData:data] imageSize:size];
                    
                    boardImageThree.image =[UIImage imageWithData:data];
                }
            }];
            
            

            
          
        }
    }];
    [self performSelector:@selector(categoryViewAdAction) withObject:nil afterDelay:0.3];
 
    
    
   myTimer =  [NSTimer scheduledTimerWithTimeInterval:7 target:self selector:@selector(adMoving) userInfo:nil
                                    repeats:YES];
    
    //self.tabBarController.tabBar.hidden = YES;
   // _categoryView.userInteractionEnabled = YES;
    _textbookInfoView.alpha = 0.0;

}
-(void) categoryViewAdAction{
    [ UIView animateWithDuration:0.0 animations:^{ [searchViewScroller setContentOffset:
                                                    CGPointMake(0, searchViewScroller.contentOffset.y)
                                                                               animated:NO];}];
}

-(void) adMoving{
    float x = searchViewScroller.contentOffset.x;
    
    if(x < 320){
        [searchViewScroller setContentOffset:
         CGPointMake(320, searchViewScroller.contentOffset.y)
                             animated:YES];
    }else if(x >= 320 && x < 640){
        [searchViewScroller setContentOffset:
         CGPointMake(640, searchViewScroller.contentOffset.y)
                                    animated:YES];
    }else{
        [searchViewScroller setContentOffset:
         CGPointMake(0, searchViewScroller.contentOffset.y)
                                    animated:YES];
    }
}
- (IBAction)categoryGoBack:(id)sender {
    //self.navigationController.navigationBar.hidden = NO;
    //self.tabBarController.tabBar.hidden = NO;
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    [ UIView animateWithDuration:0.5 animations:^{ self.tabBarController.tabBar.frame = CGRectMake(0, screenRect.size.height - 49, 320, 49);
    }];
    [ UIView animateWithDuration:0.5 animations:^{_categoryView.frame = CGRectMake(-320, 0, 320, 568);
    }];
    [myTimer invalidate];
    [searchViewScroller setContentOffset:
     CGPointMake(640, searchViewScroller.contentOffset.y)
                                animated:NO];

    
}

- (IBAction)categorySelected:(id)sender {
    [ UIView animateWithDuration:0.5 animations:^{_categoryView.frame = CGRectMake(-320, 0, 320, 568);
    }];
    selectedCategory = [categoryArray objectAtIndex:[categoryPicker selectedRowInComponent:0]];
    [self showIndicator];
    [myTimer invalidate];
    [searchViewScroller setContentOffset:
     CGPointMake(640, searchViewScroller.contentOffset.y)
                                animated:NO];
   [self performSelector:@selector(categoryParseMethod) withObject:nil afterDelay:0.7];
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    [ UIView animateWithDuration:0.5 animations:^{ self.tabBarController.tabBar.frame = CGRectMake(0, screenRect.size.height - 49, 320, 49);
    }];

    
}

-(void) categoryParseMethod{
    _allItemLoaded = false;
    _categoryRefreshed = true;
    _textbookRefreshed = false;
    textbookSearched = false;
    [UIView beginAnimations:nil
                    context:NULL];
    [UIView setAnimationDuration:0.3];
    _selectTypeView.frame =CGRectMake(0, 600, 320, 300);
    [UIView commitAnimations];
    [UIView beginAnimations:nil
                    context:NULL];
    [UIView setAnimationDuration:0.3];
    _selectCourseView.frame =CGRectMake(0, 600, 320, 300);
    [UIView commitAnimations];
  
    if([selectedCategory isEqualToString:@"All"]){
        [self queryParseMethod];
        
    }else{
    
    PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
    [query whereKey:@"createdBy" notEqualTo:[PFUser currentUser]];
    [query whereKey:@"Type" equalTo:selectedCategory];
    [query whereKey:@"hide" equalTo:@"0"];
    // rows = [queryWish countObjects];
    size = -1;
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objectsNormal, NSError *error) {
        if(!error){
            normalRows = [objectsNormal count];
            if(normalRows <20){
                imageFilesArray =[[NSArray alloc] initWithArray:
                                  objectsNormal];
                
                
                rows = [objectsNormal count];
                [_imagesCollection reloadData];
                [self hideIndicator];
                
                
            }else{
                
               
                imageFilesArray =[[NSArray alloc] initWithArray:
                                  objectsNormal];
                rows = 20;
                [_imagesCollection reloadData];
                [self hideIndicator];
            }
        }
        
        
        
        
    }];
     self.imagesCollection.contentOffset = CGPointMake(0, 0 - self.imagesCollection.contentInset.top);
    [self hideIndicator];
    }
}

- (IBAction)textbookAction:(id)sender {
    [ UIView animateWithDuration:0.5 animations:^{_categoryView.frame = CGRectMake(-320, 0, 320, 568);
    }];
    selectedCategory = [textbookArray objectAtIndex:[textbookPicker selectedRowInComponent:0]];
    [self showIndicator];
    [self performSelector:@selector(textbookParseMethod) withObject:nil afterDelay:0.7];

}

//-(void) textbookParseMethod{
//    [UIView beginAnimations:nil
//                    context:NULL];
//    [UIView setAnimationDuration:0.3];
//    _selectTypeView.frame =CGRectMake(0, 600, 320, 300);
//    [UIView commitAnimations];
//    [UIView beginAnimations:nil
//                    context:NULL];
//    [UIView setAnimationDuration:0.3];
//    _selectCourseView.frame =CGRectMake(0, 600, 320, 300);
//    [UIView commitAnimations];
//    
// 
//    
//        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier]];
//        [query whereKey:@"createdBy" notEqualTo:[PFUser currentUser]];
//        [query whereKey:@"Type" equalTo:selectedCategory];
//        [query whereKey:@"hide" equalTo:@"0"];
//        // rows = [queryWish countObjects];
//        size = -1;
//        
//        
//        [query findObjectsInBackgroundWithBlock:^(NSArray *objectsNormal, NSError *error) {
//            if(!error){
//                normalRows = [objectsNormal count];
//                if(normalRows <20){
//                    imageFilesArray =[[NSArray alloc] initWithArray:
//                                      objectsNormal];
//                    
//                    
//                    rows = [objectsNormal count];
//                    [_imagesCollection reloadData];
//                    [self hideIndicator];
//                    
//                    
//                }else{
//                    
//                    NSInteger index1, index2, index3, index4 ,index5,index6, index7
//                    ,index8, index9, index10, index11, index12, index13, index14, index15, index16,index17
//                    ,index18, index19, index20;
//                    
//                    index1 = arc4random() % normalRows;
//                    index2 = arc4random() % normalRows;
//                    index3 = arc4random() % normalRows;
//                    index4 = arc4random() % normalRows;
//                    index5 = arc4random() % normalRows;
//                    
//                    
//                    
//                    index6 = arc4random() % normalRows;
//                    index7 = arc4random() % normalRows;
//                    index8 = arc4random() % normalRows;
//                    index9 = arc4random() % normalRows;
//                    index10 = arc4random() % normalRows;
//                    
//                    
//                    index11 = arc4random() % normalRows;
//                    index12 = arc4random() % normalRows;
//                    index13 = arc4random() % normalRows;
//                    index14 = arc4random() % normalRows;
//                    index15 = arc4random() % normalRows;
//                    index16 = arc4random() % normalRows;
//                    index17 = arc4random() % normalRows;
//                    index18 = arc4random() % normalRows;
//                    index19 = arc4random() % normalRows;
//                    index20 = arc4random() % normalRows;
//                    
//                    
//                    randomObject = [NSArray arrayWithObjects:[objectsNormal objectAtIndex:index1], [objectsNormal objectAtIndex:index2],[objectsNormal objectAtIndex:index3],[objectsNormal objectAtIndex:index4],[objectsNormal objectAtIndex:index5],[objectsNormal objectAtIndex:index6],[objectsNormal objectAtIndex:index7],[objectsNormal objectAtIndex:index8],[objectsNormal objectAtIndex:index9],[objectsNormal objectAtIndex:index10],[objectsNormal objectAtIndex:index11],[objectsNormal objectAtIndex:index12],[objectsNormal objectAtIndex:index13],[objectsNormal objectAtIndex:index14],[objectsNormal objectAtIndex:index15],[objectsNormal objectAtIndex:index16],[objectsNormal objectAtIndex:index17],[objectsNormal objectAtIndex:index18],[objectsNormal objectAtIndex:index19], [objectsNormal objectAtIndex:index20], nil];
//                    imageFilesArray =[[NSArray alloc] initWithArray:
//                                      randomObject];
//                    rows = 20;
//                    [_imagesCollection reloadData];
//                    [self hideIndicator];
//                }
//            }
//            
//            
//            
//            
//        }];
//        self.imagesCollection.contentOffset = CGPointMake(0, 0 - self.imagesCollection.contentInset.top);
//        [self hideIndicator];
//    
//}
- (IBAction)normalSearch:(id)sender {
    if(iphoneFour == false){
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _selectCourseView.frame =CGRectMake(0, 600, 320, 300);
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _selectCourseView.frame =CGRectMake(0, 600, 320, 300);
        [UIView commitAnimations];
    }
    if(iphoneFour == false){
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _selectTypeView.frame =CGRectMake(0, 351, 320, 300);
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:nil
                        context:NULL];
        [UIView setAnimationDuration:0.3];
        _selectTypeView.frame =CGRectMake(0, 280, 320, 300);
        [UIView commitAnimations];
    }
    //   [blackview removeFromSuperview];
    _textbookInfoView.alpha = 0.0;
}

- (IBAction)textbookSearch:(id)sender {
    
    if(_textbookInfoView.alpha == 1.0){
        _textbookInfoView.alpha = 0.0;
    }else{
    _textbookInfoView.alpha = 1.0;
    }
    if(iphoneFour == false){
               [UIView beginAnimations:nil
                                context:NULL];
               [UIView setAnimationDuration:0.3];
                _selectTypeView.frame =CGRectMake(0, 600, 320, 300);
                [UIView commitAnimations];
            }else{
                [UIView beginAnimations:nil
                                context:NULL];
                [UIView setAnimationDuration:0.3];
                _selectTypeView.frame =CGRectMake(0, 600, 320, 300);
                [UIView commitAnimations];
            }
    [myTimer invalidate];
    [searchViewScroller setContentOffset:
     CGPointMake(640, searchViewScroller.contentOffset.y)
                                animated:YES];
       [blackview removeFromSuperview];

 
}
- (IBAction)textbookSearchGoAction:(id)sender {
    if([_symbolField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Course Information" message:@"Please type the symbol of the course you are looking for" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }else{
    [UIView beginAnimations:nil
                    context:NULL];
    [UIView setAnimationDuration:0.3];
    _selectTypeView.frame =CGRectMake(0, 600, 320, 300);
    [UIView commitAnimations];
    [UIView beginAnimations:nil
                    context:NULL];
    [UIView setAnimationDuration:0.3];
    _selectCourseView.frame =CGRectMake(0, 600, 320, 300);
    [UIView commitAnimations];


    [ UIView animateWithDuration:0.5 animations:^{_categoryView.frame = CGRectMake(-320, 0, 320, 568);
    }];
        courseNum =[_numberField.text uppercaseString];
        courseSym =[_symbolField.text uppercaseString];
     [[self view] endEditing:YES];
        [self showIndicator];
         [self performSelector:@selector(textbookSearch) withObject:nil afterDelay:0.7];
    }
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    [ UIView animateWithDuration:0.5 animations:^{ self.tabBarController.tabBar.frame = CGRectMake(0, screenRect.size.height - 49, 320, 49);
    }];
       _categoryView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"searchView.png"]];
    CGRect view = _textbookInfoView.frame;
    view.origin.x = 0;
    view.origin.y = 321;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    _textbookInfoView.frame = view;
       [blackview removeFromSuperview];
    _textbookInfoView.backgroundColor = [UIColor clearColor];
    [UIView commitAnimations];
     [[self view] endEditing:YES];
    
}
-(void) textbookSearch{
    _allItemLoaded = false;
    _categoryRefreshed = false;
    _textbookRefreshed = true;
    textbookSearched = true;
    if([courseNum isEqualToString:@""]){
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
        
        
        [query whereKey:@"TextbookInfo" containedIn:@[courseSym]];
        NSArray *textbooks = [query findObjects];
        //imageFilesArray = textbooks;
       // rows = [textbooks count];
        //[_imagesCollection reloadData];
        
        [query orderByDescending:@"createdAt"];
        if([textbooks count] <20){
            imageFilesArray =[[NSArray alloc] initWithArray:
                              textbooks];
            
            
            rows = [textbooks count];
            [_imagesCollection reloadData];
            [self hideIndicator];
            
            
        }else{
            
           
            imageFilesArray =[[NSArray alloc] initWithArray:
                              textbooks];
            rows = 20;
            [_imagesCollection reloadData];
            [self hideIndicator];
        }

        [self hideIndicator];
    }else{
        PFQuery *query = [PFQuery queryWithClassName:[NSString stringWithFormat:@"ProductData%@",scopeIdentifier ]];
        [query whereKey:@"TextbookInfo" containsAllObjectsInArray:@[courseSym , courseNum]];
        NSArray *textbooks = [query findObjects];
        if([textbooks count] <20){
            imageFilesArray =[[NSArray alloc] initWithArray:
                              textbooks];
            
            
            rows = [textbooks count];
            [_imagesCollection reloadData];
            [self hideIndicator];
            
            
        }else{
            
           
            imageFilesArray =[[NSArray alloc] initWithArray:
                              textbooks];
            rows = 20;
            [_imagesCollection reloadData];
            [self hideIndicator];
        }
    }

}


- (IBAction)symbolEditStart:(id)sender {
    if(iphoneFour == true){
        CGRect view = _textbookInfoView.frame;
        view.origin.x = 0;
        view.origin.y = 235;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _textbookInfoView.frame = view;
         _textbookInfoView.backgroundColor = [UIColor whiteColor];
        [UIView commitAnimations];
    }else{
        CGRect view = _textbookInfoView.frame;
        view.origin.x = 0;
        view.origin.y = 235;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _textbookInfoView.frame = view;
         _textbookInfoView.backgroundColor = [UIColor whiteColor];
        [UIView commitAnimations];
    }
    
    //add black view
    blackview = [[UIView alloc] initWithFrame:CGRectMake(0, 67, 320, 170)];
    
    blackview.backgroundColor = [UIColor blackColor];
    [_categoryView addSubview:blackview];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];               //Change the "2" to the desired duration
    
     _categoryView.backgroundColor  = [UIColor blackColor];
    
    [UIView commitAnimations];
     //  _categoryView.backgroundColor = [UIColor blackColor];
}

- (IBAction)numberEditStart:(id)sender {
    if(iphoneFour == true){
        CGRect view = _textbookInfoView.frame;
        view.origin.x = 0;
        view.origin.y = 235;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _textbookInfoView.frame = view;
         _textbookInfoView.backgroundColor = [UIColor whiteColor];
        [UIView commitAnimations];
    }else{
        CGRect view = _textbookInfoView.frame;
        view.origin.x = 0;
        view.origin.y = 235;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        _textbookInfoView.frame = view;
        _textbookInfoView.backgroundColor = [UIColor whiteColor];
        [UIView commitAnimations];
    }
    
    //add black view
    blackview = [[UIView alloc] initWithFrame:CGRectMake(0, 67, 320, 170)];
    
    blackview.backgroundColor = [UIColor blackColor];
 
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];               //Change the "2" to the desired duration
       [_categoryView addSubview:blackview];
    _categoryView.backgroundColor  = [UIColor blackColor];
    
    [UIView commitAnimations];
}
- (IBAction)imageBig:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{_bigImageView.alpha = 1.0;} completion:^(BOOL finished){
        
    }];
    [UIView animateWithDuration:0.3 animations:^{_backButtonLogo.alpha = 0.0;} completion:^(BOOL finished){
        
    }];
    _bigImage.image = _currentImage;
}
- (IBAction)imageBigBack:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{_bigImageView.alpha = 0.0;} completion:^(BOOL finished){
        
    }];
    [UIView animateWithDuration:0.3 animations:^{_backButtonLogo.alpha = 1.0;} completion:^(BOOL finished){
        
    }];
}
- (IBAction)detailImageFirstAction:(id)sender {
    _currentImage = _detailImageFirst.image;
    
    
    UIImage *ourImage = _detailImageFirst.image;

    CGImageRef ref;
    if(ourImage.size.width < ourImage.size.height){
        _detailImage.transform = CGAffineTransformMakeRotation(3.14/2);
        ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.height /8, 0, (ourImage.size.height *6)/8,ourImage.size.width ));
        
    }else{
        _detailImage.transform = CGAffineTransformMakeRotation(0);
        ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.width /8, 0, (ourImage.size.width *6)/8,ourImage.size.height  ));
    }
    UIImage *img = [UIImage imageWithCGImage:ref];
    //_detailImage.image =[UIImage imageWithData:data];
    _detailImage.image = img;

         _detailImageFirstOutlet.layer.borderWidth = 2;
    _detailImageSecondOutlet.layer.borderWidth = 0;
    _detailImageThirdOutlet.layer.borderWidth = 0;
      _detailImageFirstOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (IBAction)detailImageSecondAction:(id)sender {
    _currentImage = _detailImageSecond.image;
    
    
    UIImage *ourImage = _detailImageSecond.image;

    CGImageRef ref;
    if(ourImage.size.width < ourImage.size.height){
        _detailImage.transform = CGAffineTransformMakeRotation(3.14/2);
        ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.height /8, 0, (ourImage.size.height *6)/8,ourImage.size.width ));
        
    }else{
        _detailImage.transform = CGAffineTransformMakeRotation(0);
        ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.width /8, 0, (ourImage.size.width *6)/8,ourImage.size.height  ));
    }
    UIImage *img = [UIImage imageWithCGImage:ref];
    //_detailImage.image =[UIImage imageWithData:data];
    _detailImage.image = img;
          _detailImageFirstOutlet.layer.borderWidth = 0;
     _detailImageSecondOutlet.layer.borderWidth = 2;
    _detailImageSecondOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
       _detailImageThirdOutlet.layer.borderWidth = 0;
}
- (IBAction)detailImageThirdAction:(id)sender {
    _currentImage = _detailImageThird.image;
    
    
    UIImage *ourImage = _detailImageThird.image;
    
    CGImageRef ref;
    if(ourImage.size.width < ourImage.size.height){
        _detailImage.transform = CGAffineTransformMakeRotation(3.14/2);
        ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.height /8, 0, (ourImage.size.height *6)/8,ourImage.size.width ));
        
    }else{
        _detailImage.transform = CGAffineTransformMakeRotation(0);
        ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.width /8, 0, (ourImage.size.width *6)/8,ourImage.size.height  ));
    }
    UIImage *img = [UIImage imageWithCGImage:ref];
    //_detailImage.image =[UIImage imageWithData:data];
    _detailImage.image = img;
    _detailImageFirstOutlet.layer.borderWidth = 0;
      _detailImageSecondOutlet.layer.borderWidth = 0;
    _detailImageThirdOutlet.layer.borderWidth = 2;
    _detailImageThirdOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
    

}

- (IBAction)placeOrderAction:(id)sender {
    
    [self performSegueWithIdentifier:@"sendOwnerID" sender:self];
}
- (IBAction)boardViewAction:(id)sender {
    
    PFQuery *tempQuery = [PFQuery queryWithClassName:@"ProductData"];
    if(![[imageOne objectForKey:@"objID"]isEqualToString:@"NO"]){
    [tempQuery getObjectInBackgroundWithId:[imageOne objectForKey:@"objID"] block:^(PFObject *object, NSError *error) {
        _detailImageFirstOutlet.layer.borderWidth = 0;
        _detailImageSecondOutlet.layer.borderWidth = 0;
        _detailImageThirdOutlet.layer.borderWidth = 0;
        [UIView animateWithDuration:0.3 animations:^{_uniketLogo.alpha = 0.0;} completion:^(BOOL finished){
            
        }];
        [UIView animateWithDuration:0.3 animations:^{_searchLogo.alpha = 0.0;} completion:^(BOOL finished){
            
        }];
        
        _detailImage.image = [UIImage imageNamed:@"uniketClear.png"];
        scroller.contentOffset = CGPointMake(0, 0 - scroller.contentInset.top);
        
        
        PFFile *imageFile = [object objectForKey:@"ItemPicture"];
        tempDetailObject = object;
        _detailTitle.text = [object objectForKey:@"Title"];
        _detailDescription.text = [object objectForKey:@"Description"];
        if([[object objectForKey:@"Type"] isEqualToString:@"Textbooks"]){
            NSArray *array = [object objectForKey:@"TextbookInfo"];
            NSString *courseName = [array objectAtIndex:0];
            NSString *courseNum = [array objectAtIndex:1];
            _detailCourseName.text = [NSString stringWithFormat:@"%@ %@",courseName,courseNum ];
        }else{
            _detailCourseName.text = @"";
        }
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            tempUserID = [object objectForKey:@"createdBy"];
            tempItemID = object.objectId;
            if(!error){
                UIImage *ourImage = [UIImage imageWithData:data];
                _detailImageFirst.image = ourImage;
                CGImageRef ref;
                if(ourImage.size.width < ourImage.size.height){
                    _detailImage.transform = CGAffineTransformMakeRotation(3.14/2);
                    ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.height /8, 0, (ourImage.size.height *6)/8,ourImage.size.width ));
                    
                }else{
                    _detailImage.transform = CGAffineTransformMakeRotation(0);
                    ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.width /8, 0, (ourImage.size.width *6)/8,ourImage.size.height  ));
                }
                _currentImage =ourImage;
                UIImage *img = [UIImage imageWithCGImage:ref];
                //_detailImage.image =[UIImage imageWithData:data];
                _detailImage.image = img;
                _detailImageFirstOutlet.layer.borderWidth = 2;
                _detailImageFirstOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
                if([[object objectForKey:@"numOfPicture"] isEqualToString:@"2"]){
                    PFFile *imageFileTwo = [object objectForKey:@"ItemPictureTwo"];
                    [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageSecond.image =[UIImage imageWithData:data];
                        _detailImageThird.image = nil;
                        
                        _detailImageSecondOutlet.alpha = 1.0;
                        _detailImageThirdOutlet.alpha = 0.0;
                    }];
                }else if([[object objectForKey:@"numOfPicture"] isEqualToString:@"3"]){
                    PFFile *imageFileTwo = [object objectForKey:@"ItemPictureTwo"];
                    PFFile *imageFileThree = [object objectForKey:@"ItemPictureThree"];
                    [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageSecond.image =[UIImage imageWithData:data];
                    }];
                    [imageFileThree getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageThird.image =[UIImage imageWithData:data];
                    }];
                    
                    _detailImageSecondOutlet.alpha = 1.0;
                    _detailImageThirdOutlet.alpha = 1.0;
                }else{
                    
                    _detailImageSecond.image = nil;
                    _detailImageThird.image = nil;
                    
                    _detailImageSecondOutlet.alpha = 0.0;
                    _detailImageThirdOutlet.alpha = 0.0;
                }
                
                
            }
        }];
        _wishMatchNotify.text = [NSString stringWithFormat:@"%@%@", @"$", [object objectForKey:@"Price"]];
        
        
        nameWillsend =  _detailTitle.text;
        imageWillsend = _detailImage.image;
        [self animateDetailView];
    }];

    CGRect screenRect = [[UIScreen mainScreen]bounds];
    [ UIView animateWithDuration:0.5 animations:^{ self.tabBarController.tabBar.frame = CGRectMake(0, screenRect.size.height - 49, 320, 49);
    }];
    [ UIView animateWithDuration:0.5 animations:^{_categoryView.frame = CGRectMake(-320, 0, 320, 568);
    }];
     
    [myTimer invalidate];
    [searchViewScroller setContentOffset:
     CGPointMake(640, searchViewScroller.contentOffset.y)
                                animated:NO];
    }
}

- (IBAction)boardViewActionTwo:(id)sender {
    PFQuery *tempQuery = [PFQuery queryWithClassName:@"ProductData"];
    if(![[imageTwo objectForKey:@"objID"]  isEqualToString:@"NO"]){
    [tempQuery getObjectInBackgroundWithId:[imageTwo objectForKey:@"objID"] block:^(PFObject *object, NSError *error) {
        _detailImageFirstOutlet.layer.borderWidth = 0;
        _detailImageSecondOutlet.layer.borderWidth = 0;
        _detailImageThirdOutlet.layer.borderWidth = 0;
        [UIView animateWithDuration:0.3 animations:^{_uniketLogo.alpha = 0.0;} completion:^(BOOL finished){
            
        }];
        [UIView animateWithDuration:0.3 animations:^{_searchLogo.alpha = 0.0;} completion:^(BOOL finished){
            
        }];
        
        _detailImage.image = [UIImage imageNamed:@"uniketClear.png"];
        scroller.contentOffset = CGPointMake(0, 0 - scroller.contentInset.top);
        
        
        PFFile *imageFile = [object objectForKey:@"ItemPicture"];
        tempDetailObject = object;
        _detailTitle.text = [object objectForKey:@"Title"];
        _detailDescription.text = [object objectForKey:@"Description"];
        if([[object objectForKey:@"Type"] isEqualToString:@"Textbooks"]){
            NSArray *array = [object objectForKey:@"TextbookInfo"];
            NSString *courseName = [array objectAtIndex:0];
            NSString *courseNum = [array objectAtIndex:1];
            _detailCourseName.text = [NSString stringWithFormat:@"%@ %@",courseName,courseNum ];
        }else{
            _detailCourseName.text = @"";
        }
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            tempUserID = [object objectForKey:@"createdBy"];
            tempItemID = object.objectId;
            if(!error){
                UIImage *ourImage = [UIImage imageWithData:data];
                _detailImageFirst.image = ourImage;
                CGImageRef ref;
                if(ourImage.size.width < ourImage.size.height){
                    _detailImage.transform = CGAffineTransformMakeRotation(3.14/2);
                    ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.height /8, 0, (ourImage.size.height *6)/8,ourImage.size.width ));
                    
                }else{
                    _detailImage.transform = CGAffineTransformMakeRotation(0);
                    ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.width /8, 0, (ourImage.size.width *6)/8,ourImage.size.height  ));
                }
                _currentImage =ourImage;
                UIImage *img = [UIImage imageWithCGImage:ref];
                //_detailImage.image =[UIImage imageWithData:data];
                _detailImage.image = img;
                _detailImageFirstOutlet.layer.borderWidth = 2;
                _detailImageFirstOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
                if([[object objectForKey:@"numOfPicture"] isEqualToString:@"2"]){
                    PFFile *imageFileTwo = [object objectForKey:@"ItemPictureTwo"];
                    [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageSecond.image =[UIImage imageWithData:data];
                        _detailImageThird.image = nil;
                        
                        _detailImageSecondOutlet.alpha = 1.0;
                        _detailImageThirdOutlet.alpha = 0.0;
                    }];
                }else if([[object objectForKey:@"numOfPicture"] isEqualToString:@"3"]){
                    PFFile *imageFileTwo = [object objectForKey:@"ItemPictureTwo"];
                    PFFile *imageFileThree = [object objectForKey:@"ItemPictureThree"];
                    [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageSecond.image =[UIImage imageWithData:data];
                    }];
                    [imageFileThree getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageThird.image =[UIImage imageWithData:data];
                    }];
                    
                    _detailImageSecondOutlet.alpha = 1.0;
                    _detailImageThirdOutlet.alpha = 1.0;
                }else{
                    
                    _detailImageSecond.image = nil;
                    _detailImageThird.image = nil;
                    
                    _detailImageSecondOutlet.alpha = 0.0;
                    _detailImageThirdOutlet.alpha = 0.0;
                }
                
                
            }
        }];
        _wishMatchNotify.text = [NSString stringWithFormat:@"%@%@", @"$", [object objectForKey:@"Price"]];
        
        
        nameWillsend =  _detailTitle.text;
        imageWillsend = _detailImage.image;
        [self animateDetailView];
    }];

    CGRect screenRect = [[UIScreen mainScreen]bounds];
    [ UIView animateWithDuration:0.5 animations:^{ self.tabBarController.tabBar.frame = CGRectMake(0, screenRect.size.height - 49, 320, 49);
    }];
    [ UIView animateWithDuration:0.5 animations:^{_categoryView.frame = CGRectMake(-320, 0, 320, 568);
    }];
   
    [myTimer invalidate];
    [searchViewScroller setContentOffset:
     CGPointMake(640, searchViewScroller.contentOffset.y)
                                animated:NO];
    }
}

- (IBAction)boardViewActionThree:(id)sender {
    PFQuery *tempQuery = [PFQuery queryWithClassName:@"ProductData"];
    if(![[imageThree objectForKey:@"objID"] isEqualToString:@"NO"]){
    [tempQuery getObjectInBackgroundWithId:[imageThree objectForKey:@"objID"] block:^(PFObject *object, NSError *error) {
        _detailImageFirstOutlet.layer.borderWidth = 0;
        _detailImageSecondOutlet.layer.borderWidth = 0;
        _detailImageThirdOutlet.layer.borderWidth = 0;
        [UIView animateWithDuration:0.3 animations:^{_uniketLogo.alpha = 0.0;} completion:^(BOOL finished){
            
        }];
        [UIView animateWithDuration:0.3 animations:^{_searchLogo.alpha = 0.0;} completion:^(BOOL finished){
            
        }];
        
        _detailImage.image = [UIImage imageNamed:@"uniketClear.png"];
        scroller.contentOffset = CGPointMake(0, 0 - scroller.contentInset.top);
        
        
        PFFile *imageFile = [object objectForKey:@"ItemPicture"];
        tempDetailObject = object;
        _detailTitle.text = [object objectForKey:@"Title"];
        _detailDescription.text = [object objectForKey:@"Description"];
        if([[object objectForKey:@"Type"] isEqualToString:@"Textbooks"]){
            NSArray *array = [object objectForKey:@"TextbookInfo"];
            NSString *courseName = [array objectAtIndex:0];
            NSString *courseNum = [array objectAtIndex:1];
            _detailCourseName.text = [NSString stringWithFormat:@"%@ %@",courseName,courseNum ];
        }else{
            _detailCourseName.text = @"";
        }
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            tempUserID = [object objectForKey:@"createdBy"];
            tempItemID = object.objectId;
            if(!error){
                UIImage *ourImage = [UIImage imageWithData:data];
                _detailImageFirst.image = ourImage;
                CGImageRef ref;
                if(ourImage.size.width < ourImage.size.height){
                    _detailImage.transform = CGAffineTransformMakeRotation(3.14/2);
                    ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.height /8, 0, (ourImage.size.height *6)/8,ourImage.size.width ));
                    
                }else{
                    _detailImage.transform = CGAffineTransformMakeRotation(0);
                    ref = CGImageCreateWithImageInRect(ourImage.CGImage, CGRectMake(ourImage.size.width /8, 0, (ourImage.size.width *6)/8,ourImage.size.height  ));
                }
                _currentImage =ourImage;
                UIImage *img = [UIImage imageWithCGImage:ref];
                //_detailImage.image =[UIImage imageWithData:data];
                _detailImage.image = img;
                _detailImageFirstOutlet.layer.borderWidth = 2;
                _detailImageFirstOutlet.layer.borderColor = [UIColor whiteColor].CGColor;
                if([[object objectForKey:@"numOfPicture"] isEqualToString:@"2"]){
                    PFFile *imageFileTwo = [object objectForKey:@"ItemPictureTwo"];
                    [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageSecond.image =[UIImage imageWithData:data];
                        _detailImageThird.image = nil;
                        
                        _detailImageSecondOutlet.alpha = 1.0;
                        _detailImageThirdOutlet.alpha = 0.0;
                    }];
                }else if([[object objectForKey:@"numOfPicture"] isEqualToString:@"3"]){
                    PFFile *imageFileTwo = [object objectForKey:@"ItemPictureTwo"];
                    PFFile *imageFileThree = [object objectForKey:@"ItemPictureThree"];
                    [imageFileTwo getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageSecond.image =[UIImage imageWithData:data];
                    }];
                    [imageFileThree getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _detailImageThird.image =[UIImage imageWithData:data];
                    }];
                    
                    _detailImageSecondOutlet.alpha = 1.0;
                    _detailImageThirdOutlet.alpha = 1.0;
                }else{
                    
                    _detailImageSecond.image = nil;
                    _detailImageThird.image = nil;
                    
                    _detailImageSecondOutlet.alpha = 0.0;
                    _detailImageThirdOutlet.alpha = 0.0;
                }
                
                
            }
        }];
        _wishMatchNotify.text = [NSString stringWithFormat:@"%@%@", @"$", [object objectForKey:@"Price"]];
        
        
        nameWillsend =  _detailTitle.text;
        imageWillsend = _detailImage.image;
        [self animateDetailView];
    }];
    
    CGRect screenRect = [[UIScreen mainScreen]bounds];
    [ UIView animateWithDuration:0.5 animations:^{ self.tabBarController.tabBar.frame = CGRectMake(0, screenRect.size.height - 49, 320, 49);
    }];
    [ UIView animateWithDuration:0.5 animations:^{_categoryView.frame = CGRectMake(-320, 0, 320, 568);
    }];

    [myTimer invalidate];
    [searchViewScroller setContentOffset:
     CGPointMake(640, searchViewScroller.contentOffset.y)
                                animated:NO];
    }
}
@end
