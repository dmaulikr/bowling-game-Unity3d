//
//  StrikeKnightAppDelegate.m
//  StrikeKnight
//
//  Created by chang on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StrikeKnightAppDelegate.h"
#import "StrikeKnightViewController.h"

#import "SoundEngine.h"
#import <QuartzCore/QuartzCore.h>

#define REVMOB_ID @"5183f7530eba2c02c000003c"
#define HAVEN_ID    @"05affe21288d442eb21409a77f7bebfa"
#define HAVEN_SCREST   @"9304a957dd85479bbfc27bdf9fd994a2"

@implementation StrikeKnightAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	navigationController.navigationBarHidden = YES;
	
	[self.window addSubview:[navigationController view]];
    [self.window makeKeyAndVisible];
    
        [RevMobAds startSessionWithAppID:REVMOB_ID];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self setUpRevMob];
    [self launchPlayHaven];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {

}

- (void)dealloc {
    [viewController release];
    [window release];
	
	if (navigationController != nil)
	{
		[navigationController release];
		navigationController = nil;
	}
	
    [super dealloc];
}

#pragma mark SOUND
-(void) soundPlay{
	if (!g_fSound)
		return;
	
	NSBundle*	bundle = [NSBundle mainBundle];
	SoundEngine_LoadBackgroundMusicTrack([[bundle pathForResource:@"BackgroundBarSounds" ofType:@"mp3"] UTF8String], FALSE, FALSE);
	
	SoundEngine_StartBackgroundMusic();	
}

-(void) soundStop{
	if (!g_fSound)
		return;
	
	SoundEngine_StopBackgroundMusic(FALSE);
	SoundEngine_UnloadBackgroundMusicTrack();
}

- (void) setUpRevMob {
    [[RevMobAds session] showFullscreen];
}

- (void) launchPlayHaven
{
    [[PHPublisherContentRequest requestForApp:HAVEN_ID secret:HAVEN_SCREST placement:@"alarm" delegate:self] preload];
    
    
    [self startRequest];
    
}

- (void)startRequest
{
    if (self.request != nil)
    {
        [self.request cancel];
        self.request = nil;
    }
    
    if (self.request == nil) {
        PHPublisherContentRequest *request = [PHPublisherContentRequest requestForApp:HAVEN_ID
                                                                               secret:HAVEN_SCREST
                                                                            placement:@"alarm"
                                                                             delegate:self];
        [request setShowsOverlayImmediately:TRUE];
        [request setAnimated:TRUE];
        [request send];
        
        [self setRequest:request];
        
    } else {
        [self.request cancel];
        self.request = nil;
    }
}

- (void)finishRequest
{
    self.request = nil;
}

#pragma mark - PHPublisherContentRequestDelegate
- (void)requestWillGetContent:(PHPublisherContentRequest *)request
{
    NSString *message = [NSString stringWithFormat:@"Getting content for placement: %@", request.placement];
    NSLog(@"%@", message);
}

- (void)requestDidGetContent:(PHPublisherContentRequest *)request
{
    NSString *message = [NSString stringWithFormat:@"Got content for placement: %@", request.placement];
    NSLog(@"%@", message);
}

- (void)request:(PHPublisherContentRequest *)request contentWillDisplay:(PHContent *)content
{
    NSString *message = [NSString stringWithFormat:@"Preparing to display content: %@", content];
    NSLog(@"%@", message);
}

- (void)request:(PHPublisherContentRequest *)request contentDidDisplay:(PHContent *)content
{
    // This is a good place to clear any notification views attached to this request.
    //  [_notificationView clear];
    
    NSString *message = [NSString stringWithFormat:@"Displayed content: %@", content];
    
    NSLog(@"%@", message);
}

- (void)request:(PHPublisherContentRequest *)request contentDidDismissWithType:(PHPublisherContentDismissType *)type
{
    NSString *message = [NSString stringWithFormat:@"[OK] User dismissed request: %@ of type %@", request, type];
    NSLog(@"%@", message);
}

- (void)request:(PHAPIRequest *)request didFailWithError:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:@"[ERROR] Failed with error: %@", error];
    NSLog(@"%@", message);
}

- (void)request:(PHPublisherContentRequest *)request unlockedReward:(PHReward *)reward
{
    NSString *message = [NSString stringWithFormat:@"Unlocked reward: %dx %@", reward.quantity, reward.name];
    NSLog(@"%@", message);
}

- (void)request:(PHPublisherContentRequest *)request makePurchase:(PHPurchase *)purchase
{
    NSString *message = [NSString stringWithFormat:@"Initiating purchase for: %dx %@", purchase.quantity, purchase.productIdentifier];
    NSLog(@"%@", message);
    
    [[IAPHelper sharedIAPHelper] startPurchase:purchase];
}

@end
