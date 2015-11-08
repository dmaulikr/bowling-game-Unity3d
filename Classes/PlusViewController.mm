    //
//  PlusViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlusViewController.h"
#import "ResourceManager.h"

@implementation PlusViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark IBAction

-(IBAction)onJoinPlus{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
}

-(IBAction)onNothanks{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	[self.navigationController popViewControllerAnimated:YES];
}

@end
