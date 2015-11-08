//
//  StrikeKnightAppDelegate.h
//  StrikeKnight
//
//  Created by chang on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RevMobAds/RevMobAds.h>
#import "IAPHelper.h"
#import <CoreLocation/CoreLocation.h>
#import "PlayHavenSDK.h"

#import "Global.h"

#define APPDELEGATE		((StrikeKnightAppDelegate*)[UIApplication sharedApplication].delegate)

@class StrikeKnightViewController;

@interface StrikeKnightAppDelegate : NSObject <UIApplicationDelegate, PHPublisherContentRequestDelegate> {
    UIWindow *window;
    StrikeKnightViewController *viewController;
	
	UINavigationController* navigationController;	
    PHPublisherContentRequest *_request;
}

@property (nonatomic, retain) PHPublisherContentRequest *request;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StrikeKnightViewController* viewController;
@property (nonatomic, retain) IBOutlet UINavigationController* navigationController;

#pragma mark SOUND

-(void) soundPlay;
-(void) soundStop;

@end

