//
//  GamePlayViewController.h
//  StrikeKnight
//
//  Created by chang on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDefine.h"

@interface GamePlayViewController : UIViewController {
	IBOutlet UIImageView* m_Puck;
	
	UIImageView* m_pUIPin[PIN_NUM];
	
	UIImageView *m_pUIBL;
	UIImageView *m_pUIFB;
	UIImageView *m_pUICharacter;

//#pragma mark Touch
	BOOL m_fPuckTouched;
	
	CGPoint m_ptCurrTouchPoint;
	CGPoint m_ptPrevTouchPoint;
	
//#pragma mark PuckParameter	
	float m_rPuckPosX;
	float m_rPuckPosY;
	
	float m_rVx;
	float m_rVy;
	float m_rScale;
	
	CGRect m_initRect;
	CGRect m_lastRect;
#pragma mark TIMER	
	NSTimer *m_puckMoveTimer;
	NSTimer *m_engineTimer;
	NSTimer *m_pinTimer;
	
	NSTimer *m_blfbMoveTimer;
	NSTimer *m_characterTimer;
	
	NSTimer *m_numTimer;
	int m_nPinBallIndex[PIN_NUM];
	int m_nBL_FBActionNum;
	
	int m_nCharacterAniNum;
	int m_nActionType;
	
	int m_nTotalScore;
	int m_nScoreChange;
	int m_nScoreStep;
	
	int m_nScorePlayerIdx;
	
	// Game Info	
	BOOL	m_fStrike;
	BOOL	m_fSpare;
	BOOL	m_fGameOver;
	BOOL	m_fDispPlayer;
	BOOL	m_fPinInitAppear;
	
	BOOL	m_fHelp;
	BOOL	m_fScoreChange;
	
	BOOL	m_fStart;
	BOOL	m_fPuckMoving;
	
	BOOL	m_fPinHitSound;
	BOOL	m_fBonus;
	
	IBOutlet UIView*	frameView;
	IBOutlet UIView*	playerView;
	IBOutlet UIView*	gameOverView;
	
	IBOutlet UIButton*	  m_btnHelp;

	// Move Image
	IBOutlet UIImageView* m_frameNumImg1;
	IBOutlet UIImageView* m_frameNumImg2;
	IBOutlet UIImageView* m_playerNumImg;
	
	// stop Image
	UIImageView* m_frameNum[2];
	
	UIImageView* firtScoreView[MAX_SCORE_LENGTH];
	UIImageView* secondScoreView[MAX_SCORE_LENGTH];
	UIImageView* thirdScoreView[MAX_SCORE_LENGTH];
	UIImageView* forthScoreView[MAX_SCORE_LENGTH];
	
	UIImageView* playerImgView[MAX_USER_NUM];
	
	UIImageView* tutorial;
}

-(void)initHitBall;
-(void)initHitUsrInfo;

-(void)releaseGameInfo;

#pragma mark TIMER
-(void)startPuckTimer;
-(void)stopPuckTimer;

-(void)startEngineTimer;
-(void)stopEngineTimer;

-(void)startPinTimer;
-(void)stopPinTimer;

-(void)startBLFBTimer;
-(void)stopBLFBTimer;

-(void)startCharacterTimer:(int)nAntionType;
-(void)stopCharacterTimer;

-(void)startNumTimer;
-(void)stopNumTimer;

#pragma mark FUNCTION_PASCAL
-(void)setPuckAppearParam;
-(void)setPlayerPuckView;

-(void)displayPuck;
-(void)dispAniView;

-(void)scaleDispView;

-(void)processPinBall:(int) nPinIndex;

-(void)searchUsrInfo;

-(int)getPinHitCount;
-(int)getTotalScore;

-(void)usrChangeSeleted;
-(void)	updateVelocity;

-(BOOL)isValidTouchMove:(CGPoint)pt;

-(BOOL)isValidStrike;
-(BOOL)isValidGameOver;
-(BOOL)isValidSpare;

-(BOOL)isValidPuckInitAppear;
-(BOOL)isValidLastBonus;

-(BOOL)isValidTouchDown;
-(BOOL)isValidScoreChange;

-(BOOL)isValidPinState;
-(BOOL)isValidMiddleLineOut;

-(BOOL)isValidHit;

#pragma mark MOVE_VIEW
-(void)animationView:(UIView*)view initFrame:(CGRect)sFrame endFrame:(CGRect)eFrame durationTime:(float)rTime;

#pragma mark IBAction
-(IBAction)onMenu;
-(IBAction)onHelp;

#pragma mark SCALE_IMAGE_MAKE
-(UIImage*)makeImageNumber:(int)nFirstScaleNum;

@end
