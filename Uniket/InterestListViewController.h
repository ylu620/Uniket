//
//  InterestListViewController.h
//  Fleem
//
//  Created by Student on 2/13/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InterestListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    NSArray *requestToArray;
     NSArray *requestFromArray;
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *interestCollection;


@end
