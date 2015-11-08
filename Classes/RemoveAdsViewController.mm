    //
//  RemoveAdsViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RemoveAdsViewController.h"
#import "ResourceManager.h"

@implementation RemoveAdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark IBAction

-(IBAction)onSure{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	[self.navigationController popViewControllerAnimated:YES];
}

@end
