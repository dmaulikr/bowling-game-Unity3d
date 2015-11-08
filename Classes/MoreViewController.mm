    //
//  MoreViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoreViewController.h"
#import "StrikeKnightAppDelegate.h"

#import "InstructionViewController.h"
#import "CreditsViewController.h"
#import "RemoveAdsViewController.h"
#import "PlusViewController.h"

#import "ResourceManager.h"
@implementation MoreViewController

- (void)viewDidLoad {
	[self iniSounImg];
	
	m_nAverage = 0;
	m_nBest = 0;
	m_nTotalScore = 0;
	
	loadUserInfo();
	[self calcSaveInfo];
	
	int i;
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
	{
		averageView[i] = [[UIImageView alloc] init];
		[self.view addSubview:averageView[i]];
	}
	
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
	{
		bestView[i] = [[UIImageView alloc] init];
		[self.view addSubview:bestView[i]];
	}
	
	for (i = 0; i < 9; i ++)
	{
		totalScoreView[i] = [[UIImageView alloc] init];
		[self.view addSubview:totalScoreView[i]];
	}
	
	int x1, y1, x2, y2, x3, y3;
	
	int width, height, length;
	
	x1 = 690, y1 = 160;
	x2 = 690, y2 = 240;
	x3 = 690, y3 = 320;
	
	length = 36; width = 36; height = 44;
	
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
		averageView[i].frame = CGRectMake((x1 - i * length) * g_rX, y1 * g_rY, width * g_rX, height * g_rY);
	
	dispNumView(&averageView[0], 4, m_nBest);
	
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
		bestView[i].frame = CGRectMake((x2 - i * length) * g_rX, y2 * g_rY, width * g_rX, height * g_rY);
	
	dispNumView(&bestView[0], 4, m_nAverage);
	
	for (i = 0; i < 9; i ++)
		totalScoreView[i].frame = CGRectMake((x3 - i * length) * g_rX, y3 * g_rY, width * g_rX, height * g_rY);
	
	dispNumView(&totalScoreView[0], 9, m_nTotalScore);
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
	int i;
	
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
	{
		if (averageView[i] != nil)
			[averageView[i] release];
	}
	
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
	{
		if (bestView[i] != nil)
			[bestView[i] release];
	}
	
	for (i = 0; i < 9; i ++)
	{
		if (totalScoreView[i] != nil)
			[totalScoreView[i] release];
	}
	
	saveUserInfo();
	
    [super dealloc];
}

#pragma mark FUNCTION_PASCAL

-(void) iniSounImg{
	if (g_fSound)
	{
		soundOnView.hidden = NO;
		soundOffView.hidden = YES;
	}
	else
	{
		soundOnView.hidden = YES;
		soundOffView.hidden = NO;
	}
}

-(void)calcSaveInfo{
	
	if (g_nSaveNum == 0)
	{
		m_nAverage = 0;
		m_nBest = 0;
		m_nTotalScore = 0;
	}
	else 
	{
		int i;
		for (i = 0; i < g_nSaveNum; i ++)
			m_nTotalScore += g_saveInfo[i].nScore;
		
		if (g_nSaveNum == 0)
			return;
		
		m_nAverage = m_nTotalScore / g_nSaveNum;
		
		m_nBest = g_saveInfo[0].nScore;
		for (i = 1; i < g_nSaveNum; i ++)
		{
			if (m_nBest < g_saveInfo[i].nScore)
				m_nBest = g_saveInfo[i].nScore;
		}
	}	
}


#pragma mark IBAction

-(IBAction) onInstruction{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	InstructionViewController* instructionViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		instructionViewController = [[InstructionViewController alloc] initWithNibName:@"InstructionViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		instructionViewController = [[InstructionViewController alloc] initWithNibName:@"InstructionViewController_iPad" bundle:[NSBundle mainBundle]];
	
	g_nUsrIdx = 0;
	g_nUsrState = ONE_PLAY;
	
	[self.navigationController pushViewController:instructionViewController animated:YES];
	
	[instructionViewController release];
}

-(IBAction) onMoreGame{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
}

-(IBAction) onCredits{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	CreditsViewController* creditsViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		creditsViewController = [[CreditsViewController alloc] initWithNibName:@"CreditsViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		creditsViewController = [[CreditsViewController alloc] initWithNibName:@"CreditsViewController_iPad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:creditsViewController animated:YES];
	
	[creditsViewController release];
}

-(IBAction) onRemoveAds{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	RemoveAdsViewController* removeViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		removeViewController = [[RemoveAdsViewController alloc] initWithNibName:@"RemoveAdsViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		removeViewController = [[RemoveAdsViewController alloc] initWithNibName:@"RemoveAdsViewController_iPad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:removeViewController animated:YES];
	
	[removeViewController release];
}

-(IBAction) onPlus{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	PlusViewController* plusViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		plusViewController = [[PlusViewController alloc] initWithNibName:@"PlusViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		plusViewController = [[PlusViewController alloc] initWithNibName:@"PlusViewController_iPad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:plusViewController animated:YES];
	
	[plusViewController release];
}

-(IBAction) onSound{
	g_fSound = g_fSound ? NO : YES;
	[self iniSounImg];
}

-(IBAction) onBack{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	[self.navigationController popViewControllerAnimated:YES];
}

@end
