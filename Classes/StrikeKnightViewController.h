//
//  StrikeKnightViewController.h
//  StrikeKnight
//
//  Created by chang on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrikeKnightViewController : UIViewController {
	NSTimer* m_timer;
	
	UIImageView* menuImg;
	IBOutlet UIButton* m_btnContinue;
	
	int m_aniIndex;
}

-(IBAction)onContinue;
-(IBAction)onSinglePlayer;
-(IBAction)onMultiPlayer;
-(IBAction)onMore;

-(IBAction)onRemoveAds;

#pragma mark TIMER
-(void)stopMenuAni;

@end

