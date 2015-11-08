    //
//  MultiPlayViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MultiPlayViewController.h"
#import "GamePlayViewController.h"
#import "Global.h"
#import "ResourceManager.h"

@implementation MultiPlayViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self initChectInfo];
	
	xImgView1.hidden = NO;
	nPlayerState = TWO_PLAY;
	
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

#pragma mark FUNCTION_PASCAL

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint= [touch locationInView:self.view];	
	
	if (CGRectContainsPoint(playerImgView1.frame, touchPoint))
	{
		[self initChectInfo];
		xImgView1.hidden = NO;
		
		nPlayerState = TWO_PLAY;
	}
	else if (CGRectContainsPoint(playerImgView2.frame, touchPoint))
	{
		[self initChectInfo];
		xImgView2.hidden = NO;
		nPlayerState = THREE_PLAY;
	}
	else if (CGRectContainsPoint(playerImgView3.frame, touchPoint))
	{
		[self initChectInfo];
		xImgView3.hidden = NO;
		nPlayerState = FOUR_PLAY;		
	}
}

-(void)initChectInfo{
	xImgView1.hidden = YES;
	xImgView2.hidden = YES;
	xImgView3.hidden = YES;
}

#pragma mark IBAction

-(IBAction)onStartGame{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	GamePlayViewController* gameViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		gameViewController = [[GamePlayViewController alloc] initWithNibName:@"GamePlayViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		gameViewController = [[GamePlayViewController alloc] initWithNibName:@"GamePlayViewController_iPad" bundle:[NSBundle mainBundle]];
	
	g_nUsrIdx = 0;
	g_nUsrState = nPlayerState;
	initUsrInfo();
	
	[self.navigationController pushViewController:gameViewController animated:YES];
	
	[gameViewController release];
}

-(IBAction)onBack{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
