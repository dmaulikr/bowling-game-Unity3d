    //
//  GamePlayViewController.mm
//  StrikeKnight
//
//  Created by chang on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GamePlayViewController.h"
#import "TotalViewController.h"
#import "StrikeKnightAppDelegate.h"
#import "OnePlayerScoreViewController.h"

#import "Global.h"
#import "ResourceManager.h"

int ANIMATION_NUM[] =//yhi
{
	CRY_ANI_NUM * 2 -1,//?we must repair
	DANCE_ANI_NUM,
    FISTPUMP_ANI_NUM * 2 + 1,
    GUITAR_ANI_NUM * 2 - 1,
    HIGHSCORE_ANI_NUM * 2 + 4,
    HSHAKE_ANI_NUM * 2 - 2,
    LIGHTNINGARC_ANI_NUM * 2 - 1,
    LIGHTNINGHAND_ANI_NUM * 2 + 3,
    PINRAIN_ANI_NUM + 7,
    POINT_ANI_NUM * 2 + 1,
    PUNCH_ANI_NUM * 2 - 1,
    SHIELD_ANI_NUM * 2 + 2,
    SPLITIMAGE_ANI_NUM * 2 + 4,	
};

int ANIMATION_FRAME_NUM[13][40] = {
	{0 ,1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20},
	{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0 ,1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 13, 13, 13, 13, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0 ,1 ,2 ,3 ,4 ,5 ,6 ,7 ,8 ,9 ,10 ,11 ,12 ,13 ,5 ,6 ,7 ,8 ,9 ,10 ,11 ,12 ,13 ,3 ,2 ,0},
	{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 10, 9, 10, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 6, 5, 4, 3, 2, 1, 0},
	{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 10, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 9, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
	{0, 1, 2, 3, 4, 5, 6, 6, 6, 6, 6, 6, 6, 6, 5, 4, 3, 2, 1, 0},
};

int FB_X[] = {19, 63, 111, 154, 199, 246, 294, 334, 384};

@implementation GamePlayViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {	
	[super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{
	m_Puck.hidden = YES;

	[self setPlayerPuckView];	
	[g_Engine setPuckView:m_Puck];
	
	[APPDELEGATE soundPlay];
	
	int i;
	for (i = 0; i < PIN_NUM; i++)
	{
		m_pUIPin[i] = [[UIImageView alloc] init];		
		[self.view addSubview:m_pUIPin[i]];
	}
	
	m_pUIPin[0].frame = CGRectMake(PIN0_POS_LEFT_X * g_rX, (PIN0_POS_Y - PIN_HEIGHT) * g_rY, PIN_WIDTH * g_rX, PIN_HEIGHT * g_rY);
	m_pUIPin[1].frame = CGRectMake(PIN1_POS_LEFT_X * g_rX, (PIN1_POS_Y - PIN_HEIGHT) * g_rY, PIN_WIDTH * g_rX, PIN_HEIGHT * g_rY);
	m_pUIPin[2].frame = CGRectMake(PIN2_POS_LEFT_X * g_rX, (PIN2_POS_Y - PIN_HEIGHT) * g_rY, (PIN_WIDTH + 1 * RATE_WIDTH) * g_rX, (PIN_HEIGHT + 1 * RATE_HEIGHT) * g_rY);
	m_pUIPin[3].frame = CGRectMake(PIN3_POS_LEFT_X * g_rX, (PIN3_POS_Y - PIN_HEIGHT) * g_rY, (PIN_WIDTH + 2 * RATE_WIDTH) * g_rX, (PIN_HEIGHT + 7 * RATE_HEIGHT) * g_rY);
	m_pUIPin[4].frame = CGRectMake(PIN4_POS_LEFT_X * g_rX, (PIN4_POS_Y - PIN_HEIGHT) * g_rY, (PIN_WIDTH + 1 * RATE_WIDTH) * g_rX, (PIN_HEIGHT + 1 * RATE_HEIGHT) * g_rY);
	m_pUIPin[5].frame = CGRectMake(PIN5_POS_LEFT_X * g_rX, (PIN5_POS_Y - PIN_HEIGHT) * g_rY, PIN_WIDTH * g_rX, PIN_HEIGHT * g_rY);
	m_pUIPin[6].frame = CGRectMake(PIN6_POS_LEFT_X * g_rX, (PIN6_POS_Y - PIN_HEIGHT) * g_rY, PIN_WIDTH * g_rX, PIN_HEIGHT * g_rY);
	m_pUIPin[7].frame = CGRectMake(PIN7_POS_LEFT_X * g_rX, (PIN7_POS_Y - PIN_HEIGHT) * g_rY, PIN_WIDTH * g_rX, PIN_HEIGHT * g_rY);
	m_pUIPin[8].frame = CGRectMake(PIN8_POS_LEFT_X * g_rX, (PIN8_POS_Y - PIN_HEIGHT) * g_rY, PIN_WIDTH * g_rX, PIN_HEIGHT * g_rY);
	m_pUIPin[9].frame = CGRectMake(PIN9_POS_LEFT_X * g_rX, (PIN9_POS_Y - PIN_HEIGHT) * g_rY, PIN_WIDTH * g_rX, PIN_HEIGHT * g_rY);
	
	[self.view bringSubviewToFront:m_pUIPin[0]];
	[self.view bringSubviewToFront:m_pUIPin[7]];
	[self.view bringSubviewToFront:m_pUIPin[8]];
	[self.view bringSubviewToFront:m_pUIPin[6]];
	[self.view bringSubviewToFront:m_pUIPin[1]];
	[self.view bringSubviewToFront:m_pUIPin[9]];
	[self.view bringSubviewToFront:m_pUIPin[5]];
	[self.view bringSubviewToFront:m_pUIPin[2]];
	[self.view bringSubviewToFront:m_pUIPin[4]];
	[self.view bringSubviewToFront:m_pUIPin[3]];
	
	m_pUIBL = [[UIImageView alloc] init];
	m_pUIBL.image = ResourceManager::sharedInstance()->m_pBLImage[0];
	[self.view addSubview:m_pUIBL];
	
	m_pUIFB = [[UIImageView alloc] init];
	m_pUIFB.image = ResourceManager::sharedInstance()->m_pFBImage[0];
	[self.view addSubview:m_pUIFB];
	
	m_pUIBL.frame = CGRectMake(255 * g_rX, 540 * g_rY, 285 * g_rX, 25 * g_rY);
	m_pUIFB.frame = CGRectMake(176 * g_rX, 338 * g_rY, 441 * g_rX, 92 * g_rY);
	
	for (i = 0; i < PIN_NUM; i++)
	{
		m_frameNum[i] = [[UIImageView alloc] init];		
		[self.view addSubview:m_frameNum[i]];
	}
	
	int x, y;
	
	x = 561; y = 291;
	for (i = 0; i < 2; i ++)
		m_frameNum[i].frame = CGRectMake((x - i * NUM_WIDTH) * g_rX, y * g_rY, NUM_WIDTH * g_rX, NUM_HEIGHT * g_rY);
	
	m_fStrike = NO;
	m_fSpare = NO;
	m_fGameOver = NO;
	
	m_fDispPlayer = NO;
	m_fPinInitAppear = YES;
	m_fScoreChange = NO;
	m_fStart = YES;
	m_fPinHitSound = NO;
	m_fBonus = NO;
	
	dispNumView(&m_frameNum[0], 2, usrInfo[g_nUsrIdx].nLevel);
	
	g_btnContinue.enabled = YES;
	
	m_pUICharacter = [[UIImageView alloc] init];

#ifdef ANI_RESOURCE_INCLUDE
	m_pUICharacter.image = ResourceManager::sharedInstance()->m_pCryImage[0];
#endif	
	[self.view addSubview:m_pUICharacter];
	
	m_pUICharacter.frame = CGRectMake(234 * g_rX, 140 * g_rY, 230 * g_rX, 186 * g_rY);
	
	///
//	for (i = 0 ; i < PIN_NUM; i ++)
//		usrInfo[g_nUsrIdx].fPinHit[i] = YES;
//	
//	usrInfo[g_nUsrIdx].fPinHit[6] = NO;
//	usrInfo[g_nUsrIdx].nThrowState = FIRST_THROW;
	///
	
	for (int i = 0; i <= g_nUsrState; i ++)
	{
		playerImgView[i] = [[UIImageView alloc] init];
		[self.view addSubview:playerImgView[i]];
		
		switch (i) {
			case ONE_PLAY:
				playerImgView[0].image = [UIImage imageNamed:@"1P.png"];
				playerImgView[0].frame = CGRectMake(454 * g_rX, 93 * g_rY, 57 * g_rX, 51 * g_rY);
				break;
			case TWO_PLAY:
				playerImgView[1].image = [UIImage imageNamed:@"2P.png"];
				playerImgView[1].frame = CGRectMake(448 * g_rX, 137 * g_rY, 57 * g_rX, 51 * g_rY);
				break;
			case THREE_PLAY:
				playerImgView[2].image = [UIImage imageNamed:@"3P.png"];
				playerImgView[2].frame = CGRectMake(437 * g_rX, 187 * g_rY, 57 * g_rX, 51 * g_rY);
				break;
			case FOUR_PLAY:
				playerImgView[3].image = [UIImage imageNamed:@"4P.png"];
				playerImgView[3].frame = CGRectMake(430 * g_rX, 233 * g_rY, 57 * g_rX, 51 * g_rY);
				break;
				
			default:
				break;
		}
	}	
	
	int j;
	for (i = 0; i <= g_nUsrState; i ++)
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
	
	x1 = 591, y1 = 112;
	x2 = 581, y2 = 156;
	x3 = 571, y3 = 200;
	x4 = 561, y4 = 244;
	
	length = 25; width = 25; height = 27;
	for (i = 0; i <= g_nUsrState; i ++)
	{
		if (i == ONE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				firtScoreView[j].frame = CGRectMake((x1 - j * length) * g_rX, y1 * g_rY, width * g_rX, height * g_rY);
			
			dispNumView(&firtScoreView[0], 4, usrInfo[g_nUsrIdx].nScore);
		}
		if (i == TWO_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				secondScoreView[j].frame = CGRectMake((x2 - j * length) * g_rX, y2 * g_rY, width * g_rX, height * g_rY);
			
			dispNumView(&secondScoreView[0], 4, usrInfo[g_nUsrIdx].nScore);
		}
		if (i == THREE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				thirdScoreView[j].frame = CGRectMake((x3 - j * length) * g_rX, y3 * g_rY, width * g_rX, height * g_rY);
			
			dispNumView(&thirdScoreView[0], 4, usrInfo[g_nUsrIdx].nScore);
		}
		if (i == FOUR_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				forthScoreView[j].frame = CGRectMake((x4 - j * length) * g_rX, y4 * g_rY, width * g_rX, height * g_rY);
			
			dispNumView(&forthScoreView[0], 4, usrInfo[g_nUsrIdx].nScore);
		}			
	}
	
	tutorial = [[UIImageView alloc] init];
	tutorial.image = [UIImage imageNamed:@"Tutorial_Overlay.png"];
	tutorial.frame = CGRectMake(0, 0, IPAD_WIDTH * g_rX, IPAD_HEIGHT * g_rY);
	
	m_fHelp = NO;
	
	[self usrChangeSeleted];
	
	[self initHitBall];
	
	[self startPuckTimer];
	[self startPinTimer];
	[self startBLFBTimer];
}

-(void)viewDidDisappear:(BOOL)animated{
	[self releaseGameInfo];
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

-(IBAction)onMenu{	
	if (![self isValidTouchDown])
		return;
	
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	
	for (int i = 0; i < PIN_NUM; i ++)
		usrInfo[g_nUsrIdx].fPinHit[i] = g_fPinballHit[i];
	
	[self releaseGameInfo];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)onHelp{
	if (m_fGameOver || m_fDispPlayer || (!g_Engine.m_fPuckStop && [m_engineTimer isValid]))
		return;
	
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	if (m_fHelp)
	{
		[tutorial removeFromSuperview];
		m_fHelp = NO;
	}
	else 
	{
		[self.view addSubview:tutorial];
		m_fHelp = YES;
	}
	
	m_btnHelp.selected = m_fHelp;
}

#pragma mark TOUCH_FUNC

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	CGPoint touchPoint= [touch locationInView:self.view];	
	
	if (m_fDispPlayer && CGRectContainsPoint(playerView.frame, touchPoint))
	{
		CGRect initRt = playerView.frame;
		CGRect endRt = CGRectMake(-IPAD_WIDTH * g_rX, 500 * g_rY, playerView.frame.size.width, playerView.frame.size.height);
		
		m_fDispPlayer = YES;
		
		[self animationView:playerView initFrame:initRt endFrame:endRt durationTime:MOVE_FRAME_VIEW_INTERVAL];
		[self performSelector:@selector(delayDisapearplayerView:) withObject:playerView afterDelay:MOVE_FRAME_VIEW_INTERVAL];
	}
	
	if (![self isValidTouchDown])
		return;
	
	m_fPuckMoving = NO;
	m_fPinHitSound = NO;
	
	int ny = m_Puck.center.y;
	if (CGRectContainsPoint(m_Puck.frame, touchPoint) && ny > FOUL_LINE_Y * g_rY) 
	{		
		m_fPuckTouched = YES;
		
		m_ptPrevTouchPoint = m_ptCurrTouchPoint = touchPoint;
		
		[self stopPuckTimer];
		[self stopEngineTimer];
	}
}

-(void)	updateVelocity{
	float rDeltaX, rDeltaY;
	int signX,signY;
	
	rDeltaX = m_ptCurrTouchPoint.x - m_ptPrevTouchPoint.x;
	rDeltaY = m_ptPrevTouchPoint.y - m_ptCurrTouchPoint.y;
	
	if (rDeltaX < 0.0f)
		signX = -1;
	else 
		signX = 1;
	
	if (rDeltaY < 0.0f)
		signY = -1;
	else 
		signY = 1;
	
	g_rVx = rDeltaX * K_VX;
	g_rVy = rDeltaY * K_VY;
	
	if (fabs(g_rVy) <= MIN_VELOCITY_Y * g_rY) 
		g_rVy = signY * MIN_VELOCITY_Y * g_rY;
	else if (fabs(g_rVy) >= MAX_VELOCITY_Y * g_rY)
	{
		float k_decY = MAX_VELOCITY_Y * g_rY/fabs(g_rVy);
		g_rVy *= k_decY;
		g_rVx *= k_decY;
	}
	
	if (fabs(g_rVx) <= MIN_VELOCITY_X * g_rX) 
		g_rVx = signX * MIN_VELOCITY_X * g_rX;
	else if (fabs(g_rVx) >= MAX_VELOCITY_X * g_rX)
	{
		float k_decX = MAX_VELOCITY_X * g_rX / fabs(g_rVx);
		g_rVx *= k_decX;
		g_rVy *= k_decX;
	}
	
	m_fPuckTouched = NO;
	m_fScoreChange = NO;
	m_fStart = NO;
	
	if (usrInfo[g_nUsrIdx].nThrowState == FIRST_THROW)
	{
		m_fPinInitAppear = NO;
		
		if (m_fStrike || m_fSpare)
		{
			m_fStrike = NO;
			m_fSpare = NO;
		}
		else
		{
			for (int i = 0; i < PIN_NUM; i ++)
				usrInfo[g_nUsrIdx].fPinHit[i] = g_fPinballHit[i];
		}
	}
	
	usrInfo[g_nUsrIdx].nThrowState ++;
	usrInfo[g_nUsrIdx].nThrowState = usrInfo[g_nUsrIdx].nThrowState >= SECOND_THROW ? SECOND_THROW : usrInfo[g_nUsrIdx].nThrowState;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {	
	UITouch *touch = [touches anyObject];	
	CGPoint touchPoint= [touch locationInView:self.view];
	
	if (!m_fPuckTouched)
		return;	
	
	if ([self isValidTouchMove:touchPoint])
	{	
		m_rPuckPosX = touchPoint.x;
		m_rPuckPosY = touchPoint.y;
		
		m_ptPrevTouchPoint = m_ptCurrTouchPoint;
		m_ptCurrTouchPoint = touchPoint;
		
		[self displayPuck];
	}		
	else 
	{
		m_fPuckMoving = YES;
		m_ptCurrTouchPoint = touchPoint;
		[self updateVelocity];
		
		[g_Engine initEngineParam];
		[self startEngineTimer];
		ResourceManager::sharedInstance()->playSound(PUCKSLIDING_SOUND);
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	if (!m_fPuckTouched || m_fPuckMoving)//yoon
		return;
	
		
//	m_fPuckTouched = NO;
//	m_fScoreChange = NO;
//	m_fStart = NO;
//	
//	if (usrInfo[g_nUsrIdx].nThrowState == FIRST_THROW)
//	{
//		m_fPinInitAppear = NO;
//		
//		if (m_fStrike || m_fSpare)
//		{
//			m_fStrike = NO;
//			m_fSpare = NO;
//		}
//		else
//		{
//			for (int i = 0; i < PIN_NUM; i ++)
//				usrInfo[g_nUsrIdx].fPinHit[i] = g_fPinballHit[i];
//		}
//	}
//	
//	usrInfo[g_nUsrIdx].nThrowState ++;
//	usrInfo[g_nUsrIdx].nThrowState = usrInfo[g_nUsrIdx].nThrowState >= SECOND_THROW ? SECOND_THROW : usrInfo[g_nUsrIdx].nThrowState;
	
//	NSLog(@"UserIdx  %d", g_nUsrIdx);
//	NSLog(@"Touch State  %d", usrInfo[g_nUsrIdx].nThrowState);
	
	[self updateVelocity];
	[g_Engine initEngineParam];
	[self startEngineTimer];
	
	ResourceManager::sharedInstance()->playSound(PUCKSLIDING_SOUND);
}

#pragma mark InitFunc

-(void)initHitBall{
	for (int i = 0; i < PIN_NUM; i ++)
	{
		if (usrInfo[g_nUsrIdx].fPinHit[i])
		{
			m_nPinBallIndex[i] = -1;
			g_fPinballHit[i] = YES;
		}
		else 
		{
			m_nPinBallIndex[i] = PIN_IMGAE_NUM - 1;
			g_fPinballHit[i] = NO;
		}
	}
}

-(void)initHitUsrInfo{
	for (int i = 0; i < PIN_NUM; i ++)
		usrInfo[g_nUsrIdx].fPinHit[i] = NO;
}

-(void)releaseGameInfo{
	int i;
	for (i = 0; i < PIN_NUM; i++)
		[m_pUIPin[i] removeFromSuperview];
	
	for (i = 0; i < 2; i ++)
		[m_frameNum[i] removeFromSuperview];
	
	[m_pUIBL removeFromSuperview];
	[m_pUIFB removeFromSuperview];
	[m_pUICharacter removeFromSuperview];
	
	for (i = 0; i <= g_nUsrState; i ++)
		[playerImgView[i] removeFromSuperview];
	
	int j;
	for (i = 0; i <= g_nUsrState; i ++)
	{
		if (i == ONE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				[firtScoreView[j] removeFromSuperview];
		}
		if (i == TWO_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				[secondScoreView[j] removeFromSuperview];
		}
		if (i == THREE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				[thirdScoreView[j] removeFromSuperview];
		}
		if (i == FOUR_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				[forthScoreView[j] removeFromSuperview];
		}			
	}
		
	for (i = 0; i < PIN_NUM; i ++)
	{
		if (m_pUIPin[i] != nil)
		{
			[m_pUIPin[i] release];		
			m_pUIPin[i] = nil;
		}
	}
	
	for (i = 0; i < 2; i ++)
	{
		if (m_frameNum[i] != nil)
		{
			[m_frameNum[i] release];
			m_frameNum[i] = nil;
		}
	}
	
	if (m_pUIBL != nil)
	{
		[m_pUIBL release];		
		m_pUIBL = nil;
	}
	
	if (m_pUIFB != nil)
	{
		[m_pUIFB release];
		m_pUIFB = nil;
	}
		
	if (m_pUICharacter != nil)
	{
		[m_pUICharacter release];
		m_pUICharacter = nil;
	}
	
	for (i = 0; i <= g_nUsrState; i ++)
	{
		if (playerImgView[i] != nil)
		{
			[playerImgView[i] release];
			playerImgView[i] = nil;
		}
	}
	
	for (i = 0; i <= g_nUsrState; i ++)
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
	
	[APPDELEGATE soundStop];
	
	[self stopPuckTimer];
	[self stopEngineTimer];
	[self stopPinTimer];
	[self stopBLFBTimer];
	[self stopCharacterTimer];
	[self stopNumTimer];
}

#pragma mark TIMER

-(void)startPuckTimer{
	[self setPuckAppearParam];

	if (m_puckMoveTimer != nil) 
		[self stopPuckTimer];		
	
	m_puckMoveTimer = [NSTimer scheduledTimerWithTimeInterval:PUCK_MOVE_INTERVAL target:self selector:@selector(doneStep:) userInfo:nil repeats:YES];			
}

-(void)stopPuckTimer{
	if (m_puckMoveTimer != nil)
	{
		[m_puckMoveTimer invalidate];
		m_puckMoveTimer = nil;		
	}
	
	g_fPuckInitAppear = NO;
}

-(void)startEngineTimer{
	NSTimeInterval PuckMoveTimerInterval;
	PuckMoveTimerInterval = PUCK_MOVE_INTERVAL;
	
	if (m_engineTimer != nil) 
		[self stopPuckTimer];		
	
	m_engineTimer = [NSTimer scheduledTimerWithTimeInterval:PuckMoveTimerInterval target:self selector:@selector(engineStep:) userInfo:nil repeats:YES];
}

-(void)stopEngineTimer{
	if (m_engineTimer != nil)
	{
		[m_engineTimer invalidate];
		m_engineTimer = nil;		
	}
}

-(void)startPinTimer{
	m_fPinInitAppear = YES;	

	if (m_pinTimer != nil)
		[self stopPinTimer];
	
	m_pinTimer =  [NSTimer scheduledTimerWithTimeInterval:PIN_MOVE_INTERVAL target:self selector:@selector(pinStep:) userInfo:nil repeats:YES];			
}

-(void)stopPinTimer{
	if (m_pinTimer != nil)
	{
		[m_pinTimer invalidate];
		m_pinTimer = nil;
	}
}

-(void)startBLFBTimer{
	m_nBL_FBActionNum = 0;
	
	if (m_blfbMoveTimer != nil) 
		[self stopBLFBTimer];		
	
	m_blfbMoveTimer =  [NSTimer scheduledTimerWithTimeInterval:BL_FB_MOVE_INTERVAL target:self selector:@selector(fBBLStep:) userInfo:nil repeats:YES];		
}

-(void)stopBLFBTimer{
	if (m_blfbMoveTimer != nil)
	{
		[m_blfbMoveTimer invalidate];
		m_blfbMoveTimer = nil;		
	}
}

-(void)startCharacterTimer:(int)nAntionType{
	m_nActionType = nAntionType;

	if (m_characterTimer != nil) 
		[self stopCharacterTimer];		
	
	m_characterTimer = [NSTimer scheduledTimerWithTimeInterval:CHARACTER_MOVE_INTERVAL target:self selector:@selector(characterAni:) userInfo:nil repeats:YES];				
}

-(void)stopCharacterTimer{
	if (m_characterTimer != nil)
	{
		[m_characterTimer invalidate];
		m_characterTimer = nil;
	}
}

-(void)startNumTimer{
	if (m_numTimer != nil) 
		[self stopNumTimer];		
	
	m_nScoreStep = (m_nTotalScore - m_nScoreChange) / SCORE_CHANGE_STEP;
	
	if (m_nScoreStep == 0)
		m_nScoreStep = 1;
	
	m_numTimer =  [NSTimer scheduledTimerWithTimeInterval:NUM_CHANGE_INTERVAL target:self selector:@selector(numStep:) userInfo:nil repeats:YES];		
}

-(void)stopNumTimer{
	if (m_numTimer != nil)
	{
		[m_numTimer invalidate];
		m_numTimer = nil;
	}
}

-(void)doneStep:(id)sender{	
	if (m_rPuckPosX >= INIT_PUCK_POS_X * g_rX) 
		[self stopPuckTimer];	
	
	m_rPuckPosX += g_rVx * g_rScale;
	m_rPuckPosY -= g_rVy * g_rScale;
	
	if (m_Puck.hidden == YES)
		m_Puck.hidden = NO;
	
	[self displayPuck];
}

-(void)engineStep:(id)sender{
	if ([self isValidPuckInitAppear] || [self isValidMiddleLineOut])
	{
		[self stopEngineTimer];
		
		if (m_fStrike || usrInfo[g_nUsrIdx].nThrowState	>= SECOND_THROW)
		{
			[self initHitUsrInfo];
			
			m_Puck.hidden = YES;			
			self.view.userInteractionEnabled = NO;
						
			CGRect initRt, endRt;
			
			if ([self isValidLastBonus])
			{
				m_Puck.hidden = NO;			
				self.view.userInteractionEnabled = YES;	
				
				m_fPinInitAppear = YES;				
				m_fBonus = YES;
				usrInfo[g_nUsrIdx].nThrowState = FIRST_THROW;
				
				if (m_fStrike)
					usrInfo[g_nUsrIdx].nStrike ++;
				
				[self initHitBall];
				
				[self startBLFBTimer];
				[self startPuckTimer];
				
				return;
			}
			
			usrInfo[g_nUsrIdx].nLevel++;
			usrInfo[g_nUsrIdx].nThrowState = NON_THROW;
			
			if (m_fStrike)
				usrInfo[g_nUsrIdx].nStrike ++;
				
			[self searchUsrInfo];
			
			if (g_nUsrIdx == ONE_PLAY)
			{
				if (usrInfo[g_nUsrIdx].nLevel <= PIN_NUM)
					dispNumView(&m_frameNum[0], 2, usrInfo[g_nUsrIdx].nLevel);
			}
			
			if (m_fGameOver)
			{
				initRt = CGRectMake(IPAD_WIDTH * g_rX, 500 * g_rY, gameOverView.frame.size.width, gameOverView.frame.size.height);
				endRt = CGRectMake(0 * g_rX, 500 * g_rY, gameOverView.frame.size.width, gameOverView.frame.size.height);
				
				[self.view addSubview:gameOverView];
				m_fDispPlayer = YES;
				m_playerNumImg.image = ResourceManager::sharedInstance()->m_numberImg[g_nUsrIdx + 1];
				
				[self animationView:gameOverView initFrame:initRt endFrame:endRt durationTime:MOVE_FRAME_VIEW_INTERVAL];
				[self performSelector:@selector(delayGameOverView:) withObject:gameOverView afterDelay:MOVE_FRAME_VIEW_INTERVAL];
			}
			else
			{
				[self.view addSubview:frameView];
				
				initRt = CGRectMake(IPAD_WIDTH * g_rX, 500 * g_rY, frameView.frame.size.width, frameView.frame.size.height);
				endRt = CGRectMake(-IPAD_WIDTH * g_rX, 500 * g_rY, frameView.frame.size.width, frameView.frame.size.height);
				
				if (usrInfo[g_nUsrIdx].nLevel == PIN_NUM)
				{
					m_frameNumImg1.image = ResourceManager::sharedInstance()->m_numberImg[1];
					m_frameNumImg2.image = ResourceManager::sharedInstance()->m_numberImg[0];
				}
				else 
				{
					m_frameNumImg2.image = nil;
					m_frameNumImg1.image = ResourceManager::sharedInstance()->m_numberImg[usrInfo[g_nUsrIdx].nLevel];
				}				
				
				[self animationView:frameView initFrame:initRt endFrame:endRt durationTime:MOVE_FRAME_VIEW_INTERVAL];
				[self performSelector:@selector(delayFrameView:) withObject:frameView afterDelay:MOVE_FRAME_VIEW_INTERVAL];				
			}
		}
		else 
		{
			if (usrInfo[g_nUsrIdx].nThrowState != FIRST_THROW)
				[self startBLFBTimer];
			
			[self startPuckTimer];
		}
	}
	else
		[g_Engine startAnimation];
}

-(void)pinStep:(id)sender{
	if (!m_fScoreChange && [self isValidScoreChange] && !m_fStart)
	{
		[self dispAniView];
		
		if (m_fStrike || m_fSpare)
			[self scaleDispView];
		
		m_fScoreChange = YES;
		
		return;
	}
	
	for (int i = 0; i < PIN_NUM; i ++)
		[self processPinBall:i];
}

-(void)fBBLStep:(id)sender{
	m_pUIBL.image = ResourceManager::sharedInstance()->m_pBLImage[m_nBL_FBActionNum];
	m_pUIFB.image = ResourceManager::sharedInstance()->m_pFBImage[m_nBL_FBActionNum];
	
	m_nBL_FBActionNum++;
	m_nBL_FBActionNum = m_nBL_FBActionNum >= BL_IMAGE_NUM ? 0 : m_nBL_FBActionNum;	
}

-(void)numStep:(id)sender{
	m_nScoreChange += m_nScoreStep;
	
	if (m_nScoreChange >= m_nTotalScore)
	{
		m_nScoreChange = m_nTotalScore;
		[self stopNumTimer];		
	}
	
	switch (m_nScorePlayerIdx) {
		case ONE_PLAY:
			dispNumView(&firtScoreView[0], 4, m_nScoreChange);
			break;
		case TWO_PLAY:
			dispNumView(&secondScoreView[0], 4, m_nScoreChange);
			break;
		case THREE_PLAY:
			dispNumView(&thirdScoreView[0], 4, m_nScoreChange);
			break;
		case FOUR_PLAY:
			dispNumView(&forthScoreView[0], 4, m_nScoreChange);
			break;
		default:
			break;
	}
}

-(void)delayFrameView:(id)sender{
	[frameView removeFromSuperview];
	
	[self initHitBall];	
	
	m_fPinInitAppear = YES;
	m_fStrike = NO;
	m_fSpare = NO;
	
	if (g_nUsrState == ONE_PLAY)
	{
		m_Puck.hidden = NO;
		self.view.userInteractionEnabled = YES;
		
		[self startBLFBTimer];
		[self startPuckTimer];		
	}
	else 
	{
		CGRect initRt = CGRectMake(IPAD_WIDTH * g_rX, 500 * g_rY, playerView.frame.size.width, playerView.frame.size.height);
		CGRect endRt = CGRectMake(0 * g_rX, 500 * g_rY, playerView.frame.size.width, playerView.frame.size.height);
		
		[self.view addSubview:playerView];
		
		m_fDispPlayer = YES;
		m_playerNumImg.image = ResourceManager::sharedInstance()->m_numberImg[g_nUsrIdx + 1];
		
		[self animationView:playerView initFrame:initRt endFrame:endRt durationTime:MOVE_FRAME_VIEW_INTERVAL];
		[self performSelector:@selector(delayPlayerView:) withObject:playerView afterDelay:MOVE_FRAME_VIEW_INTERVAL];
	}
}

-(void)delayPlayerView:(id)sender{
	self.view.userInteractionEnabled = YES;
}

-(void)delayDisapearplayerView:(id)sender{
	m_Puck.hidden = NO;
	m_fDispPlayer = NO;
	
	[playerView removeFromSuperview];

	[self startBLFBTimer];
	[self startPuckTimer];
}

-(void)delayGameOverView:(id)sender{
	[gameOverView removeFromSuperview];
	
	m_Puck.hidden = NO;
	self.view.userInteractionEnabled = YES;
	
	if (g_nUsrState == ONE_PLAY)
	{
		OnePlayerScoreViewController* onePlayerScoreViewController;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
			onePlayerScoreViewController = [[OnePlayerScoreViewController alloc] initWithNibName:@"OnePlayerScoreViewController_iPhone" bundle:[NSBundle mainBundle]];
		else 
			onePlayerScoreViewController = [[OnePlayerScoreViewController alloc] initWithNibName:@"OnePlayerScoreViewController_iPad" bundle:[NSBundle mainBundle]];
		
		[self.navigationController pushViewController:onePlayerScoreViewController animated:YES];
		[onePlayerScoreViewController release];
	}
	else
	{
		TotalViewController* totalViewController;
		
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
			totalViewController = [[TotalViewController alloc] initWithNibName:@"TotalViewController_iPhone" bundle:[NSBundle mainBundle]];
		else 
			totalViewController = [[TotalViewController alloc] initWithNibName:@"TotalViewController_iPad" bundle:[NSBundle mainBundle]];
		
		self.view.userInteractionEnabled = YES;
		[self.navigationController pushViewController:totalViewController animated:YES];
		
		[totalViewController release];
	}	
	
	m_fGameOver = NO;
	g_btnContinue.enabled = NO;
}

-(void)characterAni:(id)sender{
	m_nCharacterAniNum++;
	
	if (m_nActionType == CRY_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pCryImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == DANCE_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pDanceImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == FISTPUMP_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pFistPumpImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == GUITAR_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pGuitarImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == HIGHSCORE_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pHighScoreImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == HSHAKE_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pHShakeImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == LIGHTNINGARC_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pLightningArcImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == LIGHTNINGHAND_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pLightningHandImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == PINRAIN_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pPinRainImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == POINT_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pPointImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == PUNCH_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pPunchImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == SHIELD_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pShieldImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];
	else if (m_nActionType == SPLIT_ANIMATION)
		m_pUICharacter.image = ResourceManager::sharedInstance()->m_pSplitImage[ANIMATION_FRAME_NUM[m_nActionType][m_nCharacterAniNum]];	
	
	if (m_nCharacterAniNum == ANIMATION_NUM[m_nActionType])
	{
		m_nCharacterAniNum = 0;
		[self stopCharacterTimer];
	}	
}

#pragma mark FUNCTION_PASCAL

-(void)setPuckAppearParam{
	g_rVx = INIT_PUCK_APPEAR_V_X * g_rX;
	g_rVy = INIT_PUCK_APPEAR_V_Y * g_rY;
	
	m_rPuckPosX = INIT_PUCK_APPEAR_POS_X * g_rX;
	m_rPuckPosY = BOTTOM_MARGIN * g_rY;
	
	m_Puck.center = CGPointMake(m_rPuckPosX, m_rPuckPosY);
	g_rScale = 1.0f;	
}

-(void)setPlayerPuckView{
	UIImage* img;
	if (g_nUsrIdx == ONE_PLAY)
		img = [UIImage imageNamed:@"Puck.png"];
	else if (g_nUsrIdx == TWO_PLAY)
		img = [UIImage imageNamed:@"Puck_p2.png"];
	else if (g_nUsrIdx == THREE_PLAY)
		img = [UIImage imageNamed:@"Puck_p3.png"];
	else if (g_nUsrIdx == FOUR_PLAY)
		img = [UIImage imageNamed:@"Puck_p4.png"];
	
	m_Puck.image = img;
}

-(void)displayPuck{
	float rlastPuckScale = (RIGHT_TOP_X - LEFT_TOP_X) / (RIGHT_BOTTOM_X - LEFT_BOTTOM_X);
	g_rScale = 1 - (BOTTOM_MARGIN * g_rY - m_Puck.center.y) / ((BOTTOM_MARGIN - TOP_MARGIN) * g_rY) * (1 - rlastPuckScale);	
	
	CGRect PuckRect;
	PuckRect = [m_Puck frame];
	PuckRect.size.width = INIT_PUCK_WIDTH * g_rX * g_rScale;
	PuckRect.size.height = INIT_PUCK_HEIGHT * g_rY * g_rScale;

	[m_Puck setFrame:PuckRect];
	[m_Puck setCenter:CGPointMake(m_rPuckPosX, m_rPuckPosY)]; 
}

-(void)dispAniView{	
	if (m_nBL_FBActionNum == 0)
		m_nBL_FBActionNum = BL_IMAGE_NUM - 1;
	else 
		m_nBL_FBActionNum --;
	
	int nFrameScore = [self getTotalScore];
	
	m_nScoreChange = usrInfo[g_nUsrIdx].nScore;
	
	usrInfo[g_nUsrIdx].nScore += nFrameScore;	
	m_nTotalScore = usrInfo[g_nUsrIdx].nScore;
	
	m_nScorePlayerIdx = g_nUsrIdx;
	
	[self startNumTimer];

#ifdef ANI_RESOURCE_INCLUDE
	if (m_fBonus)
	{
		if (g_nUsrState == ONE_PLAY)
		{
			[self startCharacterTimer:HIGHSCORE_ANIMATION];
		    ResourceManager::sharedInstance()->playSound(SK_GUITARB_SOUND);
		}
		else
		{
			[self startCharacterTimer:DANCE_ANIMATION];
		    ResourceManager::sharedInstance()->playSound(SK_GUITARC_SOUND);
		}
	}
	else 
	{
		if (m_fStrike)
		{
			if (nFrameScore == 810) {
				[self startCharacterTimer:GUITAR_ANIMATION];
				ResourceManager::sharedInstance()->playSound(SK_GUITARA_SOUND);
			}
			if (nFrameScore == 610) {
				[self startCharacterTimer:POINT_ANIMATION];
				ResourceManager::sharedInstance()->playSound(STRIKECHEER_SOUND);
			}
			if (nFrameScore == 510) {
				[self startCharacterTimer:LIGHTNINGARC_ANIMATION];
				ResourceManager::sharedInstance()->playSound(THUNDERANIMATION_SOUND);
			}
			if (nFrameScore == 410 || nFrameScore == 310) {
				[self startCharacterTimer:LIGHTNINGHAND_ANIMATION];
				ResourceManager::sharedInstance()->playSound(THUNDERANIMATION_SOUND);
			}
		}
		
		else if (m_fSpare)
		{
			if (nFrameScore == 510) {
				[self startCharacterTimer:FISTPUMP_ANIMATION];
				ResourceManager::sharedInstance()->playSound(SPAREPICKUP_SOUND);
			}
			if (nFrameScore == 410) {
				[self startCharacterTimer:PUNCH_ANIMATION];
				ResourceManager::sharedInstance()->playSound(SPLITPICKUP_SOUND);
			}
			if (nFrameScore == 310 || nFrameScore == 210 || nFrameScore == 110) {
				[self startCharacterTimer:SHIELD_ANIMATION];
				ResourceManager::sharedInstance()->playSound(SPLITPICKUP_SOUND);
			}
		}
		
		else {
			if (nFrameScore >= 7) {
				[self startCharacterTimer:HSHAKE_ANIMATION];
				ResourceManager::sharedInstance()->playSound(MISSEDSPARE_SOUND);
			}
			if (nFrameScore == 5 || nFrameScore == 6) {
				[self startCharacterTimer:CRY_ANIMATION];		
				ResourceManager::sharedInstance()->playSound(MISSEDSPLIT_SOUND);
			}		
			if (nFrameScore < 5) {
				[self startCharacterTimer:PINRAIN_ANIMATION];		
				ResourceManager::sharedInstance()->playSound(MISSEDSPLIT_SOUND);
			}		
			
		}
	}
	
#endif	
//	NSLog(@"Total Score  %d", usrInfo[g_nUsrIdx].nScore);	
//	NSLog(@"Hit Count   %d", m_nPinHitCount);
}

-(void)scaleDispView{
//	UIImage* img = [self makeImageNumber:3];
//	
//	//save 
//
//	NSData* Dat = UIImagePNGRepresentation(img);
//	[Dat writeToFile:@"1.png" atomically:YES];
	
	int x, y;
	int width, height, intervalW, intervalH;
		
	x = 180; y = 356;
	width = 49; height = 34; intervalW = 54; intervalH = 28;
	
	int nFirstNum;
	if (m_nBL_FBActionNum == 0 || m_nBL_FBActionNum == 8)
	{
		if (m_nBL_FBActionNum == 0)
			m_initRect = CGRectMake((FB_X[0] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);
		else
			m_initRect = CGRectMake((FB_X[8] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);
		
		if (m_fStrike)
			nFirstNum = 3;
		else 
			nFirstNum = 1;
	}
	else if (m_nBL_FBActionNum == 1 || m_nBL_FBActionNum == 7)
	{
		if (m_nBL_FBActionNum == 1)
			m_initRect = CGRectMake((FB_X[1] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);
		else
			m_initRect = CGRectMake((FB_X[7] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);
		
		if (m_fStrike)
			nFirstNum = 4;
		else 
			nFirstNum = 2;
	}
	else if (m_nBL_FBActionNum == 2 || m_nBL_FBActionNum == 6)
	{
		if (m_nBL_FBActionNum == 2)
			m_initRect = CGRectMake((FB_X[2] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);
		else
			m_initRect = CGRectMake((FB_X[6] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);	
		
		if (m_fStrike)
			nFirstNum = 5;
		else 
			nFirstNum = 3;
	}
	else if (m_nBL_FBActionNum == 3 || m_nBL_FBActionNum == 5)
	{
		if (m_nBL_FBActionNum == 3)
			m_initRect = CGRectMake((FB_X[3] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);
		else
			m_initRect = CGRectMake((FB_X[5] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);
		
		if (m_fStrike)
			nFirstNum = 6;
		else 
			nFirstNum = 4;
	}
	else if (m_nBL_FBActionNum == 4)
	{
		m_initRect = CGRectMake((FB_X[4] + x) * g_rX, y * g_rY, width * g_rX, height * g_rY);
		
		if (m_fStrike)
			nFirstNum = 8;
		else 
			nFirstNum = 5;
	}
	
	if (m_fSpare)
		m_initRect.origin.y += intervalH * g_rY;  
		
	x = m_initRect.origin.x - m_initRect.size.width;
	y = m_initRect.origin.y - m_initRect.size.height;
	
	m_lastRect = CGRectMake(x, y, m_initRect.size.width * 3, m_initRect.size.height * 3);
//	initRect = CGRectMake(248, 366, 108, 54);
//	lastRect = CGRectMake(146, 294, 272, 224);
	
	m_pUIFB.alpha = 0.0;
	UIImageView* scaleView = [[UIImageView alloc] initWithImage:[self makeImageNumber:nFirstNum]];
	[self.view addSubview:scaleView];
	
	[self animationView:scaleView initFrame:m_initRect endFrame:m_lastRect durationTime:SCALE_BIG_SMALL_VIEW_INTERVAL];
	[self performSelector:@selector(scaleBigDispView:) withObject:scaleView afterDelay:SCALE_BIG_SMALL_VIEW_INTERVAL];
}

-(void)scaleBigDispView:(id)sender{
	UIImageView* scaleView = (UIImageView*)sender;
	
	[self animationView:scaleView initFrame:m_lastRect endFrame:m_initRect durationTime:SCALE_BIG_SMALL_VIEW_INTERVAL];
	[self performSelector:@selector(scaleSmallDispView:) withObject:scaleView afterDelay:SCALE_BIG_SMALL_VIEW_INTERVAL];
}

-(void)scaleSmallDispView:(id)sender{
	UIImageView* scaleView = (UIImageView*)sender;
	[scaleView removeFromSuperview];
	[scaleView.image release];
	
	m_pUIFB.alpha = 1.0;
}

-(void)processPinBall:(int) nPinIndex{
	if (m_fPinInitAppear)
	{
		if(m_nPinBallIndex[nPinIndex] == -1)
			m_pUIPin[nPinIndex].image = nil;
		else 
		{
			m_fPinInitAppear = m_nPinBallIndex[PIN_NUM - 1] == 0 ? NO : YES;			
			m_pUIPin[nPinIndex].image = ResourceManager::sharedInstance()->m_pinImg[m_nPinBallIndex[nPinIndex]];
			
			if (m_nPinBallIndex[nPinIndex] != 0)
				m_nPinBallIndex[nPinIndex] --;
		}		
	}
	else 
	{
		if (g_fPinballHit[nPinIndex] && m_nPinBallIndex[nPinIndex] != -1 && m_nPinBallIndex[nPinIndex] != 7)
		{
			if (!m_fStrike)
				m_fStrike = [self isValidStrike];
			
			if (!m_fSpare)
				m_fSpare = [self isValidSpare];
			
			[self stopBLFBTimer];			

			if (!m_fPinHitSound)
			{
				ResourceManager::sharedInstance()->playSound(PINHITMULTIPLE_SOUND);
				m_fPinHitSound = YES;	
			}
			
			m_nPinBallIndex[nPinIndex]++;			
			m_nPinBallIndex[nPinIndex] = m_nPinBallIndex[nPinIndex] >= PIN_IMGAE_NUM ? PIN_IMGAE_NUM - 1:m_nPinBallIndex[nPinIndex];
			m_pUIPin[nPinIndex].image = ResourceManager::sharedInstance()->m_pinImg[m_nPinBallIndex[nPinIndex]];															
		}
	}
}

-(BOOL)isValidTouchMove:(CGPoint)pt{
	LINE_ELEMENT l[4];
	
	l[0].sp = CGPointMake(0, IPAD_HEIGHT * g_rY);
	l[0].ep = CGPointMake(180 * g_rX, FOUL_LINE_Y * g_rY);
	
	l[1].sp = CGPointMake(180 * g_rX, FOUL_LINE_Y * g_rY);
	l[1].ep = CGPointMake(604 * g_rX, FOUL_LINE_Y * g_rY);
	
	l[2].sp = CGPointMake(IPAD_WIDTH * g_rX, IPAD_HEIGHT * g_rY);
	l[2].ep = CGPointMake(604 * g_rX, FOUL_LINE_Y * g_rY);	
	
	l[3].sp = CGPointMake(0, IPAD_HEIGHT * g_rY);
	l[3].ep = CGPointMake(IPAD_WIDTH * g_rX, IPAD_HEIGHT * g_rY);
	
	LINE_ELEMENT l_touch;
	l_touch.sp = CGPointMake(INIT_PUCK_POS_X * g_rX, INIT_PUCK_POS_Y * g_rY);
	l_touch.ep = pt;
	CGFloat x = MIN(l_touch.sp.x, l_touch.ep.x);
	CGFloat y = MIN(l_touch.sp.y, l_touch.ep.y);
	CGRect validRect = CGRectMake(x, y, fabs(l_touch.sp.x - l_touch.ep.x), fabs(l_touch.sp.y - l_touch.ep.y));
	for (int i = 0; i < 4; i++) {
		CGPoint pt_intersect = getIntersectPos(l[i], l_touch);
		if (!CGPointEqualToPoint(pt_intersect, CGPointZero) &&
			CGRectContainsPoint(validRect, pt_intersect)) {
			return NO;
		}
	}
	return YES;
}

-(BOOL)isValidStrike{
	for (int i = 0; i < PIN_NUM; i ++)
		if (!g_fPinballHit[i])
			return NO;
	
	if (usrInfo[g_nUsrIdx].nThrowState == FIRST_THROW)
	{
//		NSLog(@"strike");
		return YES;
	}
	else
		return NO;
}

-(BOOL)isValidGameOver{
	if (g_nUsrIdx == g_nUsrState && usrInfo[g_nUsrIdx].nLevel > PIN_NUM)
	{
//		NSLog(@"gameOver");
		return YES;
	}
	else 
		return NO;
}

-(BOOL)isValidSpare{
	for (int i = 0; i < PIN_NUM; i ++)
		if (!g_fPinballHit[i])
			return NO;
	
	if (usrInfo[g_nUsrIdx].nThrowState != SECOND_THROW)
		return NO;
	
//	NSLog(@"spare");
	return YES;
}

-(BOOL)isValidPuckInitAppear{
	if (usrInfo[g_nUsrIdx].nThrowState >= SECOND_THROW && !m_fScoreChange)
	{
		if (!m_fScoreChange)
		{
			for (int i = 0; i < PIN_NUM; i ++)
			{
				if (g_fPinballHit[i])
					return NO;
			}
		}		
	}
	
	if ([m_numTimer isValid] || [m_characterTimer isValid])
		return NO;
	
	if (g_fPuckInitAppear)	
		return YES;
	
	if (g_Engine.m_fPuckStop && usrInfo[g_nUsrIdx].nThrowState >= SECOND_THROW || (m_fStrike && g_Engine.m_fPuckStop))
		return YES;
	
	return NO;
}

-(BOOL)isValidLastBonus{
	if ((m_fStrike && usrInfo[g_nUsrIdx].nLevel == PIN_NUM)|| (m_fSpare && usrInfo[g_nUsrIdx].nLevel == PIN_NUM))
	{
//		NSLog(@"lastBonus");
		return YES;
	}
	else 
		return NO;					
}

-(BOOL)isValidTouchDown{
	if (m_fGameOver || m_fDispPlayer || (!g_Engine.m_fPuckStop && [m_engineTimer isValid]) || m_fHelp)
		return NO;
	
	if (usrInfo[g_nUsrIdx].nThrowState >= SECOND_THROW)
		return NO;
	
	return YES;
}

-(BOOL)isValidScoreChange{
	if (usrInfo[g_nUsrIdx].nThrowState == FIRST_THROW && !m_fStrike)
		return NO;	
	
	if ([self isValidHit] && [self isValidPinState])
	{
//		NSLog(@"Valid Hit");
		return YES;
	}	
	else if (![self isValidHit] && g_Engine.m_fPuckStop)
	{
//		NSLog(@"Valid No Hit");
		return YES;
	}
	else 
		return NO;
}

-(BOOL)isValidHit{
	for (int i = 0; i < PIN_NUM; i ++)
	{
		if (g_fPinballHit[i] == usrInfo[g_nUsrIdx].fPinHit[i])
			continue;
		else
		{
			return YES;	
		}
	}
	
	return NO;
}

-(BOOL)isValidPinState{
	for (int i = 0; i < PIN_NUM; i ++)
	{
		if (g_fPinballHit[i] && (m_nPinBallIndex[i] == 7))
			continue;
		else if (!g_fPinballHit[i] && (m_nPinBallIndex[i] == 0))
			continue;
		else if (g_fPinballHit[i] && (m_nPinBallIndex[i] == -1))
			continue;
		else 
			return NO;
	}
	
	return YES;
}

-(BOOL)isValidMiddleLineOut{
	if (usrInfo[g_nUsrIdx].nThrowState >= SECOND_THROW && !m_fScoreChange)
		return NO;
	
	if (g_Engine.m_fPuckStop && m_Puck.center.y <= FOUL_LINE_Y * g_rY)
		return YES;
	else 
		return NO;
}

-(void)searchUsrInfo{
	if (g_nUsrIdx == g_nUsrState && usrInfo[g_nUsrIdx].nLevel > PIN_NUM)
		m_fGameOver = YES;
	else 
	{
		if (g_nUsrState == ONE_PLAY)
			g_nUsrIdx = 0;
		else
		{
			g_nUsrIdx ++;
			
			if (g_nUsrIdx > g_nUsrState)
				g_nUsrIdx = ONE_PLAY;	
			
			m_fBonus = NO;
		}
		
		[self setPlayerPuckView];
		[self usrChangeSeleted];
	}	
}

-(int)getPinHitCount{
	int nHitCount = 0;
	
	for (int i = 0; i < PIN_NUM; i ++)
		if (g_fPinballHit[i])
			nHitCount ++;
	
	return nHitCount;
}

-(int)getTotalScore {
	int nTmpCnt = [self getPinHitCount];
	
//	NSLog(@"Hit Count  %d", nTmpCnt);
	int nScore = 1 * nTmpCnt;	
	
	if (m_fStrike || m_fSpare)
	{
		if (m_nBL_FBActionNum == 0 || m_nBL_FBActionNum == 8)
		{
			if (m_fStrike)
				nScore += 300;
			else 
				nScore += 100;
		}
		else if (m_nBL_FBActionNum == 1 || m_nBL_FBActionNum == 7)
		{
			if (m_fStrike)
				nScore += 400;
			else 
				nScore += 200;
		}
		else if (m_nBL_FBActionNum == 2 || m_nBL_FBActionNum == 6)
		{
			if (m_fStrike)
				nScore += 500;
			else 
				nScore += 300;
		}
		else if (m_nBL_FBActionNum == 3 || m_nBL_FBActionNum == 5)
		{
			if (m_fStrike)
				nScore += 600;
			else 
				nScore += 400;
		}
		else if (m_nBL_FBActionNum == 4)
		{
			if (m_fStrike)
				nScore += 800;
			else 
				nScore += 500;
		}
	}    
	
	return nScore;
}

-(void)usrChangeSeleted{
	int i, j;
	
	for (i = 0; i <= g_nUsrState; i ++)
		playerImgView[i].alpha = CHECK_CHANGE_ALPHA;
	
	for (i = 0; i <= g_nUsrState; i ++)
	{
		if (i == ONE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				firtScoreView[j].alpha = CHECK_CHANGE_ALPHA;
		}
		if (i == TWO_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				secondScoreView[j].alpha = CHECK_CHANGE_ALPHA;
		}
		if (i == THREE_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				thirdScoreView[j].alpha = CHECK_CHANGE_ALPHA;
		}
		if (i == FOUR_PLAY)
		{
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				forthScoreView[j].alpha = CHECK_CHANGE_ALPHA;
		}
	}
			
	switch (g_nUsrIdx)
	{
		case ONE_PLAY:
			playerImgView[ONE_PLAY].alpha = 1.0;
			
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				firtScoreView[j].alpha = 1.0;			
			break;
		case TWO_PLAY:
			playerImgView[TWO_PLAY].alpha = 1.0;
			
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				secondScoreView[j].alpha = 1.0;
			break;
		case THREE_PLAY:
			playerImgView[THREE_PLAY].alpha = 1.0;
			
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				thirdScoreView[j].alpha = 1.0;
			break;
		case FOUR_PLAY:
			playerImgView[FOUR_PLAY].alpha = 1.0;
			
			for (j = 0; j < MAX_SCORE_LENGTH; j ++)
				forthScoreView[j].alpha = 1.0;
			break;
		default:
			break;
	}
}

#pragma mark MOVE_VIEW

-(void)animationView:(UIView*)view initFrame:(CGRect)sFrame endFrame:(CGRect)eFrame durationTime:(float)rTime{
	[view setFrame:sFrame];
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:rTime];
	[view setFrame:eFrame];
	[UIView commitAnimations];	
}

#pragma mark SCALE_IMAGE_MAKE

-(UIImage*)makeImageNumber:(int)nFirstScaleNum{
	int nDigitCount = 3;
	int digitWidth;
	
	int nFontWidth  = ResourceManager::sharedInstance()->m_numberImg[0].size.width;
	int nFontHeight = ResourceManager::sharedInstance()->m_numberImg[0].size.height;
		
	digitWidth = nFontWidth + nFontWidth / 10;
	
	CGSize imgSize = CGSizeMake(digitWidth * nDigitCount, nFontHeight);
	
	CGFloat rSx, rSy;
	
	CGSize winSize;

	winSize.width = 147 * g_rX;
	winSize.height = 102 * g_rY;
	
	rSx = winSize.width / imgSize.width;
	rSy = winSize.height / imgSize.height;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef Context = CGBitmapContextCreate(NULL, 
												 winSize.width, 
												 winSize.height , 
												 8, 
												 0, 
												 colorSpace, 
												 kCGImageAlphaPremultipliedLast ); 
	for (int i = 0; i < nDigitCount; i++)
	{
		if (i == 0)
			CGContextDrawImage(Context, CGRectMake(i * digitWidth * rSx, 0, nFontWidth * rSx, nFontHeight * rSy), ResourceManager::sharedInstance()->m_numberImg[nFirstScaleNum].CGImage);
		else 
			CGContextDrawImage(Context, CGRectMake(i * digitWidth * rSx, 0, nFontWidth * rSx, nFontHeight * rSy), ResourceManager::sharedInstance()->m_numberImg[0].CGImage);
	}
	
	CGImageRef ImageRef = CGBitmapContextCreateImage (Context);
	UIImage* resultImage = [[UIImage alloc] initWithCGImage:ImageRef]; 
	CGImageRelease(ImageRef);
	
	CGColorSpaceRelease(colorSpace);
	CGContextRelease(Context);
	
	return resultImage;
}

@end