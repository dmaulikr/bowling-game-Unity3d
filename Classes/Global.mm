//
//  Global.m
//  StrikeKnight
//
//  Created by chang on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Global.h"
#import "ResourceManager.h"

#ifndef	GLOBAL_H
#define GLOBAL_H

float	g_rX = 1.0f;
float	g_rY = 1.0f;

Engine*	g_Engine = 0;

BOOL	g_fPinballHit[PIN_NUM];

BOOL	g_fPuckInitAppear = YES;

float  g_rVx = 1.0;
float  g_rVy = 1.0;
float  g_rScale = 1.0;

UserInfo usrInfo[MAX_USER_NUM];

int		g_nUsrIdx;
int		g_nUsrState;

UIButton * g_btnContinue;

BOOL		g_fSound = YES;

SAVE_INFO*	g_saveInfo = nil;

int		g_nSaveNum;
////LINE
CGFloat getMaxXLine(LINE_ELEMENT line)
{
	return (line.sp.x > line.ep.x)? line.sp.x:line.ep.x;
}

CGFloat getMinXLine(LINE_ELEMENT line)
{
	return (line.sp.x < line.ep.x)? line.sp.x:line.ep.x;
}

CGFloat getMaxYLine(LINE_ELEMENT line)
{
	return (line.sp.y > line.ep.y)? line.sp.y:line.ep.y;
}

CGFloat getMinYLine(LINE_ELEMENT line)
{
	return (line.sp.y < line.ep.y)? line.sp.y:line.ep.y;
}

CGPoint	getAandB (LINE_ELEMENT	line)
{
	CGFloat a, b;
	CGFloat dx = line.ep.x - line.sp.x;
	if (dx) 
		a = (line.ep.y - line.sp.y) / dx;
	else
		return CGPointZero;
	
	b = ((line.sp.y + line.ep.y) - a * (line.sp.x + line.ep.x))/2.0f;
	return CGPointMake(a, b);
}

CGPoint	getIntersectPos(LINE_ELEMENT l1, LINE_ELEMENT l2)
{
	CGFloat a, b, c, d;
	CGPoint ab =  getAandB(l1);
	CGPoint cd =  getAandB(l2);
	
	BOOL ab_valid = !CGPointEqualToPoint(ab, CGPointZero);
	BOOL cd_valid = !CGPointEqualToPoint(cd, CGPointZero);
	
	if (!ab_valid && !cd_valid) {
		return CGPointZero;
	}
	else if (!ab_valid){
		return CGPointMake(l1.sp.x, l1.sp.x * cd.x + cd.y);
	}
	else if (!cd_valid){
		return CGPointMake(l2.sp.x, l2.sp.x * ab.x + ab.y);
	}
	
	a = ab.x;
	b = ab.y;
	c = cd.x;
	d = cd.y;
	
	if (a - c == 0 ) {
		return CGPointZero;
	}
	
	CGFloat x = (d - b)/(a - c);
	if (x < getMinXLine(l1) || x > getMaxXLine(l1))
		return CGPointZero;
	if (x < getMinXLine(l2) || x > getMaxXLine(l2))
		return CGPointZero;
	
	CGFloat y = a * x + b;
	return CGPointMake(x, y);
}

void dispNumView(UIImageView** numView, int  nNum, int nDispNum)
{
	if (nDispNum >= 10000)
		return;
	
	int nNumLength = 0;
	int nDivided;
	
	BOOL fFlag = NO;
	for (int i = nNum - 1; i >= 0; i --)
	{
		nDivided = (int)pow(10.0, i);
		nNumLength = (nDispNum / nDivided);
		
		if (nNumLength > 0)
		{
			numView[i].image = ResourceManager::sharedInstance()->m_numberImg[nNumLength];
			nDispNum -= nDivided * nNumLength;
			fFlag = YES;
		}
		else if (i != 0 && nNumLength == 0 && !fFlag)
			numView[i].image = nil;
		else
			numView[i].image = ResourceManager::sharedInstance()->m_numberImg[nNumLength];
	}	
}

void initUsrInfo()
{
	memset(&usrInfo[0], 0, sizeof(usrInfo));
	
	for (int i = 0; i < MAX_USER_NUM; i ++)
	{
		for (int j = 0; j < PIN_NUM; j ++)			
			usrInfo[i].fPinHit[j] = NO;
			
		usrInfo[i].nLevel = 1;
	}	
}

void loadUserInfo(){
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *szFile = [documentsDirectory stringByAppendingPathComponent: @"gamedat.dat"];
	
	FILE *fp = fopen([szFile cStringUsingEncoding:NSASCIIStringEncoding],"rb+");
	
	if (fp == nil) 
		return;
	
	fread(&g_nSaveNum, sizeof(int), 1, fp);
	g_saveInfo = (SAVE_INFO*)malloc(sizeof(SAVE_INFO) * (g_nSaveNum + 1));
	memset(g_saveInfo, 0, sizeof(SAVE_INFO)*(g_nSaveNum+1));
	
	for (int i = 0; i < g_nSaveNum; i ++)
		fread(&g_saveInfo[i], sizeof(SAVE_INFO), 1, fp);
	
	fclose(fp);	
}

void saveUserInfo(){
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *szFile = [documentsDirectory stringByAppendingPathComponent:@"gamedat.dat"];
	
	FILE *fp = fopen([szFile cStringUsingEncoding:NSASCIIStringEncoding],"wb+");
	
	if (fp == nil)
		return ;
	
	fwrite(&g_nSaveNum, sizeof(int), 1, fp);
	
	for (int i = 0; i < g_nSaveNum; i ++)
		fwrite(&g_saveInfo[i], sizeof(SAVE_INFO), 1, fp);	
	
	free(g_saveInfo);
	fclose(fp);
}

#endif



