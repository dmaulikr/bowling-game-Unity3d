    //
//  InstructionViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InstructionViewController.h"
#import "ResourceManager.h"

@implementation InstructionViewController

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

-(IBAction)onBack{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	[self.navigationController popViewControllerAnimated:YES];
}

@end
