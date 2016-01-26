//
//  DataObject.m
//  Uniket
//
//  Created by Student on 5/3/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import "DataObject.h"

@implementation DataObject

+(DataObject *) dataObjects
{
    static DataObject *dataObject = nil;
    if(!dataObject){
        dataObject = [[super allocWithZone:nil]init];
    }
    return dataObject;
}
+(id) allocWithZone:(struct _NSZone *)zone{
    return [self dataObjects];
}

-(id) init
{
    self = [super init];
    if(self){
        _submittedFromPickerView = @"False";
    }
    return self;
}


@end
