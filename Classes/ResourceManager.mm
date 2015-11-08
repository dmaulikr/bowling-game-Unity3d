//
//  ResourceManager.mm
//  StrikeKnight
//
//  Created by Kim Jong Chol on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ResourceManager.h"
#import "Global.h"

ResourceManager* ResourceManager::shared = nil;

ResourceManager* ResourceManager::sharedInstance() 
{
	if (shared == NULL)
		shared = new ResourceManager;
	
	return shared;
}

void ResourceManager::releaseInstance()
{
	if (shared != NULL)
		delete shared;
}

ResourceManager::ResourceManager()
{
	int i;
	
	int width, height;
	NSString* str;		
	UIImage* img;
	
	width = 206 * g_rX; height = 75 * g_rY;
//	img = [UIImage imageNamed:@"MM_FlashBoard.png"];		
	str = [[NSBundle mainBundle] pathForResource:@"MM_FlashBoard.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < MENU_ANI_NUM; i ++)
		m_menuAniImg[i] = CropImage(img, 0, height * i, width, height, 1.0);			
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"Pin_SS.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < PIN_IMGAE_NUM; i ++)
		m_pinImg[i] = CropImage(img, 67 * i * g_rX, 0, 67 * g_rX, 117 * g_rY, 1.0);
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"Board_Lighs.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < BL_IMAGE_NUM; i ++)
		m_pBLImage[i] = CropImage(img, 0, i * 25 * g_rY, 285 * g_rX, 25 * g_rY, 1.0);
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"Flash_Bar_SS.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < FB_IMAGE_NUM; i ++)
		m_pFBImage[i] = CropImage(img, 0, i * 92 * g_rY, 441 * g_rX, 92 * g_rY, 1.0);
	[img release];

	str = [[NSBundle mainBundle] pathForResource:@"number.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < NUMBER_IMAGE_NUM; i ++)
		m_numberImg[i] = CropImage(img, 35 * i * g_rX, 0, 35 * g_rX, 46 * g_rY, 1.0);
	[img release];
	
#ifdef ANI_RESOURCE_INCLUDE
	str = [[NSBundle mainBundle] pathForResource:@"Cry.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < CRY_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 6;
		nRow = i / 6;
		m_pCryImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"Dance.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < DANCE_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 7;
		nRow = i / 7;
		m_pDanceImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];

	
	str = [[NSBundle mainBundle] pathForResource:@"FistPump1.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < FISTPUMP_ANI_NUM / 2; i ++)
	{
		int nCol, nRow;
		nCol = i % 5;
		nRow = 0;
		m_pFistPumpImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 185 * g_rY, 230 * g_rX, 185 * g_rY, 1.0);
	}
	[img release];
	str = [[NSBundle mainBundle] pathForResource:@"FistPump2.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = FISTPUMP_ANI_NUM / 2; i < FISTPUMP_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 5;
		nRow = 0;
		m_pFistPumpImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 185 * g_rY, 230 * g_rX, 185 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"Guitar.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < GUITAR_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 6;
		nRow = i / 6;
		m_pGuitarImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"HighScore.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < HIGHSCORE_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 7;
		nRow = i / 7;
		m_pHighScoreImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"HShake.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < HSHAKE_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 7;
		nRow = i / 7;
		m_pHShakeImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"LightningArc.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < LIGHTNINGARC_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 8;
		nRow = i / 8;
		m_pLightningArcImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];

	
	str = [[NSBundle mainBundle] pathForResource:@"LightningHand.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < LIGHTNINGHAND_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 6;
		nRow = i / 6;
		m_pLightningHandImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"PinRain1.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < PINRAIN_ANI_NUM / 4; i ++)
	{
		int nCol, nRow;
		nCol = i % 5;
		nRow = 0;
		m_pPinRainImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	str = [[NSBundle mainBundle] pathForResource:@"PinRain2.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = PINRAIN_ANI_NUM / 4; i < PINRAIN_ANI_NUM / 2; i ++)
	{
		int nCol, nRow;
		nCol = i % 5;
		nRow = 0;
		m_pPinRainImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	str = [[NSBundle mainBundle] pathForResource:@"PinRain1.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = PINRAIN_ANI_NUM / 2; i < PINRAIN_ANI_NUM * 3 / 4; i ++)
	{
		int nCol, nRow;
		nCol = i % 5;
		nRow = 1;
		m_pPinRainImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	str = [[NSBundle mainBundle] pathForResource:@"PinRain2.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = PINRAIN_ANI_NUM * 3 / 4; i < PINRAIN_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 5;
		nRow = 1;
		m_pPinRainImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];	
	
	str = [[NSBundle mainBundle] pathForResource:@"Point.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < POINT_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 6;
		nRow = i / 6;
		m_pPointImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"Punch.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < PUNCH_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 6;
		nRow = i / 6;
		m_pPunchImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 186 * g_rY, 230 * g_rX, 186 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"shield1.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < SHIELD_ANI_NUM / 2; i ++)
	{
		int nCol, nRow;
		nCol = i % 5;
		nRow = 0;
		m_pShieldImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 185 * g_rY, 230 * g_rX, 185 * g_rY, 1.0);
	}
	[img release];
	str = [[NSBundle mainBundle] pathForResource:@"shield2.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = SHIELD_ANI_NUM / 2; i < SHIELD_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 5;
		nRow = 0;
		m_pShieldImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 185 * g_rY, 230 * g_rX, 185 * g_rY, 1.0);
	}
	[img release];
	
	str = [[NSBundle mainBundle] pathForResource:@"Split.png" ofType:nil];	
	img = [[UIImage alloc] initWithContentsOfFile:str];	
	for (i = 0; i < SPLITIMAGE_ANI_NUM; i ++)
	{
		int nCol, nRow;
		nCol = i % 8;
		nRow = i / 8;
		m_pSplitImage[i] = CropImage(img, nCol * 230 * g_rX, nRow * 185 * g_rY, 230 * g_rX, 185 * g_rY, 1.0);
	}
	[img release];

	//save 
//	NSString* str;
//	for (i = 0; i < PUNCH_ANI_NUM; i ++)
//	{
//		str = [NSString stringWithFormat:@"%d.png", i];
//		
//		NSData* Dat = UIImagePNGRepresentation(m_pPunchImage[i]);
//		[Dat writeToFile:str atomically:YES];
//	}
	
	NSURL* urlSound;
	
	str = [[NSBundle mainBundle] pathForResource:@"Click.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_clickSound);	
	
	str = [[NSBundle mainBundle] pathForResource:@"MissedSparePickup.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_missedSparePickupSound);	

	str = [[NSBundle mainBundle] pathForResource:@"MissedSplitPickup.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_missedSplitPickupSound);	

	str = [[NSBundle mainBundle] pathForResource:@"pinHitMultiple.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_pinHitMultipleSound);	

	str = [[NSBundle mainBundle] pathForResource:@"pinHitSingle.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_pinHitSingleSound);	

	str = [[NSBundle mainBundle] pathForResource:@"PuckSliding1.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_puckSlidingSound);	

	str = [[NSBundle mainBundle] pathForResource:@"SK_GuitarA.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_sK_GuitarASound);	

	str = [[NSBundle mainBundle] pathForResource:@"SK_GuitarB.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_sK_GuitarBSound);	

	str = [[NSBundle mainBundle] pathForResource:@"SK_GuitarC.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_sK_GuitarCSound);	

	str = [[NSBundle mainBundle] pathForResource:@"SparePickupCheer.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_sparePickupCheerSound);	

	str = [[NSBundle mainBundle] pathForResource:@"SplitPickup.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_splitPickupSound);	

	str = [[NSBundle mainBundle] pathForResource:@"Strike pins knocking down.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_strikePinsKnockingDownSound);	

	str = [[NSBundle mainBundle] pathForResource:@"StrikeCheer.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_strikeCheerSound);	

	str = [[NSBundle mainBundle] pathForResource:@"ThunderAnimation.wav" ofType:nil];
	urlSound = [NSURL fileURLWithPath:str];
	AudioServicesCreateSystemSoundID((CFURLRef)urlSound, &m_thunderAnimationSound);	
#endif
}

ResourceManager::~ResourceManager()
{
	int i;
	
	for (i = 0; i < MENU_ANI_NUM; i ++)
	{
		if (m_menuAniImg[i] != nil)
			[m_menuAniImg[i] release];	
	}
	
	for (i = 0; i < PIN_IMGAE_NUM; i ++)
	{
		if (m_pinImg[i] != nil)
			[m_pinImg[i] release];
	}
	
	for (i = 0; i < BL_IMAGE_NUM; i ++)
	{
		if (m_pBLImage[i] != nil)
			[m_pBLImage[i] release];
	}
	
	for (i = 0; i < FB_IMAGE_NUM; i ++)
	{
		if (m_pFBImage[i] != nil)
			[m_pFBImage[i] release];
	}
	for (i = 0; i < NUMBER_IMAGE_NUM; i ++)
	{
		if (m_numberImg[i] != nil)
			[m_numberImg[i] release];
		
	}	
	
	for (i = 0; i < CRY_ANI_NUM; i ++)
	{
		if (m_pCryImage[i] != nil)
			[m_pCryImage[i] release];
	}
	
	for (i = 0; i < DANCE_ANI_NUM; i ++)
	{
		if (m_pDanceImage[i] != nil)
			[m_pDanceImage[i] release];
	}
	
	for (i = 0; i < FISTPUMP_ANI_NUM; i ++)
	{
		if (m_pFistPumpImage[i] != nil)
			[m_pFistPumpImage[i] release];
	}
	
	for (i = 0; i < GUITAR_ANI_NUM; i ++)
	{
		if (m_pGuitarImage[i] != nil)
			[m_pGuitarImage[i] release];
	}
	
	for (i = 0; i < HIGHSCORE_ANI_NUM; i ++)
	{
		if (m_pHighScoreImage[i] != nil)
			[m_pHighScoreImage[i] release];
	}
	
	for (i = 0; i < HSHAKE_ANI_NUM; i ++)
	{
		if (m_pHShakeImage[i] != nil)
			[m_pHShakeImage[i] release];
	}
	
	for (i = 0; i < LIGHTNINGARC_ANI_NUM; i ++)
	{
		if (m_pLightningArcImage[i] != nil)
			[m_pLightningArcImage[i] release];
	}
	
	for (i = 0; i < LIGHTNINGHAND_ANI_NUM; i ++)
	{
		if (m_pLightningHandImage[i] != nil)
			[m_pLightningHandImage[i] release];
	}
	
	for (i = 0; i < PINRAIN_ANI_NUM; i ++)
	{
		if (m_pPinRainImage[i] != nil)
			[m_pPinRainImage[i] release];
	}
	
	for (i = 0; i < POINT_ANI_NUM; i ++)
	{
		if (m_pPointImage[i] != nil)
			[m_pPointImage[i] release];
	}
	
	for (i = 0; i < PUNCH_ANI_NUM; i ++)
	{
		if (m_pPunchImage[i] != nil)
			[m_pPunchImage[i] release];
	}
	
	for (i = 0; i < SHIELD_ANI_NUM; i ++)
	{
		if (m_pShieldImage[i] != nil)
			[m_pShieldImage[i] release];
	}
	
	for (i = 0; i < SPLITIMAGE_ANI_NUM; i ++)
	{
		if (m_pSplitImage[i] != nil)
			[m_pSplitImage[i] release];
	}
	
	AudioServicesDisposeSystemSoundID(m_clickSound);
	AudioServicesDisposeSystemSoundID(m_missedSparePickupSound);
	AudioServicesDisposeSystemSoundID(m_missedSplitPickupSound);
	AudioServicesDisposeSystemSoundID(m_pinHitMultipleSound);
	AudioServicesDisposeSystemSoundID(m_pinHitSingleSound);
	AudioServicesDisposeSystemSoundID(m_puckSlidingSound);
	AudioServicesDisposeSystemSoundID(m_sK_GuitarASound);
	AudioServicesDisposeSystemSoundID(m_sK_GuitarBSound);
	AudioServicesDisposeSystemSoundID(m_sK_GuitarCSound);
	AudioServicesDisposeSystemSoundID(m_sparePickupCheerSound);
	AudioServicesDisposeSystemSoundID(m_splitPickupSound);
	AudioServicesDisposeSystemSoundID(m_strikePinsKnockingDownSound);
	AudioServicesDisposeSystemSoundID(m_strikeCheerSound);
	AudioServicesDisposeSystemSoundID(m_thunderAnimationSound);
}

UIImage* ResourceManager::CropImage(UIImage* pSourceImage, int nX, int nY, int nWidth, int nHeight, float rScale)
{
	CGColorSpaceRef colorSpace;
	
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	size_t pixelsWidth, pixelsHight;
	
	pixelsWidth = nWidth * rScale;
	pixelsHight = nHeight * rScale;
	
	bitmapBytesPerRow   = (pixelsWidth * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHight);
	
	int nSrcImageWidth, nSrcImageHeight;
	
	nSrcImageWidth = [pSourceImage size].width * g_rX;
	nSrcImageHeight = [pSourceImage size].height * g_rY;	
	
	colorSpace = CGColorSpaceCreateDeviceRGB();
	
	if (colorSpace == NULL)
		return NULL;
	
	CGContextRef context = CGBitmapContextCreate (NULL,
												  pixelsWidth,
												  pixelsHight,
												  8,      
												  bitmapBytesPerRow,
												  colorSpace,
												  kCGImageAlphaPremultipliedLast);	
	
	CGContextTranslateCTM(context, -nX, -(nSrcImageHeight - (nY + nHeight)));
	CGContextDrawImage(context, CGRectMake(0, 0, nSrcImageWidth, nSrcImageHeight), [pSourceImage CGImage]);
	
	CGImageRef ref = CGBitmapContextCreateImage(context);
	
	UIImage* newImage = [[UIImage alloc] initWithCGImage:ref];
	
	CGColorSpaceRelease(colorSpace);
	CGImageRelease(ref);
	CGContextRelease(context);
	
	return newImage;	
}

void ResourceManager::playSound(int nIndex)
{
	if (!g_fSound)
		return;
	
	if (nIndex == CLICK_SOUND)
		AudioServicesPlaySystemSound(m_clickSound);	
	else if (nIndex == MISSEDSPARE_SOUND)
		AudioServicesPlaySystemSound(m_missedSparePickupSound);	
	else if (nIndex == MISSEDSPLIT_SOUND)
		AudioServicesPlaySystemSound(m_missedSplitPickupSound);	
	else if (nIndex == PINHITMULTIPLE_SOUND)
		AudioServicesPlaySystemSound(m_pinHitMultipleSound);	
	else if (nIndex == PINHITSINGLE_SOUND)
		AudioServicesPlaySystemSound(m_pinHitSingleSound);	
	else if (nIndex == PUCKSLIDING_SOUND)
		AudioServicesPlaySystemSound(m_puckSlidingSound);	
	else if (nIndex == SK_GUITARA_SOUND)
		AudioServicesPlaySystemSound(m_sK_GuitarASound);	
	else if (nIndex == SK_GUITARB_SOUND)
		AudioServicesPlaySystemSound(m_sK_GuitarBSound);	
	else if (nIndex == SK_GUITARC_SOUND)
		AudioServicesPlaySystemSound(m_sK_GuitarCSound);	
	else if (nIndex == SPAREPICKUP_SOUND)
		AudioServicesPlaySystemSound(m_sparePickupCheerSound);	
	else if (nIndex == SPLITPICKUP_SOUND)
		AudioServicesPlaySystemSound(m_splitPickupSound);	
	else if (nIndex == STRIKEPINS_SOUND)
		AudioServicesPlaySystemSound(m_strikePinsKnockingDownSound);	
	else if (nIndex == STRIKECHEER_SOUND)
		AudioServicesPlaySystemSound(m_strikeCheerSound);	
	else if (nIndex == THUNDERANIMATION_SOUND)
		AudioServicesPlaySystemSound(m_thunderAnimationSound);	

}