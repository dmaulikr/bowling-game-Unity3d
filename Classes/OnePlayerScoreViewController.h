//
//  OnePlayerScoreViewController.h
//  StrikeKnight
//
//  Created by chang on 5/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameDefine.h"

@interface OnePlayerScoreViewController : UIViewController {
	UIImageView* scoreView[MAX_SCORE_LENGTH];
	UIImageView* averageView[MAX_SCORE_LENGTH];
	UIImageView* bestView[MAX_SCORE_LENGTH];
	UIImageView* totalScoreView[9];
	
	int m_nScore;
	int m_nAverage;
	int m_nBest;
	int m_nTotalScore;	
}

-(void)calcSaveInfo;

-(IBAction)onMenu;
-(IBAction)onPlus;
-(IBAction)onPlayAgain;

@end
