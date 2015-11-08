    //
//  CreditsViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreditsViewController.h"
#import "ResourceManager.h"

@implementation CreditsViewController
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark IBAction
-(IBAction) onBack{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	[self.navigationController popViewControllerAnimated:YES];
}

@end
