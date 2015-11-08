//
//  MoreViewController.h
//  StrikeKnight
//
//  Created by chang on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDefine.h"

@interface MoreViewController : UIViewController {
	IBOutlet UIImageView* soundOnView;
	IBOutlet UIImageView* soundOffView;	
	
	UIImageView* averageView[MAX_SCORE_LENGTH];
	UIImageView* bestView[MAX_SCORE_LENGTH];
	UIImageView* totalScoreView[9];
	
	int m_nAverage;
	int m_nBest;
	int m_nTotalScore;
}

-(void) iniSounImg;
-(void)calcSaveInfo;
#pragma mark IBAction

-(IBAction) onInstruction;
-(IBAction) onMoreGame;
-(IBAction) onCredits;
-(IBAction) onRemoveAds;
-(IBAction) onPlus;

-(IBAction) onSound;
-(IBAction) onBack;

@end
