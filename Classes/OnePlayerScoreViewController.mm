    //
//  OnePlayerScoreViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "OnePlayerScoreViewController.h"
#import "ResourceManager.h"

@implementation OnePlayerScoreViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	int i;

	m_nScore = 0;
	m_nAverage = 0;
	m_nBest = 0;
	m_nTotalScore = 0;
	
	loadUserInfo();
	[self calcSaveInfo];
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
	{
		scoreView[i] = [[UIImageView alloc] init];
		[self.view addSubview:scoreView[i]];
	}
	
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
	
	int x1, y1, x2, y2, x3, y3, x4, y4;
	
	int width, height, length;
	
	x1 = 456, y1 = 344;
	x2 = 288, y2 = 554;
	x3 = 622, y3 = 554;
	x4 = 604, y4 = 784;
	
	length = 60; width = 60; height = 68;
	
	
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
		scoreView[i].frame = CGRectMake((x1 - i * length) * g_rX, y1 * g_rY, width * g_rX, height * g_rY);

	dispNumView(&scoreView[0], 4, m_nScore);
	
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
		averageView[i].frame = CGRectMake((x2 - i * length) * g_rX, y2 * g_rY, width * g_rX, height * g_rY);
	
	dispNumView(&averageView[0], 4, m_nAverage);
	
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
		bestView[i].frame = CGRectMake((x3 - i * length) * g_rX, y3 * g_rY, width * g_rX, height * g_rY);
	
	dispNumView(&bestView[0], 4, m_nBest);
	
	for (i = 0; i < 9; i ++)
		totalScoreView[i].frame = CGRectMake((x4 - i * length) * g_rX, y4 * g_rY, width * g_rX, height * g_rY);
	
	dispNumView(&totalScoreView[0], 9, m_nTotalScore);
	
    [super viewDidLoad];
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
	int i;
	for (i = 0; i < MAX_SCORE_LENGTH; i ++)
	{
		if (scoreView[i] != nil)
			[scoreView[i] release];
	}
	
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
-(void)calcSaveInfo{
	
	if (g_nSaveNum == 0)
	{
		m_nScore = usrInfo[0].nScore;
		m_nAverage = usrInfo[0].nScore;
		m_nBest = usrInfo[0].nScore;
		m_nTotalScore = usrInfo[0].nScore;		
		
		g_nSaveNum = 1;
		
		g_saveInfo = (SAVE_INFO*)malloc(sizeof(SAVE_INFO) * g_nSaveNum);
		
		g_saveInfo[0].nScore = m_nScore;
	}
	else 
	{
		g_nSaveNum ++;
		
		g_saveInfo[g_nSaveNum - 1].nScore = usrInfo[0].nScore;
		
		int i;
		for (i = 0; i < g_nSaveNum; i ++)
			m_nTotalScore += g_saveInfo[i].nScore;
		
		if (g_nSaveNum == 0)
			return;
		
		m_nScore = usrInfo[0].nScore;
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

-(IBAction)onMenu{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	[self.navigationController popToRootViewControllerAnimated:YES];
}	

-(IBAction)onPlus{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
}

-(IBAction)onPlayAgain{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	initUsrInfo();
	g_nUsrIdx = 0;
	
	[self.navigationController popViewControllerAnimated:YES];
}
@end
