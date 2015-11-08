//
//  MultiPlayViewController.h
//  StrikeKnight
//
//  Created by chang on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MultiPlayViewController : UIViewController {
	IBOutlet UIImageView* playerImgView1;
	IBOutlet UIImageView* playerImgView2;
	IBOutlet UIImageView* playerImgView3;
	
	IBOutlet UIImageView* xImgView1;
	IBOutlet UIImageView* xImgView2;
	IBOutlet UIImageView* xImgView3;
	
	int nPlayerState;
}

-(void)initChectInfo;

-(IBAction)onStartGame;
-(IBAction)onBack;

@end
