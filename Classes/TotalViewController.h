//
//  TotalViewController.h
//  StrikeKnight
//
//  Created by chang on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameDefine.h"

@interface TotalViewController : UIViewController {
	IBOutlet UIImageView* firstImg;
	IBOutlet UIImageView* secondImg;
	IBOutlet UIImageView* thirdImg;
	IBOutlet UIImageView* fourthImg;
	
	UIImageView* firtScoreView[MAX_SCORE_LENGTH];
	UIImageView* secondScoreView[MAX_SCORE_LENGTH];
	UIImageView* thirdScoreView[MAX_SCORE_LENGTH];
	UIImageView* forthScoreView[MAX_SCORE_LENGTH];
}

-(void)setScoreSort;

-(IBAction)onMenu;
-(IBAction)onPlus;
-(IBAction)onPlayAgain;

@end
