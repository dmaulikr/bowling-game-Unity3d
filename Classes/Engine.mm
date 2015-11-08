//
//  Engine.mm
//  StrikeKnight
//
//  Created by chang on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Engine.h"
#import "Global.h"

@implementation Engine

@synthesize m_fPuckStop;

-(id)init{
	if ((self == [super init]))
		[self initEngineParam];

	return self;
}

-(void)initEngineParam{
	m_fTopWallHitted = NO;
	m_fBottomWallHitted = NO;
	m_fLeftWallHitted = NO;
	m_fRightWallHitted = NO;
	
	m_fPuckStop = NO;
	
	m_rPuckPosX = m_puck.center.x;
	m_rPuckPosY = m_puck.center.y;	
}

-(void)setPuckView:(UIImageView*)puckView{
	m_puck = puckView;
}

#pragma mark mainFunctions for Game

-(void)calcPuckPos{
	if (m_fTopWallHitted || m_fLeftWallHitted || m_fRightWallHitted || m_fBottomWallHitted)
	{
		g_rVx *= 0.93;
		g_rVy *= 0.93;		
	}
	else 
	{
		g_rVx *= 0.93;
		g_rVy *= 0.93;
	}

	m_rOldPuckPosX = m_rPuckPosX;
	m_rOldPuckPosY = m_rPuckPosY;
	m_rPuckPosX += g_rVx * g_rScale;
	m_rPuckPosY -= g_rVy * g_rScale;	
//	NSLog(@"g_Vx: %f", g_rVx);
}

-(void)hitWallProcess{
	int tmp;
	if (((float)(BOTTOM_MARGIN * g_rY - m_rPuckPosY) / ((BOTTOM_MARGIN - TOP_MARGIN) * g_rY)) >= ((float)(m_rPuckPosX - LEFT_BOTTOM_X * g_rX) / ((LEFT_TOP_X - LEFT_BOTTOM_X) * g_rX)) && m_rPuckPosX < INIT_PUCK_POS_X * g_rX && !m_fLeftWallHitted)
	{	
		m_rPuckPosX = m_rOldPuckPosX;//In order to bounce back at the hitted position. Otherwise puck's speed is very fast, so puck is escaped from board.
		m_rPuckPosY = m_rOldPuckPosY;
		
		if ((fabs(g_rVx) / fabs(g_rVy)) < 0.4f && fabs(g_rVy) != 0.0f) 
			g_rVx = 0.6f * fabs(g_rVy);		
		else 
			g_rVx = fabs(g_rVx);
		
		m_fLeftWallHitted = YES;
		m_fRightWallHitted = NO;
		tmp = 1;
	}
	else if (((float)(BOTTOM_MARGIN * g_rY - m_rPuckPosY) / ((BOTTOM_MARGIN - TOP_MARGIN) * g_rY)) >= ((float)(m_rPuckPosX - RIGHT_BOTTOM_X * g_rX) / ((RIGHT_TOP_X - RIGHT_BOTTOM_X) * g_rX)) && m_rPuckPosX > INIT_PUCK_POS_X * g_rX && !m_fRightWallHitted)
	{
		m_rPuckPosX = m_rOldPuckPosX;
		m_rPuckPosY = m_rOldPuckPosY;
		
		if ((fabs(g_rVx) / fabs(g_rVy)) < 0.4f && fabs(g_rVy) != 0.0f) 
			g_rVx = -0.6f * fabs(g_rVy);		
		else 
			g_rVx = -fabs(g_rVx);

		m_fRightWallHitted = YES;
		m_fLeftWallHitted = NO;
		tmp = 2;
	}
	else if (m_rPuckPosY <= TOP_MARGIN * g_rY && !m_fTopWallHitted)
	{ 
		m_rPuckPosX = m_rOldPuckPosX;
		m_rPuckPosY = m_rOldPuckPosY;
		g_rVy = -g_rVy;
		m_fTopWallHitted = YES;		
	}
	else if (m_rPuckPosY >= BOTTOM_MARGIN * g_rY && !m_fBottomWallHitted)
	{ 
		m_rPuckPosX = m_rOldPuckPosX;
		m_rPuckPosY = m_rOldPuckPosY;
		g_rVy = -g_rVy * 0.5;
		m_fBottomWallHitted = YES;
	}
//	NSLog(@"Vx: %f, Vy: %f", g_rVx, g_rVy);
//	NSLog(@"BOOL: %d", tmp);
}

-(void)hitPinProcess {
	if (m_rPuckPosX >= (PIN0_POS_LEFT_X - 9 * RATE_WIDTH) * g_rX && m_rPuckPosX < PIN1_POS_LEFT_X * g_rX && m_rPuckPosY < PIN0_POS_Y * g_rY && !m_fTopWallHitted) {
		g_fPinballHit[0] = YES;
	}
	if (m_rPuckPosX > PIN1_POS_LEFT_X * g_rX && m_rPuckPosX < PIN0_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN0_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[0]) {
		g_fPinballHit[0] = YES;		
		g_fPinballHit[7] = YES;
	}
	if (m_rPuckPosX > PIN1_POS_LEFT_X * g_rX && m_rPuckPosX < PIN1_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN1_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[1]) {
		g_fPinballHit[1] = YES;
		g_fPinballHit[9] = YES;
	}
	if (m_rPuckPosX > PIN2_POS_LEFT_X * g_rX && m_rPuckPosX < PIN2_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN2_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[2]) {
		g_fPinballHit[2] = YES;
		g_fPinballHit[4] = YES;
	}
	if (m_rPuckPosX > PIN3_POS_LEFT_X * g_rX && m_rPuckPosX < PIN3_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN3_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[3]) {
		g_fPinballHit[3] = YES;
		g_fPinballHit[2] = YES;
		g_fPinballHit[4] = YES;
	}
	if (m_rPuckPosX > PIN4_POS_LEFT_X * g_rX && m_rPuckPosX < PIN4_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN4_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[4]) {
		g_fPinballHit[4] = YES;
		g_fPinballHit[2] = YES;
	}
	if (m_rPuckPosX > PIN5_POS_LEFT_X * g_rX && m_rPuckPosX < PIN5_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN5_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[5]) {
		g_fPinballHit[5] = YES;
		g_fPinballHit[9] = YES;
	}
	if (m_rPuckPosX > PIN6_POS_LEFT_X * g_rX && m_rPuckPosX < PIN5_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN6_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[6]) {
		g_fPinballHit[6] = YES;
		g_fPinballHit[8] = YES;
	}	
	if (m_rPuckPosX > PIN5_POS_RIGHT_X * g_rX && m_rPuckPosX < (PIN6_POS_RIGHT_X + 9 * RATE_WIDTH) * g_rX && m_rPuckPosY < PIN6_POS_Y * g_rY && !m_fTopWallHitted) {
		g_fPinballHit[6] = YES;
	}
	if (m_rPuckPosX > PIN7_POS_LEFT_X * g_rX && m_rPuckPosX < PIN7_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN7_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[7]) {
		g_fPinballHit[7] = YES;
		g_fPinballHit[0] = YES;
		g_fPinballHit[8] = YES;		
		if (m_rPuckPosX > (PIN7_POS_LEFT_X + 15 * RATE_WIDTH) * g_rX && m_rPuckPosX < (PIN7_POS_RIGHT_X) * g_rX && g_fPinballHit[1] && g_fPinballHit[2] && g_fPinballHit[3] && g_fPinballHit[4] && g_fPinballHit[5] && g_fPinballHit[9]) {
			g_fPinballHit[6] = YES;			
		}		
	}
	if (m_rPuckPosX > PIN8_POS_LEFT_X * g_rX && m_rPuckPosX < PIN8_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN8_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[8]) {
		g_fPinballHit[8] = YES;
		g_fPinballHit[7] = YES;
		g_fPinballHit[6] = YES;
	}
	if (m_rPuckPosX > PIN9_POS_LEFT_X * g_rX && m_rPuckPosX < PIN9_POS_RIGHT_X * g_rX && m_rPuckPosY < PIN9_POS_Y * g_rY && !m_fTopWallHitted && !g_fPinballHit[9]) {
		g_fPinballHit[9] = YES;
		g_fPinballHit[1] = YES;
		g_fPinballHit[5] = YES;
	}		
}

-(void)displayPuck
{
	float rlastPuckScale = (RIGHT_TOP_X - LEFT_TOP_X) / (RIGHT_BOTTOM_X - LEFT_BOTTOM_X);
	g_rScale = 1 - (BOTTOM_MARGIN * g_rY - m_rPuckPosY) / ((BOTTOM_MARGIN - TOP_MARGIN) * g_rY) * (1 - rlastPuckScale);	
	
	CGRect PuckRect;
	PuckRect = [m_puck frame];
	PuckRect.size.width = INIT_PUCK_WIDTH * g_rX * g_rScale;
	PuckRect.size.height = INIT_PUCK_HEIGHT * g_rY * g_rScale;
	
	[m_puck setFrame:PuckRect];	
	[m_puck setCenter:CGPointMake(m_rPuckPosX, m_rPuckPosY)]; 
}

-(void)startAnimation{
	if ((((Sqr(g_rVy) + Sqr(g_rVx)) <= 0.1f * RATE_HEIGHT * g_rY && (m_rPuckPosY <= FOUL_LINE_Y * g_rY)) || ((Sqr(g_rVy) + Sqr(g_rVx)) <= 5.0f * RATE_HEIGHT * g_rY && !m_fTopWallHitted)) && !g_fPuckInitAppear)//and strike or spare
		g_fPuckInitAppear = YES;
	
	if ((Sqr(g_rVy) + Sqr(g_rVx)) <= 0.1f)
		m_fPuckStop = YES;
	
	[self calcPuckPos];	
	[self hitPinProcess];	
	[self hitWallProcess];	
	[self displayPuck];
}

@end

void	createEngine()
{
	if (g_Engine)
		deleteEngine();
	
	g_Engine = [[Engine alloc] init];
}

void	deleteEngine()
{
	[g_Engine release];
	g_Engine = nil;
}
