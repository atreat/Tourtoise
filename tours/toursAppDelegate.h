//
//  toursAppDelegate.h
//  tours
//
//  Created by eq2-mac on 10/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "SettingsViewController.h"
#import "MyToursViewController.h"

@interface toursAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    HomeViewController      *homeViewController;
    SearchViewController    *searchViewController;
    SettingsViewController  *settingsViewController;
    MyToursViewController   *mytoursViewController;
    
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet UITabBarController *tabBarController;

@end
