    //
//  TotalViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TotalViewController.h"
#import "Global.h"
#import "ResourceManager.h"

@implementation TotalViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[self setScoreSort];
	
	int i, j;
	for (i = 0; i < MAX_USER_NUM; i ++)
	{
		if (i == ONE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
			{
				firtScoreView[j] = [[UIImageView alloc] init];
				[self.view addSubview:firtScoreView[j]];
			}
		}
		if (i == TWO_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
			{
				secondScoreView[j] = [[UIImageView alloc] init];
				[self.view addSubview:secondScoreView[j]];
			}
		}
		if (i == THREE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
			{
				thirdScoreView[j] = [[UIImageView alloc] init];
				[self.view addSubview:thirdScoreView[j]];
			}
		}
		if (i == FOUR_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
			{
				forthScoreView[j] = [[UIImageView alloc] init];
				[self.view addSubview:forthScoreView[j]];
			}
		}			
	}
	
	int x1, y1, x2, y2, x3, y3, x4, y4;
	
	int width, height, length;
	
	x1 = 246, y1 = 376;
	x2 = 646, y2 = 376;
	x3 = 246, y3 = 670;
	x4 = 646, y4 = 670;
	
	length = 60; width = 60; height = 68;
	for (i = 0; i < MAX_USER_NUM; i ++)
	{
		if (i == ONE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				firtScoreView[j].frame = CGRectMake((x1 - j * length) * g_rX, y1 * g_rY, width * g_rX, height * g_rY);
			
			dispNumView(&firtScoreView[0], 4, usrInfo[ONE_PLAY].nScore);
		}
		if (i == TWO_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				secondScoreView[j].frame = CGRectMake((x2 - j * length) * g_rX, y2 * g_rY, width * g_rX, height * g_rY);
			
			dispNumView(&secondScoreView[0], 4, usrInfo[TWO_PLAY].nScore);
		}
		if (i == THREE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				thirdScoreView[j].frame = CGRectMake((x3 - j * length) * g_rX, y3 * g_rY, width * g_rX, height * g_rY);
			
			dispNumView(&thirdScoreView[0], 4, usrInfo[THREE_PLAY].nScore);
		}
		if (i == FOUR_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				forthScoreView[j].frame = CGRectMake((x4 - j * length) * g_rX, y4 * g_rY, width * g_rX, height * g_rY);
			
			dispNumView(&forthScoreView[0], 4, usrInfo[FOUR_PLAY].nScore);
		}			
	}
	
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
	int i, j;
	for (i = 0; i < MAX_USER_NUM; i ++)
	{
		if (i == ONE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
			{
				if (firtScoreView[j] != nil)
				{
					[firtScoreView[j] release];
					firtScoreView[j] = nil;
				}
			}
		}
		if (i == TWO_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
			{
				if (secondScoreView[j] != nil)
				{
					[secondScoreView[j] release];
					secondScoreView[j] = nil;
				}
			}
		}
		if (i == THREE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
			{
				if (thirdScoreView[j] != nil)
				{
					[thirdScoreView[j] release];
					thirdScoreView[j] = nil;
				}
			}
		}
		if (i == FOUR_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
			{
				if (forthScoreView[j] != nil)
				{
					[forthScoreView[j] release];
					forthScoreView[j] = nil;
				}
			}
		}			
	}
	
    [super dealloc];
}

#pragma mark FUNCTION_PASCAL
-(void)setScoreSort{	
	int nScore;
	int i, j;
	
	int nOrder;
	
	UIImage* img;
	for (i = 0; i <= g_nUsrState; i ++)
	{
		nOrder = 1;
		nScore = usrInfo[i].nScore;
		
		for (j = 0; j <=g_nUsrState; j ++)
		{
			if (i == j)
				continue;
			else if (nScore >= usrInfo[j].nScore)
				continue;
			else 
				nOrder++; 
		}
		
		switch (nOrder) {
			case 1:
				img = [UIImage imageNamed:@"1stPlace.png"];
				break;
			case 2:
				img = [UIImage imageNamed:@"2ndPlace.png"];
				break;
			case 3:
				img = [UIImage imageNamed:@"3rdPlace.png"];
				break;
			case 4:
				img = [UIImage imageNamed:@"4thPlace.png"];
				break;
			default:
				break;
		}
		
		switch (i + 1) {
			case 1:
				firstImg.image = img;
				break;
			case 2:
				secondImg.image = img;
				break;
			case 3:
				thirdImg.image = img;
				break;
			case 4:
				fourthImg.image = img;
				break;
			default:
				break;
		}
	}
	
	for (i = (g_nUsrState + 1); i < MAX_USER_NUM; i ++)
	{
		switch (i + 1) {
			case 1:
				firstImg.image = nil;
				break;
			case 2:
				secondImg.image = nil;
				break;
			case 3:
				thirdImg.image = nil;
				break;
			case 4:
				fourthImg.image = nil;
				break;
			default:
				break;
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
