//
//  StrikeKnightViewController.m
//  StrikeKnight
//
//  Created by chang on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StrikeKnightViewController.h"

#import "Global.h"
#import "ResourceManager.h"

#import	"GamePlayViewController.h"
#import "MultiPlayViewController.h"
#import "MoreViewController.h"
#import "RemoveAdsViewController.h"

#import "Engine.h"
#import "Global.h"

@implementation StrikeKnightViewController

-(void)viewDidLoad {
    [super viewDidLoad];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
		g_rX = 320.0 / 768;  g_rY = 480.0 / 1024;
	}
		
	g_btnContinue = m_btnContinue;
	g_btnContinue.enabled = NO;
	
	createEngine();
	//Resource Load
	ResourceManager::sharedInstance();
	initUsrInfo();
	
	int width, height;
	
	width = 206 * g_rX; height = 75 * g_rY;
	
	m_aniIndex = 0;
	if (menuImg == nil)
		menuImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
	
	[self.view addSubview:menuImg];
	
	[menuImg setFrame:CGRectMake(84 * g_rX, 388 * g_rY, width, height)];
	
	if (m_timer == nil)
		m_timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(menuAni:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];	
}

- (void)viewDidUnload {

}

- (void)dealloc {
	ResourceManager::releaseInstance();	
	
	[self stopMenuAni];
	
	if (menuImg != nil)
		[menuImg release];
	
    [super dealloc];
}

#pragma mark IBAction

-(IBAction)onContinue{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	GamePlayViewController* gameViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		gameViewController = [[GamePlayViewController alloc] initWithNibName:@"GamePlayViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		gameViewController = [[GamePlayViewController alloc] initWithNibName:@"GamePlayViewController_iPad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:gameViewController animated:YES];
	
	[gameViewController release];
}

-(IBAction)onSinglePlayer{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	GamePlayViewController* gameViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		gameViewController = [[GamePlayViewController alloc] initWithNibName:@"GamePlayViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		gameViewController = [[GamePlayViewController alloc] initWithNibName:@"GamePlayViewController_iPad" bundle:[NSBundle mainBundle]];
	
	g_nUsrIdx = 0;
	g_nUsrState = ONE_PLAY;
	initUsrInfo();
	
	[self.navigationController pushViewController:gameViewController animated:YES];
	
	[gameViewController release];
}

-(IBAction)onMultiPlayer{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	MultiPlayViewController* multiViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		multiViewController = [[MultiPlayViewController alloc] initWithNibName:@"MultiPlayViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		multiViewController = [[MultiPlayViewController alloc] initWithNibName:@"MultiPlayViewController_iPad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:multiViewController animated:YES];
	
	[multiViewController release];
}

-(IBAction)onMore{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	MoreViewController* moreViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		moreViewController = [[MoreViewController alloc] initWithNibName:@"MoreViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		moreViewController = [[MoreViewController alloc] initWithNibName:@"MoreViewController_iPad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:moreViewController animated:YES];
	
	[moreViewController release];
}

-(IBAction)onRemoveAds{
	ResourceManager::sharedInstance()->playSound(CLICK_SOUND);
	RemoveAdsViewController* removeViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
		removeViewController = [[RemoveAdsViewController alloc] initWithNibName:@"RemoveAdsViewController_iPhone" bundle:[NSBundle mainBundle]];
	else 
		removeViewController = [[RemoveAdsViewController alloc] initWithNibName:@"RemoveAdsViewController_iPad" bundle:[NSBundle mainBundle]];
	
	[self.navigationController pushViewController:removeViewController animated:YES];
	
	[removeViewController release];
}

#pragma mark TIMER

-(void)menuAni:(id)sender{
	menuImg.image = ResourceManager::sharedInstance()->m_menuAniImg[m_aniIndex];
	
	m_aniIndex ++;
	m_aniIndex = m_aniIndex >= MENU_ANI_NUM ? 0 : m_aniIndex;
}

-(void)stopMenuAni{
	if (m_timer != nil)
	{
		[m_timer invalidate];
		m_timer = nil;
	}
}

@end