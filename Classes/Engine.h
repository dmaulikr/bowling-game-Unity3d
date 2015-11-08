//
//  Engine.h
//  StrikeKnight
//
//  Created by chang on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Engine : NSObject {
	//#pragma mark WallHitted
	BOOL m_fTopWallHitted;
	BOOL m_fBottomWallHitted;
	BOOL m_fLeftWallHitted;
	BOOL m_fRightWallHitted;
	
	BOOL m_fPuckStop;
	
	UIImageView*	m_puck;	
	
	float m_rOldPuckPosX;
	float m_rOldPuckPosY;
	
	float m_rPuckPosX;
	float m_rPuckPosY;
}

@property 	BOOL m_fPuckStop;

-(void)initEngineParam;
-(void)setPuckView:(UIImageView*)puckView;

-(void)startAnimation;

-(void)calcPuckPos;
-(void)hitWallProcess;
-(void)displayPuck;
-(void)hitPinProcess;

@end

void	createEngine();
void	deleteEngine();