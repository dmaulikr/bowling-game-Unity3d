//
//  ResourceManager.h
//  StrikeKnight
//
//  Created by Kim Jong Chol on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#ifndef _RESOURCE_MANAGER_H_
#define _RESOURCE_MANAGER_H_

#import "AudioToolBox/AudioToolBox.h"
#import "GameDefine.h"
#import "Global.h"

class ResourceManager
{
public:
	ResourceManager();
	virtual ~ResourceManager();
		
	static ResourceManager* sharedInstance();
	static void releaseInstance();
	
	static ResourceManager* shared;
	
	UIImage* CropImage(UIImage* pSourceImage, int nX, int nY, int nWidth, int nHeight, float rScale);
	
	///////////////Resource /////////
	
	// MainMenu
	
	UIImage* m_menuAniImg[MENU_ANI_NUM];
	
		// GamePlayView	
	UIImage* m_pinImg[PIN_IMGAE_NUM];
	UIImage* m_pBLImage[9];
	UIImage* m_pFBImage[9];
	UIImage* m_numberImg[NUMBER_IMAGE_NUM];//Light
	UIImage* m_pCryImage[12];
	UIImage* m_pDanceImage[21];
	UIImage* m_pFistPumpImage[10];
	UIImage* m_pGuitarImage[12];
	UIImage* m_pHighScoreImage[14];
	UIImage* m_pHShakeImage[14];
	UIImage* m_pLightningArcImage[16];	
	UIImage* m_pLightningHandImage[12];
	UIImage* m_pPinRainImage[20];
	UIImage* m_pPointImage[12];
	UIImage* m_pPunchImage[12];
	UIImage* m_pShieldImage[10];
	UIImage* m_pSplitImage[8];
	
	// Sound Manager	
	SystemSoundID m_clickSound;
	SystemSoundID m_missedSparePickupSound;
	SystemSoundID m_missedSplitPickupSound;
	SystemSoundID m_pinHitMultipleSound;
	SystemSoundID m_pinHitSingleSound;
	SystemSoundID m_puckSlidingSound;
	SystemSoundID m_sK_GuitarASound;
	SystemSoundID m_sK_GuitarBSound;
	SystemSoundID m_sK_GuitarCSound;
	SystemSoundID m_sparePickupCheerSound;
	SystemSoundID m_splitPickupSound;
	SystemSoundID m_strikePinsKnockingDownSound;
	SystemSoundID m_strikeCheerSound;
	SystemSoundID m_thunderAnimationSound;
	
	// Sound Play Function	
	void playSound(int nIndex);
};

//extern ResourceManager* shared;

#endif // _RESOURCE_MANAGER_H_