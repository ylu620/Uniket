//
//  DataObject.h
//  Uniket
//
//  Created by Student on 5/3/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataObject : NSObject

@property (nonatomic,strong) NSString *submittedFromPickerView;
@property (nonatomic,strong) NSString *requestConfirmed;

+(DataObject *) dataObjects;
@end
