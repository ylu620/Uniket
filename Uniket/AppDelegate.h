//
//  AppDelegate.h
//  Fleem
//
//  Created by Jun Suh Lee on 2/7/15.
//  Copyright (c) 2015 ___Fleem___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    BOOL submitFromPickerView;
}

@property (strong, nonatomic) UIWindow *window;

@property BOOL submitFromPickerView;


@end
