
#import <UIKit/UIKit.h>
#import "HomeTableViewCell.h"
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import "DataObject.h"
#define CATEGORY 0
#define TEXTBOOK 1

@interface HomePageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>{
    
    NSArray *imageFilesArray;
    NSArray *titleArray;
    NSArray *descriptionArray;
    NSMutableArray *imagesArray;
   
    NSString *tempUserID;
    NSString *tempItemID;
    NSInteger rows;
     NSTimer *myTimer;
    __weak IBOutlet UIPickerView *categoryPicker;
    __weak IBOutlet UIPickerView *textbookPicker;
    NSArray *randomObject;
    
    NSInteger maxSize;
    PFObject *wishObject;
    NSString *typeItem;
    NSInteger size;
    NSInteger normalRows;
    
    NSInteger randomRows;
    
    __weak IBOutlet UIView *indicatorView;
    NSString *typeWillsend;
    NSString *nameWillsend;
    UIImage *imageWillsend;
    //NSArray queryWish
    PFObject *tempDetailObject;
    __weak IBOutlet UIActivityIndicatorView *indicator;
    NSArray *arrayWishes;
    
    NSString *scopeIdentifier;
    
    NSMutableArray *categoryArray;
    NSString *selectedCategory;
    NSMutableArray *textbookArray;
    NSString *selectedTextbook;
    
    NSString *courseNum;
    NSString *courseSym;
    
    IBOutlet UIScrollView *scroller;
    ////////////
   IBOutlet UIScrollView *searchViewScroller;
    
    __weak IBOutlet UIImageView *boardImageOne;
    
    __weak IBOutlet UILabel *boardContentOne;
    __weak IBOutlet UIView *boardViewOne;
    __weak IBOutlet UILabel *boardPriceOne;
    __weak IBOutlet UIImageView *boardImageTwo;
    
    __weak IBOutlet UILabel *boardContentTwo;
    __weak IBOutlet UILabel *boardPriceTwo;
    __weak IBOutlet UIView *boardViewTwo;
    __weak IBOutlet UIImageView *boardImageThree;
    
    __weak IBOutlet UILabel *boardContentThree;
    __weak IBOutlet UILabel *boardPriceThree;
    __weak IBOutlet UIView *boardViewThree;
    //adboard objects
    PFObject *imageOne;
    PFObject *imageTwo;
    PFObject *imageThree;
    DataObject *optionSingle;
    UIView *blackview;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;

@property (weak, nonatomic) IBOutlet UIImageView *detailImageFirst;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageSecond;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageThird;
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UITextView *detailDescription;
@property (weak, nonatomic) IBOutlet UILabel *detailCourseName;

@property (weak, nonatomic) IBOutlet UITableView *imagesCollection;
@property (weak, nonatomic) IBOutlet UIView *detailView;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *wishMatchImage;
@property (weak, nonatomic) IBOutlet UILabel *wishMatchNotify;
@property (weak, nonatomic) IBOutlet UIImageView *qualityImage;
- (IBAction)reportButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *reportView;
- (IBAction)yesReport:(id)sender;
- (IBAction)noReport:(id)sender;

- (IBAction)categoryAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *homepageView;
- (IBAction)categoryGoBack:(id)sender;
- (IBAction)categorySelected:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property NSString *category;
@property BOOL refreshed;
@property BOOL textbookRefreshed;
@property BOOL categoryRefreshed;
@property BOOL allItemLoaded;
@property NSString *courseSymbol;
@property NSString *courseNumber;
- (IBAction)textbookAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *selectTypeView;
@property (weak, nonatomic) IBOutlet UIView *selectCourseView;
@property (weak, nonatomic) IBOutlet UIButton *placeOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *generalSearch;

+(CAGradientLayer*) grayGradient;
@property (weak, nonatomic) IBOutlet UIButton *textBookSearch;

@property (weak, nonatomic) IBOutlet UIView *textbookInfoView;
@property (weak, nonatomic) IBOutlet UIButton *textbookSearchGo;
- (IBAction)textbookSearchGoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *symbolField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
- (IBAction)symbolEditStart:(id)sender;

- (IBAction)numberEditStart:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *uniketLogo;
@property (weak, nonatomic) IBOutlet UIButton *searchLogo;
@property (weak, nonatomic) IBOutlet UIButton *backButtonLogo;
- (IBAction)imageBigBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *uniketLogoTwo;
- (IBAction)imageBig:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bigImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bigImage;
@property UIImage *currentImage;


@property (weak, nonatomic) IBOutlet UIButton *detailImageFirstOutlet;
@property (weak, nonatomic) IBOutlet UIButton *detailImageSecondOutlet;

@property (weak, nonatomic) IBOutlet UIButton *detailImageThirdOutlet;
- (IBAction)detailImageFirstAction:(id)sender;
- (IBAction)detailImageSecondAction:(id)sender;

- (IBAction)detailImageThirdAction:(id)sender;
- (IBAction)placeOrderAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *detailPage;

- (IBAction)boardViewAction:(id)sender;
- (IBAction)boardViewActionTwo:(id)sender;
- (IBAction)boardViewActionThree:(id)sender;


@end
