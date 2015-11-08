//
//  Global.h
//  StrikeKnight
//
//  Created by chang on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameDefine.h"
#import "Engine.h"

enum GAME_STATE{
	ONE_PLAY,
	TWO_PLAY,
	THREE_PLAY,
	FOUR_PLAY,
};

enum THORW_STATE {
	NON_THROW,
	FIRST_THROW,
	SECOND_THROW,
};

enum ActionType
{
	CRY_ANIMATION,
	DANCE_ANIMATION,
    FISTPUMP_ANIMATION,
    GUITAR_ANIMATION,
    HIGHSCORE_ANIMATION,
    HSHAKE_ANIMATION,
    LIGHTNINGARC_ANIMATION,
    LIGHTNINGHAND_ANIMATION,
    PINRAIN_ANIMATION,
    POINT_ANIMATION,
    PUNCH_ANIMATION,
    SHIELD_ANIMATION,
    SPLIT_ANIMATION,	
};

enum SoundType 
{
	NONE_SOUND,	
	CLICK_SOUND,
	MISSEDSPARE_SOUND,
	MISSEDSPLIT_SOUND,
	PINHITMULTIPLE_SOUND,
	PINHITSINGLE_SOUND,
	PUCKSLIDING_SOUND,
	SK_GUITARA_SOUND,
	SK_GUITARB_SOUND,
	SK_GUITARC_SOUND,
	SPAREPICKUP_SOUND,
	SPLITPICKUP_SOUND,
	STRIKEPINS_SOUND,
	STRIKECHEER_SOUND,
	THUNDERANIMATION_SOUND,
};

typedef struct{
	int nIdx;
	int nScore;
	int nLevel;
	int nStrike;
	int nThrowState;
	
	BOOL fPinHit[PIN_NUM]; // middle frame
} UserInfo;

typedef struct
{
	CGPoint sp;
	CGPoint ep;
} LINE_ELEMENT;


// FILE Save Struct
typedef struct
{
	int nScore;
} SAVE_INFO;

#ifndef Sqr//yhi
#define Sqr(x) ((x)*(x))
#endif

extern float	g_rX;
extern float	g_rY;

@class Engine;
extern Engine*	g_Engine;

extern BOOL		g_fPinballHit[PIN_NUM];

extern BOOL	g_fPuckInitAppear;

extern float  g_rVx;
extern float  g_rVy;
extern float  g_rScale;

extern UserInfo usrInfo[MAX_USER_NUM];

extern int		g_nUsrIdx;
extern int		g_nUsrState;

extern UIButton * g_btnContinue;

extern BOOL		g_fSound;

extern SAVE_INFO*	g_saveInfo;

extern int		g_nSaveNum;
//LINE FUNC
CGFloat getMaxXLine(LINE_ELEMENT line);
CGFloat getMinXLine(LINE_ELEMENT line);
CGFloat getMaxYLine(LINE_ELEMENT line);
CGFloat getMinYLine(LINE_ELEMENT line);

CGPoint	getAandB (LINE_ELEMENT	line);
CGPoint	getIntersectPos(LINE_ELEMENT l1, LINE_ELEMENT l2);

void dispNumView(UIImageView** numView, int  nNum, int nDispNum);
void initUsrInfo();

void loadUserInfo();
void saveUserInfo();